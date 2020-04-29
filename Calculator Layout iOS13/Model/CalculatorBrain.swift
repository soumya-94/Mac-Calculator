//
//  CalculatorBrain.swift
//  Calculator Layout iOS13
//
//  Created by Soumya Bhatnagar on 25/04/20.
//  Copyright © 2020 The App Brewery. All rights reserved.
//

import Foundation

struct CalculatorBrain {
    
    var equationToBeDisplayed = "0"
    var equationToBeEvaluated = "0"
    
    mutating func resetEquationsToZero()
    {
        equationToBeDisplayed = "0"
        equationToBeEvaluated = "0"
    }
    
    mutating func insertDigit(_ digit: String) -> String
    {
        if(equationToBeDisplayed == "0" && equationToBeEvaluated == "0")
        {
            equationToBeDisplayed = ""
            equationToBeEvaluated = ""
        }
        equationToBeDisplayed = equationToBeDisplayed + digit
        equationToBeEvaluated = equationToBeEvaluated + digit
        return equationToBeDisplayed
    }
    
    func checkSubstringExistence(in string: String, forAnyIn characters: String) -> Bool {
        let customSet = CharacterSet(charactersIn: characters)
        let inputSet = CharacterSet(charactersIn: string)
        return !inputSet.intersection(customSet).isEmpty
    }
    
    mutating func insertDecimal(_ currentDisplay: String) -> (toBeDisplayed: String, doubleCheck: Bool)
    {
        if(checkSubstringExistence(in: currentDisplay, forAnyIn: "+-×÷") == false && checkSubstringExistence(in: currentDisplay, forAnyIn: ".") == true)
        { return (currentDisplay, false) }
        else
        {
            equationToBeDisplayed = equationToBeDisplayed + "."
            equationToBeEvaluated = equationToBeEvaluated + "."
            return (equationToBeDisplayed, true)
        }
    }
    
    func evaluateEquation(equation: String) -> Double
    {
        let equation1 = equation.replacingOccurrences(of: "×", with: "*")
        let equation2 = equation1.replacingOccurrences(of: "÷", with: "/")
        let mathExpression = NSExpression(format: equation2)
        let mathValue = mathExpression.expressionValue(with: nil, context: nil) as? Double
        return mathValue!
    }
    
    mutating func insertOperand(_ operand: String, _ decimalCheck: Bool) -> (toBeDisplayed: String, doubleCheck: Bool)
    {
        if(operand == "%")
        {
            if(equationToBeDisplayed == "0" && equationToBeEvaluated == "0")
            { return (equationToBeDisplayed, false) }
            else
            {
                let result = evaluateEquation(equation: equationToBeEvaluated)
                let final = result/100
                equationToBeDisplayed = String(final)
                equationToBeEvaluated = String(final)
                return (String(final), true)
            }
        }
        else if (operand == "+/-")
        {
            let result = evaluateEquation(equation: equationToBeEvaluated)
            let final = 0.0-(result)
            if(decimalCheck == false && final.truncatingRemainder(dividingBy: 1)==0)
            {
                equationToBeDisplayed = String(Int(final))
                equationToBeEvaluated = String(Int(final))
                return (String(Int(final)), false)
            }
            else
            {
                equationToBeDisplayed = String(final)
                equationToBeEvaluated = String(final)
                return (String(final), false)
            }
        }
        else
        {
            equationToBeDisplayed = equationToBeDisplayed + operand
            if(decimalCheck == false)
            {
                equationToBeEvaluated = equationToBeEvaluated + ".0" + operand
            }
            else
            {
                equationToBeEvaluated = equationToBeEvaluated + operand
            }
            return (equationToBeDisplayed, false)
        }
    }
    
    mutating func calculate(_ currentDisplay: String, _ decimalCheck: Bool) -> (toBeDisplayed: String, doubleCheck: Bool)
    {
        if(checkSubstringExistence(in: currentDisplay, forAnyIn: "+-×÷") == false)
        { return (currentDisplay, decimalCheck) }
        else
        {
            if(decimalCheck == false)
            {
                equationToBeEvaluated = equationToBeEvaluated + ".0"
            }
            let final = evaluateEquation(equation: equationToBeEvaluated)
            if(decimalCheck == false && final.truncatingRemainder(dividingBy: 1)==0)
            {
                equationToBeDisplayed = String(Int(final))
                equationToBeEvaluated = String(final)
                return (String(Int(final)), false)
            }
            else
            {
                equationToBeDisplayed = String(final)
                equationToBeEvaluated = String(final)
                return (String(final), false)
            }
        }
    }
    
}
