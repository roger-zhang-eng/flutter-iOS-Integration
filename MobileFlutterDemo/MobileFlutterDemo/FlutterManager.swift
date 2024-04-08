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
    
    lazy var flutterEngine = FlutterEngine(name: "my flutter engine")
    
    private var isInitialised = false
    
    private init () {}
    
    func setup() {
        guard isInitialised == false else {
            return
        }
        
        flutterEngine.run()
        GeneratedPluginRegistrant.register(with: flutterEngine)
        
        isInitialised = true
    }
    
    func entryScreen() -> UIViewController {
        FlutterViewController(engine: flutterEngine, nibName: nil, bundle: nil)
    }
    
    func secondScreen() -> UIViewController {
        let bankListVC = FlutterViewController(engine: flutterEngine, nibName: "BankListPage", bundle: nil)
        
        return bankListVC
    }

}
