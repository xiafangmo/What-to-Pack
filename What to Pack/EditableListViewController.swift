//
//  EditableListViewController.swift
//  What to Pack
//
//  Created by MoXiafang on 3/14/16.
//  Copyright © 2016 Momo. All rights reserved.
//

import UIKit
import CoreData

class EditableListViewController: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Edit Your List"
        JSONHelper.sharedInstance.getItemsFullList()
        
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return PackingListModel.sharedInstance.editableList.count
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCellWithIdentifier("eidtableTableCell", forIndexPath: indexPath)
        cell.textLabel?.text = PackingListModel.sharedInstance.editableList[indexPath.row]
        return cell
    }
    
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        return true
    }
    

    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            PackingListModel.sharedInstance.editableList.removeAtIndex(indexPath.row)
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        } else if editingStyle == .Insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    
    @IBAction func cancel(sender: AnyObject) {
        dismissViewControllerAnimated(false, completion: nil)
    }
    
    @IBAction func saveTheFinalList(sender: AnyObject) {
        dispatch_async(dispatch_get_main_queue()) {
            
            var dic = [String: Bool]()
            for item in PackingListModel.sharedInstance.editableList {
                dic[item] = false
            }
            
            let data: NSData = NSKeyedArchiver.archivedDataWithRootObject(dic)
            
            let personalizedList = PersonalizedList.init(data: data, context: self.sharedContext)
            
            let location = Location.init(lat: TravelParameters.sharedInstance.lat, lon: TravelParameters.sharedInstance.lon, title: TravelParameters.sharedInstance.title, context: self.sharedContext)
            
            personalizedList.location = location
            
            do {
                try self.sharedContext.save()
            }
            catch {
                AlertView.displayAlert("Error", message: "The list cannot be saved now. Please try later.", delegate: self)
            }
        }
        let navController = storyboard?.instantiateViewControllerWithIdentifier("savedLists")
        presentViewController(navController!, animated: true, completion: nil)
    }

    // Shared Context from CoreDataStackManager
    var sharedContext: NSManagedObjectContext {
        return CoreDataStackManager.sharedInstance().managedObjectContext
    }
    
    func pathForIdentifier(identifier: String) -> String {
        let documentsDirectoryURL: NSURL = NSFileManager.defaultManager().URLsForDirectory(.DocumentDirectory, inDomains: .UserDomainMask).first!
        let fullURL = documentsDirectoryURL.URLByAppendingPathComponent(identifier)
        
        return fullURL.path!
    }


}
