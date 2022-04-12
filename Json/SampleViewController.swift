//
//  SampleViewController.swift
//  Json
//
//  Created by lakshmi Raghavendra on 03/03/21.
//

import UIKit

class SampleViewController: UIViewController {

    @IBOutlet weak var btn1: UIButton!
    @IBOutlet weak var btn2: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

    
    @objc func btn1Click() {
        if btn1.isSelected {
            btn2.isSelected = false
        }
    }
    @objc func btn2Click() {
        if btn2.isSelected {
            btn1.isSelected = false
        }
    }

}
