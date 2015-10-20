//
//  ViewController.swift
//  TipCalculator
//
//  Created by Amy Lin on 10/20/15.
//  Copyright © 2015 Amy. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    // Connects Interface Builder to the views
    @IBOutlet var totalTextField: UITextField!
    @IBOutlet var taxPctSlider: UISlider!
    @IBOutlet var taxPctLabel: UILabel!
    @IBOutlet var resultsTextView: UITextView!
    
    @IBAction func calculateTapped(sender: AnyObject) {
        // Convert string to double
        tipCalc.total = Double((totalTextField.text! as NSString).doubleValue)
        
        // Returns dictionary of possible tip percentages mapped to tip values
        let possibleTips = tipCalc.returnPossibleTips()
        var results = ""
        
        // Sort the results by tip percentage
        // Build a string and add to the results text field
        var keys = Array(possibleTips.keys)
        keys.sortInPlace()
        for tipPct in keys {
            let tipValue = possibleTips[tipPct]!
            let prettyTipValue = String(format: "%0.2f", tipValue)
            results += "\(tipPct)%: \(prettyTipValue)\n"
        }

        // Set the results text to the string
        resultsTextView.text = results
    }
    
    @IBAction func taxPercentageChanged(sender: AnyObject) {
        tipCalc.taxPct = Double(taxPctSlider.value) / 100.0
        refreshUI()
    }
    
    @IBAction func viewTapped(sender: AnyObject) {
        totalTextField.resignFirstResponder()
    }
    
    
    let tipCalc = TipCalculatorModel(total: 33.25, taxPct: 0.06)
    
    func refreshUI() {
        // Convert from double to string
        totalTextField.text = String(format: "%0.2f", tipCalc.total)
        
        // Mulitply by 100 to display as integer instead of decimal
        taxPctSlider.value = Float(tipCalc.taxPct) * 100.0
        
        // Update label based on tax percentage
        taxPctLabel.text = "Tax Percentage (\(Int(taxPctSlider.value))%)"
        
        // Clear text view until user taps calculate button
        resultsTextView.text = ""
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        refreshUI()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

