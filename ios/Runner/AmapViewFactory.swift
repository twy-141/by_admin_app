import Foundation
import Flutter
import MAMapKit

class AmapViewFactory: NSObject, FlutterPlatformViewFactory {
    private var messenger: FlutterBinaryMessenger

    init(messenger: FlutterBinaryMessenger) {
        self.messenger = messenger
        super.init()
    }

    func create(withFrame frame: CGRect, viewIdentifier viewId: Int64, arguments args: Any?) -> FlutterPlatformView {
        return AmapPlatformView(frame: frame, args: args as? [String: Any])
    }
}

class AmapPlatformView: NSObject, FlutterPlatformView {
    private var containerView: UIView
    private var mapView: MAMapView

    init(frame: CGRect, args: [String: Any]?) {
        mapView = MAMapView(frame: frame)
        containerView = UIView(frame: frame)
        super.init()

        mapView.showsUserLocation = true
        mapView.userTrackingMode = .follow

        let lat = args?["lat"] as? Double ?? 39.9
        let lng = args?["lng"] as? Double ?? 116.3
        mapView.setCenter(CLLocationCoordinate2D(latitude: lat, longitude: lng), animated: false)
        mapView.zoomLevel = 12

        containerView.addSubview(mapView)
    }

    func view() -> UIView {
        return containerView
    }
}

