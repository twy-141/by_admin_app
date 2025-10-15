import Flutter
import UIKit
import AMapFoundationKit
import AMapLocationKit
import MAMapKit
import AMapSearchKit


@main
@objc class AppDelegate: FlutterAppDelegate {
  override func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
  ) -> Bool {
    // ✅ 高德隐私合规设置（必须最先调用）
    AMapLocationManager.updatePrivacyShow(.didShow, privacyInfo: .didContain)
    AMapLocationManager.updatePrivacyAgree(.didAgree)
      
    MAMapView.updatePrivacyShow(.didShow, privacyInfo: .didContain)
    MAMapView.updatePrivacyAgree(.didAgree)

    AMapSearchAPI.updatePrivacyShow(.didShow, privacyInfo: .didContain)
    AMapSearchAPI.updatePrivacyAgree(.didAgree)

    // 设置高德 Key
    AMapServices.shared().apiKey = "115bd29e9772c1d95fb75554d2f1d658"

    // 安全解包 registrar
    if let registrar = self.registrar(forPlugin: "BatteryPlugin") {
      let channel = FlutterMethodChannel(name: "com.example.by_admin_app/battery",
                                         binaryMessenger: registrar.messenger())
      channel.setMethodCallHandler { call, result in
        if call.method == "getBatteryLevel" {
          result(self.getBatteryLevel())
        } else if call.method == "getSingleLocation" {
          LocationHandler.shared.requestSingleLocation(result: result)
        } else {
          result(FlutterMethodNotImplemented)
        }
      }

      // 注册 PlatformView
      registrar.register(
        AmapViewFactory(messenger: registrar.messenger()),
        withId: "com.example.by_admin_app/mapview"
      )
    }

    // Flutter 插件注册
    GeneratedPluginRegistrant.register(with: self)

    return super.application(application, didFinishLaunchingWithOptions: launchOptions)
  }

  private func getBatteryLevel() -> Int {
    UIDevice.current.isBatteryMonitoringEnabled = true
    return Int(UIDevice.current.batteryLevel * 100)
  }
}
