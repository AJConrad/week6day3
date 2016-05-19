//
//  ResidentDetailViewController.swift
//  ApartmentMgr
//
//  Created by Andrew Conrad on 5/18/16.
//  Copyright © 2016 AndrewConrad. All rights reserved.
//

import UIKit

class ResidentDetailViewController: UIViewController {
    
    static let sharedInstance = ResidentDetailViewController()
    let backendless = Backendless.sharedInstance()
    var residentViewController = ResidentViewController.sharedInstance
    var selectedEntry : WorkOrder!
    
    @IBOutlet weak var      descTextField   :UITextField!
    @IBOutlet weak var      urgentSwitch    :UISwitch!
    
    @IBAction func saveButtonPress(sender: UIBarButtonItem) {
        if descTextField.text != nil {
        selectedEntry.workDesc = descTextField.text!
        } else {
            selectedEntry.workDesc = "Enter a description"
        }
        selectedEntry.workUrgent = urgentSwitch.on
        
        residentViewController.saveOrder(selectedEntry)
        popoverPresentationController
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
