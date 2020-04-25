//
//  ViewController.swift
//  Calculator Layout iOS13
//
//  Created by Angela Yu on 01/07/2019.
//  Copyright © 2019 The App Brewery. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var displayLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    
    @IBAction func clearButtonPressed(_ sender: UIButton) {
        displayLabel.text=""
    }
    
    @IBAction func numberButtonPressed(_ sender: UIButton) {
    }
    
    
    @IBAction func decimalButtonPressed(_ sender: UIButton) {
    }
    
    @IBAction func operationButtonClicked(_ sender: UIButton) {
    }
    
    
    @IBAction func equalsButtonPressed(_ sender: UIButton) {
    }
    

}

