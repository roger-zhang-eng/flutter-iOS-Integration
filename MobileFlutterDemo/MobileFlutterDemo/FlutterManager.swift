//
//  FlutterManager.swift
//  MobileFlutterDemo
//
//  Created by Roger on 8/4/2024.
//

import Foundation
import Flutter
import FlutterPluginRegistrant
import UIKit
import mybatteryplugin

final class FlutterManager {
    
    static let shared = FlutterManager()
    
    var dismissFlutterCallback: (() -> Void)?
    private var tokenID = 0
    private var engines: FlutterEngineGroup!
    
    private var isInitialised = false
	private let channel = "app-channel"
	lazy private var flutterEngine = engines.makeEngine(withEntrypoint: "secondary", libraryURI: nil)
    
    private init () {}
    
    func setup() {
        guard isInitialised == false else {
            return
        }
        
        engines = FlutterEngineGroup(name: "multiple-flutters", project: nil)
		
		flutterEngine.run()
		GeneratedPluginRegistrant.register(with: flutterEngine)
		MybatterypluginPlugin.shared.methodChannelHandler = methodChannelHandler
		
        isInitialised = true
    }
    
    func entryScreen() -> UIViewController {
        
        FlutterViewController(engine: engines.makeEngine(with: nil), nibName: nil, bundle: nil)
    }
    
    func secondScreen() -> UIViewController {
        //let secondScreenEngine = engines.makeEngine(withEntrypoint: "secondary", libraryURI: nil)
        let secondVC = FlutterViewController(engine: flutterEngine, nibName: nil, bundle: nil)
		let methodChannel = FlutterMethodChannel(name: channel, binaryMessenger: flutterEngine.binaryMessenger)
		
		methodChannel.setMethodCallHandler { [unowned self] (call: FlutterMethodCall, result: FlutterResult) in
			if call.method == "getDataFromNative" {
				let data = getDataFromNative()
				result(data)
            } else if call.method == "dismissScreen" {
                dismissScreen()
                result("Dismiss Success")
            } else {
				result(FlutterMethodNotImplemented)
			}
		}
                
        return secondVC
    }

}

private extension FlutterManager {
	
	// Pass data from native to flutter screen
	func getDataFromNative() -> String {
		return "Data from Native"
	}
    
    func dismissScreen() {
        dismissFlutterCallback?()
    }
	
	func methodChannelHandler(_ request: MybatterypluginPlugin.BPMethodChannelRequest) -> MybatterypluginPlugin.BPMethodChannelResult {
		switch request {
		case .auth:
			print("Native methodChannelHandler: get auth request")
			tokenID += 1
			let token = FlutterAuthToken(authToken: "native-\(tokenID)")
			return .jsonData(token.jsonString() ?? "")
		default:
			return .void
		}
	}
	
}
