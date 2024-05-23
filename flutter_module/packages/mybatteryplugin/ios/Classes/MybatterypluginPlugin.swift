import Flutter
import UIKit

public class MybatterypluginPlugin: NSObject, FlutterPlugin {
	
	public enum BPMethodChannelResult {
		case success
		case fail
		case jsonData(String)
		case void
	}
	
	public enum BPMethodChannelRequest {
		case auth
		case event
		case screenDismiss
	}

	var counter  = 0;
	
	public var methodChannelHandler: ((BPMethodChannelRequest) -> BPMethodChannelResult)?

	public static var shared = MybatterypluginPlugin()

	public static func register(with registrar: FlutterPluginRegistrar) {
		let channel = FlutterMethodChannel(name: "mybatteryplugin", binaryMessenger: registrar.messenger())
		registrar.addMethodCallDelegate(shared, channel: channel)
	}
	
	private override init() {}

	public func handle(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
		switch call.method {
		case "getPlatformVersion":
			var ret = ""
			if let nativeHandler = methodChannelHandler {
				let value = nativeHandler(.auth)
				switch value {
				case .jsonData(let jsonString):
					ret = jsonString
				default:
					break
				}
			}
			result(ret)
		case "getBatteryLevel":
			counter += 1
			result(36 + counter)
		default:
			result(FlutterMethodNotImplemented)
		}
	}
}
