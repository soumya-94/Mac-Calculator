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

    var equationToBeDisplayed = "0"
    var equationToBeEvaluated = "0"
    var userIsTypingNumnber = false
    var doubleIsBeingTyped = false
    
    @IBAction func clearButtonPressed(_ sender: UIButton) {
        equationToBeDisplayed = "0"
        equationToBeEvaluated = "0"
        displayLabel.text = "0"
    }
    
    @IBAction func numberButtonPressed(_ sender: UIButton) {
        if(displayLabel.text!.count < 12)
        {
            userIsTypingNumnber = true
            if(equationToBeDisplayed == "0" && equationToBeEvaluated == "0")
            {
                equationToBeDisplayed = ""
                equationToBeEvaluated = ""
            }
            equationToBeDisplayed = equationToBeDisplayed + sender.currentTitle!
            equationToBeEvaluated = equationToBeEvaluated + sender.currentTitle!
            displayLabel.text = equationToBeDisplayed
        }
    }
    
    
    @IBAction func decimalButtonPressed(_ sender: UIButton) {
        if(displayLabel.text!.count < 12)
        {
            if(check(in: displayLabel.text!, forAnyIn: "+-×÷") == false && check(in: displayLabel.text!, forAnyIn: ".") == true) {}
            else
            {
                doubleIsBeingTyped = true
                equationToBeDisplayed = equationToBeDisplayed + sender.currentTitle!
                equationToBeEvaluated = equationToBeEvaluated + sender.currentTitle!
                displayLabel.text = equationToBeDisplayed
            }
        }
    }
    
    @IBAction func operationButtonClicked(_ sender: UIButton) {
        if(displayLabel.text!.count < 12)
        {
            userIsTypingNumnber = false
            if(sender.currentTitle! == "%")
            {
                if(equationToBeDisplayed == "0" && equationToBeEvaluated == "0"){}
                else
                {
                    let result = evaluateEquation(eq: convertEquationForNS(eq: equationToBeEvaluated))
                    let final = result/100
                    displayLabel.text = String(final)
                    equationToBeDisplayed = String(final)
                    equationToBeEvaluated = String(final)
                    doubleIsBeingTyped = true
                }
            }
            else if (sender.currentTitle! == "+/-")
            {
                let result = evaluateEquation(eq: convertEquationForNS(eq: equationToBeEvaluated))
                let final = 0.0-(result)
                if(doubleIsBeingTyped == false && final.truncatingRemainder(dividingBy: 1)==0)
                {
                    displayLabel.text = String(Int(final))
                    equationToBeDisplayed = String(Int(final))
                    equationToBeEvaluated = String(Int(final))
                }
                else
                {
                    displayLabel.text = String(final)
                    equationToBeDisplayed = String(final)
                    equationToBeEvaluated = String(final)
                    doubleIsBeingTyped = false
                }
            
            }
            else
            {
                equationToBeDisplayed = equationToBeDisplayed + sender.currentTitle!
                displayLabel.text = equationToBeDisplayed
                if(doubleIsBeingTyped == false)
                {
                    equationToBeEvaluated = equationToBeEvaluated + ".0" + sender.currentTitle!
                }
                else
                {
                    equationToBeEvaluated = equationToBeEvaluated + sender.currentTitle!
                    doubleIsBeingTyped = false;
                }
            }
        }
    }
    
    @IBAction func equalsButtonPressed(_ sender: UIButton) {
        if(check(in: displayLabel.text!, forAnyIn: "+-×÷") == false){}
        else
        {
            if(doubleIsBeingTyped == false)
            {
                equationToBeEvaluated = equationToBeEvaluated + ".0"
            }
            let transformedEq = convertEquationForNS(eq: equationToBeEvaluated)
            let final = evaluateEquation(eq: transformedEq)
            print(final)
            if(doubleIsBeingTyped == false && final.truncatingRemainder(dividingBy: 1)==0)
            {
                displayLabel.text = String(Int(final))
                equationToBeDisplayed = String(Int(final))
            }
            else
            {
                displayLabel.text = String(final)
                equationToBeDisplayed = String(final)
                doubleIsBeingTyped = false
            }
            equationToBeEvaluated = String(final)
        }
    }
    
    func convertEquationForNS(eq: String) -> String
    {
        let multiplications = eq.replacingOccurrences(of: "×", with: "*")
        let divisions = multiplications.replacingOccurrences(of: "÷", with: "/")
        return divisions
    }
    
    func evaluateEquation(eq: String) -> Double
    {
        let mathExpression = NSExpression(format: eq)
        let mathValue = mathExpression.expressionValue(with: nil, context: nil) as? Double
        return mathValue!
    }
    
    func check(in string: String, forAnyIn characters: String) -> Bool {
        let customSet = CharacterSet(charactersIn: characters)
        let inputSet = CharacterSet(charactersIn: string)
        return !inputSet.intersection(customSet).isEmpty
    }

}

