//
//  ViewController.swift
//  ApartmentMgr
//
//  Created by Andrew Conrad on 5/18/16.
//  Copyright © 2016 AndrewConrad. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    static let sharedInstance = ViewController()
    var loginManager = LoginManager.sharedInstance
    let backendless = Backendless.sharedInstance()
    
    @IBOutlet weak var      emailEntryTextField         :UITextField!
    @IBOutlet weak var      passwordEntryTextField      :UITextField!
    @IBOutlet weak var      registerButton              :UIButton!
    @IBOutlet weak var      loginButton                 :UIButton!
    @IBOutlet weak var      logoutButton                :UIButton!
    
    //MARK: - User Login Verification Methods
    
    //bare minimum what a email and password could be method
    private func isValidLogin(email: String, password: String) -> Bool {
        return email.characters.count > 5 && password.characters.count > 4
    }
    
    //guard block method
//    private func stupidGuardChunk(email: String, password: String) {
//        guard let email = emailEntryTextField.text else {
//            return
//        }
//        guard let password = passwordEntryTextField.text else {
//            return
//        }
//    }
    
    //method that unlocks the buttons when the bare minimum requirements happen
    @IBAction private func entryFieldsChanged() {
        registerButton.enabled = false
        
        guard let email = emailEntryTextField.text else {
            return
        }
        guard let password = passwordEntryTextField.text else {
            return
        }
        if isValidLogin(email, password: password) {
            registerButton.enabled = true
        }
    }

    
    //MARK: - Interactivity Methods
    
    @IBAction private func registerUserButton(button: UIButton) {
        guard let email = emailEntryTextField.text else {
            return
        }
        guard let password = passwordEntryTextField.text else {
            return
        }
        loginManager.registerNewUser(email, password: password)
    }
    
    @IBAction private func loginUserButton(button: UIButton) {
        guard let email = emailEntryTextField.text else {
            return
        }
        guard let password = passwordEntryTextField.text else {
            return
        }
        loginManager.loginUser(email, password: password)
    }
    
    func loginSuccess() {
        print("is logged in")
        let isAdmin = loginManager.currentUser.getProperty("isAdmin") as! Bool
        switch isAdmin {
        case true:
            print("Going to Admin")
            performSegueWithIdentifier("Admin", sender: self)
        case false:
            print("Going to resident")
            performSegueWithIdentifier("Resident", sender: self)
        }
    }
    
    func loginFail() {
        print("is not logged in")
    }
    
    @IBAction private func logoutUserButton(button: UIButton) {
        loginManager.logoutUser()
    }
    
    
    //MARK: - Segue Method
    
//    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
//        let destController = segue.destinationViewController as! DetailViewController
//        let indexPath = journalTableView.indexPathForSelectedRow
//        let selectedEntry = journalArray[indexPath!.row]
//        destController.selectedEntry = selectedEntry
//        journalTableView.deselectRowAtIndexPath(indexPath!, animated: true)
//        
//    }
    
    
    //MARK: - HINT FOR HOMEWORK
    
    //to make detail views off of the table, in the 2 different table view controllers, create arrays that are the user entries visable to them.
    //Then use the above prepare for seg to pass over the information
    

    //MARK: - Life Cycle Methods

    override func viewDidLoad() {
        super.viewDidLoad()
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(loginSuccess), name: "LoggedInMsg", object: nil)
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(loginFail), name: "LoggedInErrorMsg", object: nil)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

