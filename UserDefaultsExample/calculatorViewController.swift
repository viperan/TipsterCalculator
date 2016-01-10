//
//  calculatorViewController.swift
//  UserDefaultsExample
//
//  Created by Daniel Ardiwinata on 1/7/16.
//  Copyright © 2016 Daniel Ardiwinata. All rights reserved.
//

import UIKit

class calculatorViewController: UIViewController {

    @IBOutlet weak var billField: UITextField!

    @IBOutlet weak var tipLabel: UILabel!
    
    @IBOutlet weak var tipControl: UISegmentedControl!
    
    @IBOutlet weak var totalLabel: UILabel!
    @IBOutlet weak var fourPersonSplit: UILabel!
    @IBOutlet weak var threePersonSplit: UILabel!
    @IBOutlet weak var twoPersonSplit: UILabel!
    
    let userDefaults = NSUserDefaults.standardUserDefaults()
    
    
    var billAmount = 0.00
    var tipPercentage = 0.15
    var tipPercentages = [ 0.10, 0.15, 0.20]

    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.

        tipLabel.text = "$0.00"
        totalLabel.text = "$0.00"
        billField.becomeFirstResponder()
       
        
        refreshDefaultPercentage()
        refreshBackgroundColor()
        recalculate()
        
    }
    

    
    

    @IBAction func onEditingChange(sender: AnyObject) {
        
        
        // check for empty string for billField.text to avoid crashing due to not able to get the value.
        
        if billField.text != "" {
            billAmount = Double((billField.text!))!
        }else{
            // if empty string then set the bill amount to zero to empty out the value.
            billAmount = 0.0
        }
        recalculate()

    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    @IBAction func onTap(sender: AnyObject) {
        view.endEditing(true)
    }
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    
    @IBAction func unwindToCalculatorController(sender: UIStoryboardSegue){
        refreshBackgroundColor()
        refreshDefaultPercentage()
        recalculate()

    }
    
    func refreshBackgroundColor(){
        var bgColorNo: Int? = userDefaults.objectForKey("bgColor") as! Int?
        if (bgColorNo == nil){
            bgColorNo = 1
            userDefaults.setObject(bgColorNo, forKey: "bgColor")
        }
        
        
        switch ( bgColorNo!){
        case 0:
            self.view.backgroundColor = UIColor.redColor();
        case 1:
            self.view.backgroundColor = UIColor.greenColor();
        case 2:
            self.view.backgroundColor = UIColor.blueColor()
        default:
            self.view.backgroundColor = UIColor.whiteColor();
        }
    }
    
    func refreshDefaultPercentage(){
        // set the value segmented default percentage from the nsUserDefault
        
        var defaultPercentageNo : Int? = userDefaults.objectForKey("defaultTip") as! Int?
        if (defaultPercentageNo == nil){
            defaultPercentageNo = 1
            userDefaults.setObject(defaultPercentageNo, forKey: "defaultTip")
        }
        tipControl.selectedSegmentIndex = defaultPercentageNo!
    }
    
    func recalculate(){
        tipPercentage = tipPercentages[tipControl.selectedSegmentIndex]
        var tip = billAmount * tipPercentage
        var total = billAmount + tip
        
        tipLabel.text = String(format: "$%.2f", tip)
        totalLabel.text = String(format: "$%.2f", total)
        
        twoPersonSplit.text = String(format: "$%.2f", total/2)
        threePersonSplit.text = String(format: "$%.2f", total/3)
        fourPersonSplit.text =  String(format: "$%.2f", total/4)
    }
    

    

}
