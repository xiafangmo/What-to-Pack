//
//  SearchResultsController.swift
//  What to Pack
//
//  Created by MoXiafang on 2/29/16.
//  Copyright © 2016 Momo. All rights reserved.
//

import UIKit

protocol LocateOnTheMap {
    func locateWithLongitude(lat:Double, lon:Double, title: String)
}

class SearchResultsController: UITableViewController {

    var searchResults: [String]!
    var delegate: LocateOnTheMap!

    override func viewDidLoad() {
        super.viewDidLoad()
        self.searchResults = Array()
        self.tableView.registerClass(UITableViewCell.self, forCellReuseIdentifier: "cellIdentifier")
        
        guard Reachability.isConnectedToNetwork() == true else {
            searchResults = ["Connection failed. Please try again Later."]
            return
        }

    }

    // MARK: - Table view data source
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {

        return searchResults.count
    }

    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("cellIdentifier", forIndexPath: indexPath)
        
        cell.textLabel?.text = searchResults[indexPath.row]
        
        return cell
    }

    override func tableView(tableView: UITableView,
        didSelectRowAtIndexPath indexPath: NSIndexPath){
            // 1
            self.dismissViewControllerAnimated(true, completion: nil)
            // 2
            let correctedAddress:String! = searchResults[indexPath.row].stringByAddingPercentEncodingWithAllowedCharacters(NSCharacterSet.symbolCharacterSet())
            
            UIApplication.sharedApplication().networkActivityIndicatorVisible = true
            
            SearchHelper.sharedInstance.getDestination(correctedAddress) {(result, error) in
                
                self.delegate.locateWithLongitude(result!["lat"]!, lon: result!["lon"]!, title: self.searchResults[indexPath.row])
                
                UIApplication.sharedApplication().networkActivityIndicatorVisible = false
    
            }
    }
    
    
    func reloadDataWithArray(array:[String]){
        self.searchResults = array
        self.tableView.reloadData()
    }

    
}
