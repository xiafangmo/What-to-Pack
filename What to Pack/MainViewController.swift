//
//  MainViewController.swift
//  What to Pack
//
//  Created by MoXiafang on 2/29/16.
//  Copyright © 2016 Momo. All rights reserved.
//


import UIKit
import GoogleMaps

class MainViewController: UIViewController , UISearchBarDelegate, LocateOnTheMap {
    
    var searchResultController: SearchResultsController!

    @IBOutlet weak var whereButton: UIButton!
    @IBOutlet weak var days: UILabel!
    @IBOutlet weak var textField: UITextField!
    @IBOutlet weak var travelType: UISegmentedControl!
    @IBOutlet weak var travelPeople: UISegmentedControl!
    @IBOutlet weak var whatToPack: UIButton!
    @IBOutlet weak var savedListButton: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        days.hidden = true
        textField.hidden = true
        travelType.hidden = true
        travelPeople.hidden = true
        whatToPack.hidden = true
        
        let tapRecognizer = UITapGestureRecognizer()
        tapRecognizer.addTarget(self, action: "didTapView")
        self.view.addGestureRecognizer(tapRecognizer)
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(true)
        searchResultController = SearchResultsController()
        searchResultController.delegate = self
        
    }
    
    //Bring out the search bar
    @IBAction func seach(sender: AnyObject) {
        let searchController = UISearchController(searchResultsController: searchResultController)
        searchController.searchBar.delegate = self
        presentViewController(searchController, animated: true, completion: nil)
        whatToPack.hidden = true
    }
    
    func locateWithLongitude(lat: Double, lon: Double, title: String) {
        
        let commaSplitter = createSplitter(",")
        let shortTitle = commaSplitter(title)[0]
        self.whereButton.setTitle(shortTitle, forState: .Normal)
        
        self.days.hidden = false
        self.textField.hidden = false
        self.travelType.hidden = false
        self.travelPeople.hidden = false
        
        TravelParameters.sharedInstance.lat = lat
        TravelParameters.sharedInstance.lon = lon
        TravelParameters.sharedInstance.title = shortTitle
        
    }
    
    @IBAction func showPackButton(sender: AnyObject) {
        whatToPack.hidden = false
    }
    
    func didTapView(){
        self.view.endEditing(true)
    }
    
    func searchBar(searchBar: UISearchBar, textDidChange searchText: String) {
        
        let placeClient = GMSPlacesClient()
        UIApplication.sharedApplication().networkActivityIndicatorVisible = true
        placeClient.autocompleteQuery(searchText, bounds: nil, filter: nil) { (results, error: NSError?) -> Void in
            
            var resultsArray = [String]()
            
            resultsArray.removeAll()
            if results == nil {
                return
            }
            for result in results! {
                if let result = result as? GMSAutocompletePrediction  {
                    resultsArray.append(result.attributedFullText.string)
                }
            }
            self.searchResultController.reloadDataWithArray(resultsArray)
            UIApplication.sharedApplication().networkActivityIndicatorVisible = false
        }
    }
    
    @IBAction func goToPackingListView(sender: AnyObject) {
        
        let travelDays = Int(textField.text!)
        
        if  travelDays <= 16 {
            TravelParameters.sharedInstance.days = travelDays
        } else {
            TravelParameters.sharedInstance.days = 16
        }
        
        let packingListVC = storyboard?.instantiateViewControllerWithIdentifier("packingListVC") as! PackingListViewController
        presentViewController(packingListVC, animated: true, completion: nil)
    }
    
    @IBAction func selectTravelType(sender: AnyObject) {
        switch travelType.selectedSegmentIndex {
        case 0:
            TravelParameters.sharedInstance.travelType = "Business"
        case 1:
            TravelParameters.sharedInstance.travelType = "Vacation"
        case 2:
            TravelParameters.sharedInstance.travelType = "Adventure"
        case 3:
            TravelParameters.sharedInstance.travelType = "Beach"
        default:
            break
        }
    }

    @IBAction func selectTravelPeople(sender: AnyObject) {
        switch travelPeople.selectedSegmentIndex {
        case 0:
            TravelParameters.sharedInstance.travelPeople = 1
        case 1:
            TravelParameters.sharedInstance.travelPeople = 2
        case 2:
            TravelParameters.sharedInstance.travelPeople = 3
        default:
            break
        }
    }
    
    @IBAction func showSavedLists(sender: AnyObject) {
        
        let navController = storyboard?.instantiateViewControllerWithIdentifier("savedLists")
        presentViewController(navController!, animated: true, completion: nil)
    }
    
    func createSplitter(separator: String) -> (String -> [String]) {
        func split(source: String) -> [String] {
            return source.componentsSeparatedByString(separator)
        }
        return split
    }
    
    
}


