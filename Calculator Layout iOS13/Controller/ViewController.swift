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
    
    var userIsTypingNumnber = false
    var doubleIsBeingTyped = false
    
    var brain = CalculatorBrain()
    
    @IBAction func clearButtonPressed(_ sender: UIButton) {
        brain.resetEquationsToZero()
        displayLabel.text = brain.equationToBeDisplayed
    }
    
    @IBAction func numberButtonPressed(_ sender: UIButton) {
        if(displayLabel.text!.count < 12)
        {
            userIsTypingNumnber = true
            displayLabel.text = brain.insertDigit(digit: sender.currentTitle!)
        }
    }
    
    @IBAction func decimalButtonPressed(_ sender: UIButton) {
        if(displayLabel.text!.count < 12)
        {
            let newDisplay = brain.insertDecimal(currentDisplay: displayLabel.text!)
            displayLabel.text = newDisplay.toBeDisplayed
            doubleIsBeingTyped = newDisplay.doubleCheck
        }
    }
    
    @IBAction func operationButtonClicked(_ sender: UIButton) {
        if(displayLabel.text!.count < 12)
        {
            let newDisplay = brain.insertOperand(operand: sender.currentTitle!, decimalCheck: doubleIsBeingTyped)
            displayLabel.text = newDisplay.toBeDisplayed
            doubleIsBeingTyped = newDisplay.doubleCheck
        }
    }
    
    @IBAction func equalsButtonPressed(_ sender: UIButton) {
        let resultant = brain.calculate(currentDisplay: displayLabel.text!, decimalCheck: doubleIsBeingTyped)
        displayLabel.text = resultant.toBeDisplayed
        doubleIsBeingTyped = resultant.doubleCheck
    }

}

