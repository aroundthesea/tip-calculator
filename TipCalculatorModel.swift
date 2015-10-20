//
//  TipCalculatorModel.swift
//  TipCalculator
//
//  Created by Amy Lin on 10/20/15.
//  Copyright © 2015 Amy. All rights reserved.
//

import UIKit
import Foundation

class TipCalculatorModel {
    var total: Double
    var taxPct: Double
    var subtotal: Double {
        get {
            return total / (taxPct + 1)
        }
    }
    
    init(total: Double, taxPct: Double) {
        self.total = total
        self.taxPct = taxPct
    }
    
    func calcTipWithTipPct(tipPct: Double) -> (tipAmt: Double, total: Double) {
        let tipAmt = subtotal * tipPct
        let finalTotal = total + tipAmt
        return (tipAmt, finalTotal)
    }
    
    func returnPossibleTips() -> [Int: (tipAmt: Double, total: Double)] {
        let possibleTipsInferred = [0.15, 0.18, 0.20]
        
        var retval = [Int: (tipAmt: Double, total: Double)]()
        for possibleTip in possibleTipsInferred {
            let intPct = Int(possibleTip*100)
            retval[intPct] = calcTipWithTipPct(possibleTip)
        }
        return retval
    }
}

// Class extends NSObject for implementing UITableViewDataSource
class TestDataSource: NSObject, UITableViewDataSource {
    
    // Initialize calculator and make empty array for possible tips and sorted keys
    let tipCalc = TipCalculatorModel(total: 33.25, taxPct: 0.06)
    var possibleTips = [Int: (tipAmt: Double, total: Double)]()
    var sortedKeys:[Int] = []
    
    // Override init from NSObject
    // Set up variables with initial values
    override init() {
        possibleTips = tipCalc.returnPossibleTips()
        sortedKeys = Array(possibleTips.keys).sort()
        super.init()
    }
    
    // Number of rows in each section of the table view
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return sortedKeys.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        // Create table view cells with default style
        let cell = UITableViewCell(style: UITableViewCellStyle.Value2, reuseIdentifier: nil)
        
        // Display appropriate tip percentage
        let tipPct = sortedKeys[indexPath.row]
        
        // Make a variable for each element in the tuple for the tip percentage
        let tipAmt = possibleTips[tipPct]!.tipAmt
        let total = possibleTips[tipPct]!.total
        
        // Set textLabel, detailTextLabel, and return the cell
        cell.textLabel?.text = "\(tipPct)%:"
        cell.detailTextLabel?.text = String(format: "Tip: $%0.2f, Total: $%0.2f", tipAmt, total)
        return cell
    }
}