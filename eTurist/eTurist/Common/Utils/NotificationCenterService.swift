//
//  NotificationCenterService.swift
//  eTurist
//
//  Created by Marko on 23.08.2021..
//

import Foundation

class NotificationCenterService {
    
    private static let updateDataName: NSNotification.Name = NSNotification.Name("com.croentrain.update.data")
    
    static func postUpdateDataBroadcast() {
        NotificationCenter.default.post(name: updateDataName,object: nil)
    }
    
    static func receiveDataUpdates(observer: Any, selector: Selector) {
        NotificationCenter.default
                          .addObserver(observer,
                                       selector: selector,
                         name: updateDataName, object: nil)
    }
    
}
