//
//  ViewController.swift
//  MobileFlutterDemo
//
//  Created by Roger on 8/4/2024.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    @IBAction func flutterButtonTapped(_ sender: UIBarButtonItem) {
        guard let nav = self.navigationController as? AppNavigationController else {
            return
        }
        
        nav.pushFlutterScreen()
    }
    

}

