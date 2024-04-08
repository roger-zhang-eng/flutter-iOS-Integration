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
    
    private var engines: FlutterEngineGroup!
    
    private var isInitialised = false
    
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
        
        return secondVC
    }

}
