//
//  ViewController.swift
//  Calculator
//
//  Created by Junseok Lee on 2021/08/25.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var display: UILabel!
    
    var userIsInTheMiddleOfTyping:Bool = false
    
    @IBAction func touchDigit(_ sender: UIButton) {
        let digit = sender.currentTitle!
        if userIsInTheMiddleOfTyping {
            let textCurrentlyDisplay = display.text!
            display.text = textCurrentlyDisplay + digit
        }else{
            display.text = digit
        }
        userIsInTheMiddleOfTyping = true
    }
    
    @IBAction func performOperation(_ sender: UIButton) {
        userIsInTheMiddleOfTyping = false
        if let mathematicalSymbol = sender.currentTitle{
            if mathematicalSymbol == "π"{
                display.text = String(Double.pi)
            }
        }
    }
}
