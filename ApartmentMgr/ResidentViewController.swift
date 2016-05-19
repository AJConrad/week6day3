//
//  ResidentViewController.swift
//  ApartmentMgr
//
//  Created by Andrew Conrad on 5/18/16.
//  Copyright © 2016 AndrewConrad. All rights reserved.
//

import UIKit

class ResidentViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    static let sharedInstance = ResidentViewController()
    @IBOutlet weak var      residentTableView:      UITableView!
    let backendless = Backendless.sharedInstance()
    var ordersArray = [WorkOrder]()
    
    //MARK: - Table View Methods
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return ordersArray.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("Rcell", forIndexPath: indexPath)
        let currentUser = ordersArray[indexPath.row]
        cell.textLabel!.text = currentUser.workDesc
        cell.detailTextLabel!.text = "\(currentUser.created)"
        
        if currentUser.workUrgent == true {
            cell.backgroundColor = UIColor.redColor()
        } else if currentUser.workFinished == true {
            cell.backgroundColor = UIColor.greenColor()
        } else {
            cell.backgroundColor = UIColor.whiteColor()
        }
        
        return cell
        
    }
    
    //MARK: - Populate Table Methods
    
    func findOrders() {
        let dataQuery = BackendlessDataQuery()
        
        var error: Fault?
        let bc = backendless.data.of(WorkOrder.ofClass()).find(dataQuery, fault: &error)
        if error == nil {
            ordersArray = bc.getCurrentPage() as! [WorkOrder]
            //How do I word a check to get ones with just his ownerId?
            print("Found \(ordersArray.count)")
        } else {
            print("Find Error \(error)")
        }
        residentTableView.reloadData()
    }
    
    func saveOrder(order: WorkOrder) {
        let dataStore = backendless.data.of(WorkOrder.ofClass())
        dataStore.save(order, response: { (response) in
            print("Order has been saved")
        }) { (error) in
            print("Order not saved, error \(error)")
        }
    }
    
    //MARK: - Segue Methods
    
    override func prepareForSegue(segue:UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "ResidentView" {
            let destController = segue.destinationViewController as! ResidentDetailViewController
            let indexPath = residentTableView.indexPathForSelectedRow
            let selectedEntry = ordersArray[indexPath!.row]
            destController.selectedEntry = selectedEntry
            residentTableView.deselectRowAtIndexPath(indexPath!, animated: true)
                    print("Total of \(ordersArray.count)")
        } else if segue.identifier == "Add" {
            let destController = segue.destinationViewController as! ResidentDetailViewController
            let newOrder = WorkOrder()
            newOrder.workDesc = " "
            newOrder.workUrgent = false
            newOrder.workFinished = false
            //I dont know if I need this, and I dont know how to do it if I do, soooooooo
            
//            newOrder.ownerId = ordersArray[1].ownerId
//            newOrder.created = NSDate!

            saveOrder(newOrder)
            ordersArray .append(newOrder)
                                print("Total Of \(ordersArray.count)")
            let selectedEntry = ordersArray.last
            destController.selectedEntry = selectedEntry

        }
    }
    
    //MARK: - Life Cycle Methods

    override func viewDidLoad() {
        super.viewDidLoad()
        findOrders()


    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()

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
