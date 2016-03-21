//
//  SavedListTableViewController.swift
//  What to Pack
//
//  Created by MoXiafang on 3/15/16.
//  Copyright © 2016 Momo. All rights reserved.
//

import UIKit
import Foundation
import CoreData

class SavedListTableViewController: UITableViewController, NSFetchedResultsControllerDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Saved Lists"
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        fetchLog()
    }

    func fetchLog() {
        do {
            try fetchedResultsController.performFetch()
        } catch {
            AlertView.displayAlert("Error", message: "Cannot fetch data now, Please try later.", delegate: self)
        }
    }
    
    // MARK: - Table view data source
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let sections = self.fetchedResultsController.sections! as [NSFetchedResultsSectionInfo]
        let sectionInfo = sections[section]
        return sectionInfo.numberOfObjects
    }

    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCellWithIdentifier("savedListTableCell", forIndexPath: indexPath)

        let location = self.fetchedResultsController.objectAtIndexPath(indexPath) as! Location
        cell.textLabel?.text = location.title
        return cell
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        dispatch_async(dispatch_get_main_queue()) {
            let selectedLocation = self.fetchedResultsController.objectAtIndexPath(indexPath) as! Location
            let data = selectedLocation.list.data
            let dic: NSDictionary = NSKeyedUnarchiver.unarchiveObjectWithData(data!) as! NSDictionary
            PackingListModel.sharedInstance.personalizedDic = dic as! [String : Bool]
        }
        
        let navController = storyboard?.instantiateViewControllerWithIdentifier("personalList")
        presentViewController(navController!, animated: true, completion: nil)
        
        return
    }
    
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            let location = fetchedResultsController.objectAtIndexPath(indexPath) as? Location
            if location != nil {
                sharedContext.deleteObject(location!)
            }
            do {
                try self.sharedContext.save()
            }
            catch {
            }
        }
        fetchLog()
        tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
    }

    @IBAction func cancel(sender: AnyObject) {
        //Go back to the main view
        self.view.window?.rootViewController?.dismissViewControllerAnimated(true, completion: nil)
    }
    
    // Shared Context from CoreDataStackManager
    var sharedContext: NSManagedObjectContext {
        return CoreDataStackManager.sharedInstance().managedObjectContext
    }
    
    // Fetched Results Controller
    lazy var fetchedResultsController: NSFetchedResultsController = {
        
        let fetchRequest = NSFetchRequest(entityName: "Location")
        
        fetchRequest.sortDescriptors = [NSSortDescriptor(key: "title", ascending: true)]
        
        let fetchedResultsController = NSFetchedResultsController(fetchRequest: fetchRequest,
            managedObjectContext: self.sharedContext,
            sectionNameKeyPath: nil,
            cacheName: nil)
        
        return fetchedResultsController
    }()
    
}
