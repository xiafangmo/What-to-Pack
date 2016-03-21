//
//  AlertView.swift
//  What to Pack
//
//  Created by MoXiafang on 3/15/16.
//  Copyright © 2016 Momo. All rights reserved.
//

import UIKit


class AlertView: NSObject {
    
    class func displayAlert(title: String, message: String, delegate: UIViewController) {
        
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertControllerStyle.Alert)
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.Default, handler: nil))
        
        delegate.presentViewController(alert, animated: true, completion: nil)
    }
    
}
