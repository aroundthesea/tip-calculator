//
//  ViewController.swift
//  TipCalculator
//
//  Created by Amy Lin on 10/20/15.
//  Copyright © 2015 Amy. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDataSource {
    
    // Connects Interface Builder to the views
    @IBOutlet var totalTextField: UITextField!
    @IBOutlet var taxPctSlider: UISlider!
    @IBOutlet var taxPctLabel: UILabel!
    @IBOutlet var resultsTextView: UITextView!
    @IBOutlet weak var tableView: UITableView!
    
    let tipCalc = TipCalculatorModel(total: 33.25, taxPct: 0.06)
    var possibleTips = [Int: (tipAmt: Double, total: Double)]()
    var sortedKeys:[Int] = []
    
    func refreshUI() {
        // Convert from double to string
        totalTextField.text = String(format: "%0.2f", tipCalc.total)
        
        // Mulitply by 100 to display as integer instead of decimal
        taxPctSlider.value = Float(tipCalc.taxPct) * 100.0
        
        // Update label based on tax percentage
        taxPctLabel.text = "Tax Percentage (\(Int(taxPctSlider.value))%)"
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        refreshUI()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func calculateTapped(sender: AnyObject) {
        tipCalc.total = Double((totalTextField.text! as NSString).doubleValue)
        possibleTips = tipCalc.returnPossibleTips()
        sortedKeys = Array(possibleTips.keys).sort()
        tableView.reloadData()
    }
    
    @IBAction func taxPercentageChanged(sender: AnyObject) {
        tipCalc.taxPct = Double(taxPctSlider.value) / 100.0
        refreshUI()
    }
    
    @IBAction func viewTapped(sender: AnyObject) {
        totalTextField.resignFirstResponder()
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

