import Flutter
import UIKit

public class MybatterypluginPlugin: NSObject, FlutterPlugin {
	
	var counter  = 0;
	
  public static func register(with registrar: FlutterPluginRegistrar) {
    let channel = FlutterMethodChannel(name: "mybatteryplugin", binaryMessenger: registrar.messenger())
    let instance = MybatterypluginPlugin()
    registrar.addMethodCallDelegate(instance, channel: channel)
  }

  public func handle(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
    switch call.method {
    case "getPlatformVersion":
      result("iOS " + UIDevice.current.systemVersion)
	case "getBatteryLevel":
		counter += 1;
		result(36 + counter)
    default:
      result(FlutterMethodNotImplemented)
    }
  }
}
