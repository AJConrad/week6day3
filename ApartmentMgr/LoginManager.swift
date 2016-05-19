//
//  LoginManager.swift
//  ApartmentMgr
//
//  Created by Andrew Conrad on 5/18/16.
//  Copyright © 2016 AndrewConrad. All rights reserved.
//

import UIKit

class LoginManager: NSObject {
    
    static let sharedInstance = LoginManager()
    let backendless = Backendless.sharedInstance()
    var currentUser = BackendlessUser()
    
    //MARK: - New User
    
    
    //SAVE FOR LATER
    //THIS GOES ON THE DETAIL VIEW OF THE RESIDENT TABLE
    
//    private func saveWorkOrder(order: WorkOrder) {
//        let dataStore = backendless.data.of(WorkOrder.ofClass())
//        dataStore.save(order, response: { (response) in
//            print("Order was saved")
//        }) { (error) in
//            print("Order not saved, error \(error)")
//        }
//    }
        
    func registerNewUser(email: String, password: String) {
        
        let user = BackendlessUser()
        user.email = email
        user.password = password
//        if email == "ajc.on.kwaj@gmail.com" {
//            let newWork = WorkOrder()
//            newWork.workDesc = "Admin Tool Item"
//            newWork.workUrgent = false
//            newWork.workFinished = true
//            newWork.ownerId = currentUser.objectId
//            newWork.created = NSDate(timeIntervalSinceNow: 1)
//            saveWorkOrder(newWork)
        
        //}
        
        backendless.userService.registering(user, response: { (registeredUser) in
            print("Success Registering \(registeredUser.email)")
        }) { (error) in
            print("Error Registering \(error)")
        }
    }
    
    //MARK: - Log In
    
    func loginUser(email: String, password: String) {
        
        backendless.userService.login(email, password: password, response: { (loggedInUser) in
            print("Logged In \(loggedInUser.email)")
            self.currentUser = loggedInUser
            NSNotificationCenter.defaultCenter().postNotification(NSNotification(name: "LoggedInMsg", object: nil))
        }) { (error) in
            print("Log In Error \(error)")
            NSNotificationCenter.defaultCenter().postNotification(NSNotification(name: "LoggedInErrorMsg", object: nil))
        }
    }
    
    //MARK: - Log Out
    
    func logoutUser() {
        backendless.userService.logout({ (response) in
            print("Logged Out")
        }) { (error) in
            print("Log Out Error \(error)")
        }
    }
    
    
}

