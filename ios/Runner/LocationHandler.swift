import Foundation
import AMapLocationKit
import Flutter

class LocationHandler: NSObject, AMapLocationManagerDelegate {
    static let shared = LocationHandler()
    private var locationManager: AMapLocationManager?
    private var result: FlutterResult?

    func requestSingleLocation(result: @escaping FlutterResult) {
        self.result = result
        locationManager = AMapLocationManager()
        locationManager?.delegate = self
        locationManager?.desiredAccuracy = kCLLocationAccuracyHundredMeters
        locationManager?.locationTimeout = 6
        locationManager?.reGeocodeTimeout = 3
        locationManager?.requestLocation(withReGeocode: true, completionBlock: { location, regeocode, error in
            if let loc = location, error == nil {
                let data: [String: Any] = [
                    "latitude": loc.coordinate.latitude,
                    "longitude": loc.coordinate.longitude,
                    "address": regeocode?.formattedAddress ?? "",
                    "city": regeocode?.city ?? ""
                ]
                result(data)
            } else {
                result(FlutterError(code: "LOCATION_ERROR",
                                    message: "定位失败: \(error?.localizedDescription ?? "未知错误")",
                                    details: nil))
            }
        })
    }
}
