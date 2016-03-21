//
//  PersonalizedListTableViewController.swift
//  What to Pack
//
//  Created by MoXiafang on 3/18/16.
//  Copyright © 2016 Momo. All rights reserved.
//

import UIKit
import CoreData

class PersonalizedListTableViewController: UITableViewController, NSFetchedResultsControllerDelegate {
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Start to Pack"
    }

    // MARK: - Table view data source
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return PackingListModel.sharedInstance.personalizedDic.count
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCellWithIdentifier("personalizedListTableCell", forIndexPath: indexPath)
        
        var keys = [String]()
        var values = [Bool]()
        
        for (key, value) in PackingListModel.sharedInstance.personalizedDic {
            keys.append(key)
            values.append(value)
        }
        
        cell.textLabel?.text = keys[indexPath.row]
        cell.detailTextLabel?.text = "\(values[indexPath.row])"
        
        return cell
    }
 
    @IBAction func update(sender: AnyObject) {
        dismissViewControllerAnimated(true, completion: nil)
    }


}
