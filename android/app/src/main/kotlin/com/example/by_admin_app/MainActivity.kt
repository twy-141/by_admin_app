package com.example.by_admin_app

import com.amap.api.maps.MapView
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodChannel
import android.content.Context
import android.content.ContextWrapper
import android.content.Intent
import android.content.IntentFilter
import android.os.BatteryManager
import android.os.Build.VERSION
import android.os.Build.VERSION_CODES
import android.view.View
import com.amap.api.location.AMapLocationClient
import com.amap.api.location.AMapLocationClientOption
import com.amap.api.maps.CameraUpdateFactory
import com.amap.api.maps.MapsInitializer
import com.amap.api.maps.model.LatLng
import io.flutter.plugin.common.BinaryMessenger
import io.flutter.plugin.common.StandardMessageCodec
import io.flutter.plugin.platform.PlatformView
import io.flutter.plugin.platform.PlatformViewFactory

class MainActivity : FlutterActivity() {
    private val CHANNEL = "com.example.by_admin_app/battery"

    override fun configureFlutterEngine(flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)

        flutterEngine.platformViewsController.registry.registerViewFactory(
            "com.example.by_admin_app/mapview",
            AmapViewFactory(flutterEngine.dartExecutor.binaryMessenger)
        )

        MethodChannel(
            flutterEngine.dartExecutor.binaryMessenger,
            CHANNEL
        ).setMethodCallHandler { call, result ->
            if (call.method == "getBatteryLevel") { // 获取电量
                val batteryLevel = getBatteryLevel()

                if (batteryLevel != -1) {
                    result.success(batteryLevel)
                } else {
                    result.error("UNAVAILABLE", "Battery level not available.", null)
                }
            } else if (call.method == "getSingleLocation") {
                requestSingleLocation(result)
            } else {
                result.notImplemented()
            }
            // This method is invoked on the main thread.
            // TODO
        }
    }

    // 添加单次定位方法
    private fun requestSingleLocation(result: MethodChannel.Result) {
        AMapLocationClient.updatePrivacyShow(this, true, true)
        AMapLocationClient.updatePrivacyAgree(this, true)

        val locationClient = AMapLocationClient(this)
        val locationOption = AMapLocationClientOption().apply {
            locationMode = AMapLocationClientOption.AMapLocationMode.Hight_Accuracy
            isOnceLocation = true
            isNeedAddress = true
            isOnceLocationLatest = true
        }
        locationClient.setLocationOption(locationOption)

        locationClient.setLocationListener { location ->
            if (location != null && location.errorCode == 0) {
                val locationMap = mapOf(
                    "latitude" to location.latitude,
                    "longitude" to location.longitude,
                    "address" to (location.address ?: ""),
                    "city" to (location.city ?: "")
                )
                result.success(locationMap)
            } else {
                result.error(
                    "LOCATION_ERROR",
                    "定位失败: ${location?.errorCode ?: "未知错误"}",
                    null
                )
            }
            locationClient.onDestroy()
        }

        locationClient.startLocation()
    }

    private fun getBatteryLevel(): Int {
        val batteryLevel: Int
        if (VERSION.SDK_INT >= VERSION_CODES.LOLLIPOP) {
            val batteryManager = getSystemService(Context.BATTERY_SERVICE) as BatteryManager
            batteryLevel = batteryManager.getIntProperty(BatteryManager.BATTERY_PROPERTY_CAPACITY)
        } else {
            val intent = ContextWrapper(applicationContext).registerReceiver(
                null,
                IntentFilter(Intent.ACTION_BATTERY_CHANGED)
            )
            batteryLevel =
                intent!!.getIntExtra(BatteryManager.EXTRA_LEVEL, -1) * 100 / intent.getIntExtra(
                    BatteryManager.EXTRA_SCALE,
                    -1
                )
        }

        return batteryLevel
    }

    // 创建地图
    class AmapViewFactory(private val messenger: BinaryMessenger) :
        PlatformViewFactory(StandardMessageCodec.INSTANCE) {
        override fun create(context: Context, viewId: Int, args: Any?): PlatformView {
            return AmapPlatformView(context, args as? Map<String, Any>)
        }
    }

    // 创建地图
    class AmapPlatformView(context: Context, params: Map<String, Any>?) : PlatformView {
        private val mapView: MapView

        init {
            // ✅ 必须在创建 MapView 前调用隐私合规接口
            MapsInitializer.updatePrivacyShow(context, true, true)
            MapsInitializer.updatePrivacyAgree(context, true)

            mapView = MapView(context)
            mapView.onCreate(null)

            val aMap = mapView.map
            // 开启定位蓝点
            aMap.isMyLocationEnabled = true

            val lat = params?.get("lat") as? Double ?: 39.9
            val lng = params?.get("lng") as? Double ?: 116.3
            val camera = CameraUpdateFactory.newLatLngZoom(LatLng(lat, lng), 12f)
            aMap.moveCamera(camera)
        }

        override fun getView(): View = mapView
        override fun dispose() {
            mapView.onDestroy()
        }
    }
}
