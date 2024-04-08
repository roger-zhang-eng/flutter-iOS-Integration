//
//  AppNavigationController.swift
//  MobileFlutterDemo
//
//  Created by Roger on 8/4/2024.
//

import UIKit

class AppNavigationController: UINavigationController {
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    func pushFlutterScreen() {
        //let displayVC = FlutterManager.shared.entryScreen()
        let displayVC = FlutterManager.shared.secondScreen()
        
        //pushViewController(displayVC, animated: true)
        
        displayVC.isModalInPresentation = true
        present(displayVC, animated: true)
    }
    
}
