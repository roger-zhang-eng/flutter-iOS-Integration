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

final class FlutterManager {
    
    static let shared = FlutterManager()
    
    var dismissFlutterCallback: (() -> Void)?
    
    private var engines: FlutterEngineGroup!
    
    private var isInitialised = false
	private let channel = "app-channel"
    
    private init () {}
    
    func setup() {
        guard isInitialised == false else {
            return
        }
        
        engines = FlutterEngineGroup(name: "multiple-flutters", project: nil)
        
        isInitialised = true
    }
    
    func entryScreen() -> UIViewController {
        
        FlutterViewController(engine: engines.makeEngine(with: nil), nibName: nil, bundle: nil)
    }
    
    func secondScreen() -> UIViewController {
        let secondScreenEngine = engines.makeEngine(withEntrypoint: "secondary", libraryURI: nil)
        let secondVC = FlutterViewController(engine: secondScreenEngine, nibName: nil, bundle: nil)
		let methodChannel = FlutterMethodChannel(name: channel, binaryMessenger: secondVC.binaryMessenger)
		
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
	
}
