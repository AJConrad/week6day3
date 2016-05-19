//
//  WorkOrder.swift
//  ApartmentMgr
//
//  Created by Andrew Conrad on 5/18/16.
//  Copyright © 2016 AndrewConrad. All rights reserved.
//

import UIKit

class WorkOrder: NSObject {
    
    var workDesc            :String = " "
    var workUrgent          :Bool = false
    var workFinished        :Bool = false
    
    //these 2, since they track info made by Backendless, must be named the same as their entries in it
    var ownerId             :String = " "
    var created             :NSDate!

}
