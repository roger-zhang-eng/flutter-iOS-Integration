//
//  AppNavigationController.swift
//  MobileFlutterDemo
//
//  Created by Roger on 8/4/2024.
//

import UIKit

class AppNavigationController: UINavigationController {
    var presentedFlutterVC: UIViewController?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        FlutterManager.shared.dismissFlutterCallback = dismissFlutterScreen
    }
    
    func presentNativeScreen() {
        let nativeVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "NativeSecondScreen")
        
        present(nativeVC, animated: true)
        
    }
    
    func pushFlutterScreen() {
        //let displayVC = FlutterManager.shared.entryScreen()
        //pushViewController(displayVC, animated: true)
        
        let displayVC = FlutterManager.shared.secondScreen()
        presentedFlutterVC = displayVC
        
        
        displayVC.isModalInPresentation = true
        present(displayVC, animated: true)
    }
    
    func dismissFlutterScreen() {
        presentedFlutterVC?.dismiss(animated: true)
    }
    
}
