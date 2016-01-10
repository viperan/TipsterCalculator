//
//  ViewController.swift
//  UserDefaultsExample
//
//  Created by Daniel Ardiwinata on 12/16/15.
//  Copyright © 2015 Daniel Ardiwinata. All rights reserved.
//

import UIKit

class BackgroundViewController: UIViewController, UINavigationControllerDelegate {


    
    @IBOutlet weak var segmentedColor: UISegmentedControl!
    
    @IBOutlet weak var saveButtonBar: UIBarButtonItem!
    
    @IBOutlet weak var defaultTipPercentage: UISegmentedControl!
    
    let userDefaults = NSUserDefaults.standardUserDefaults()
    
    
    @IBAction func cancel(sender: AnyObject) {
        let isPresentingOption = presentingViewController is UINavigationController
        
        if isPresentingOption {
            dismissViewControllerAnimated(true, completion: nil)
        }
        else {
            navigationController!.popViewControllerAnimated(true)
        }
        
    }
    
    
    @IBAction func segmentedButtonChanged(sender: UISegmentedControl) {
        
            //print(segmentedColor.selectedSegmentIndex)
        
            switch ( segmentedColor.selectedSegmentIndex){
            case 0:
                UIView.animateWithDuration(1, animations: {() -> Void in self.view.backgroundColor = UIColor.redColor()})
            case 1:
                UIView.animateWithDuration(1, animations: {() -> Void in self.view.backgroundColor = UIColor.greenColor()})
            case 2:
                UIView.animateWithDuration(1, animations: {() -> Void in self.view.backgroundColor = UIColor.blueColor()})
            default:
                UIView.animateWithDuration(1, animations: {() -> Void in self.view.backgroundColor = UIColor.whiteColor()})
            }

            
        

    }
    

    
    
    // This method lets you configure a view controller before it's presented.
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        let bgColorNo = segmentedColor.selectedSegmentIndex
        let defaultPercentage = defaultTipPercentage.selectedSegmentIndex
        userDefaults.setObject(bgColorNo, forKey: "bgColor")
        userDefaults.setObject(defaultPercentage, forKey: "defaultTip")
        
        userDefaults.synchronize()
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        var bgColorNo: Int? = userDefaults.objectForKey("bgColor") as! Int?
        if (bgColorNo == nil){
            bgColorNo = 1
            userDefaults.setObject(bgColorNo, forKey: "bgColor")
        }
        segmentedColor.selectedSegmentIndex = bgColorNo!
        
        
        
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
        
        // set the value segmented default percentage from the nsUserDefault
        
        var defaultPercentageNo : Int? = userDefaults.objectForKey("defaultTip") as! Int?
        if (defaultPercentageNo == nil){
            defaultPercentageNo = 1
            userDefaults.setObject(defaultPercentageNo, forKey: "defaultTip")
        }
        defaultTipPercentage.selectedSegmentIndex = defaultPercentageNo!
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

