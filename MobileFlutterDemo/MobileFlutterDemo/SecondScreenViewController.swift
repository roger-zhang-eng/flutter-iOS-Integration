//
//  SecondScreenViewController.swift
//  MobileFlutterDemo
//
//  Created by Roger on 9/4/2024.
//

import Foundation
import UIKit

class SecondScreenViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    @IBAction func backButtonTapped(_ sender: UIButton) {
        self.dismiss(animated: true)
    }
    
}
