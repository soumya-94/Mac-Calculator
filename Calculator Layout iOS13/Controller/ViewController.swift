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

    var equationToBeDisplayed = ""
    var equationToBeEvaluated = ""
    var userIsTypingNumnber = false
    var doubleIsBeingTyped = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    @IBAction func clearButtonPressed(_ sender: UIButton) {
        equationToBeDisplayed = ""
        equationToBeEvaluated = ""
        displayLabel.text = "0"
    }
    
    @IBAction func numberButtonPressed(_ sender: UIButton) {
        userIsTypingNumnber = true
        equationToBeDisplayed = equationToBeDisplayed + sender.currentTitle!
        displayLabel.text = equationToBeDisplayed
        equationToBeEvaluated = equationToBeDisplayed
    }
    
    
    @IBAction func decimalButtonPressed(_ sender: UIButton) {
        doubleIsBeingTyped = true
        equationToBeDisplayed = equationToBeDisplayed + sender.currentTitle!
        displayLabel.text = equationToBeDisplayed
        equationToBeEvaluated = equationToBeDisplayed
    }
    
    @IBAction func operationButtonClicked(_ sender: UIButton) {
        userIsTypingNumnber = false
        if(sender.currentTitle!=="%")
        {
            //calculate percentage of result of equation and display
        }
        else if (sender.currentTitle!=="+/-")
        {
            //calculate reverse sign of result of equation and display
        }
        else
        {
            if(!equationToBeDisplayed.isEmpty)
            {
                equationToBeDisplayed = equationToBeDisplayed + sender.currentTitle!
                displayLabel.text = equationToBeDisplayed
                if(doubleIsBeingTyped == false)
                {
                    equationToBeEvaluated = equationToBeEvaluated + ".0"
                }
                else
                {
                    equationToBeEvaluated = equationToBeDisplayed
                    doubleIsBeingTyped = false;
                }
            }
        }
    }
    
    @IBAction func equalsButtonPressed(_ sender: UIButton) {
        print(equationToBeDisplayed)
        print(convertEquationForNS(eq: equationToBeEvaluated))
    }
    
    func convertEquationForNS(eq: String) -> String
    {
        let multiplications = eq.replacingOccurrences(of: "×", with: "*")
        let divisions = multiplications.replacingOccurrences(of: "÷", with: "/")
        return divisions
    }
    
    func evaluateEquation()
    {
        let mathExpression = NSExpression(format: equationToBeDisplayed)
        let mathValue = mathExpression.expressionValue(with: nil, context: nil) as? Double
        //convert result from double to int
        displayLabel.text = String(mathValue!)
    }
    

}

