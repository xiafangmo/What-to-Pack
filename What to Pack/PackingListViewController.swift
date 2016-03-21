//
//  PackingListViewController.swift
//  What to Pack
//
//  Created by MoXiafang on 3/5/16.
//  Copyright © 2016 Momo. All rights reserved.
//

import UIKit
import SwiftyJSON

class PackingListViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var tempLabel: UILabel!
    @IBOutlet weak var forecastLabel: UILabel!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var indicator: UIActivityIndicatorView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        
        getWeather()
        
        //Load the JSON file
        JSONHelper.sharedInstance.jsonParsingFromFile()

    }
    
    @IBAction func cancel(sender: AnyObject) {
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    func kevinToCelsius(kevin: Double) -> Double {
        return kevin - 273.15
    }
    
    func celsiusToFahrenheit(celsius: Double) -> Double {
        return celsius * 9/5 + 32
    }
    
    //Get weather info from Open Weather API
    func getWeather() {
        guard Reachability.isConnectedToNetwork() == true else {
            AlertView.displayAlert("Connection Failed", message: "Please check your internet connection and try again", delegate: self)
            return
        }
        
        indicator.startAnimating()
        OpenWeatherClient.sharedInstance.getWeather(TravelParameters.sharedInstance.lat, lon: TravelParameters.sharedInstance.lon, cnt: TravelParameters.sharedInstance.days) { (success, result, errorString) in
            
            guard result != nil else {
                AlertView.displayAlert("Sever Error", message: "Weather Info cannot be fecthed. Please try again Later.", delegate: self)
                return
            }
            
            Weather.sharedInstance.maxTemp = result!["maxTemp"] as! Double
            Weather.sharedInstance.minTemp = result!["minTemp"] as! Double
            Weather.sharedInstance.weatherLikelyToBe = result!["weatherLikelyToBe"] as! String
            Weather.sharedInstance.extremeWeather = result!["extremeWeather"] as! String
            
            self.setLabels()
            
            self.indicator.stopAnimating()
            self.indicator.hidden = true
        }
    }
    
    //Show the range of temparature and the possible weather
    func setLabels() {
        let celsiusMax = kevinToCelsius(Weather.sharedInstance.maxTemp)
        let celsiusMin = kevinToCelsius(Weather.sharedInstance.minTemp)
        
        let celsiusMaxInt = round(celsiusMax)
        let celsiusMinInt = round(celsiusMin)
        
        let fahrenheighMax = round(celsiusToFahrenheit(celsiusMax))
        let fahrenheighMin = round(celsiusToFahrenheit(celsiusMin))
        
        tempLabel.text = "\(celsiusMinInt) - \(celsiusMaxInt) °C \(fahrenheighMin) - \(fahrenheighMax) °F"

        forecastLabel.text = "\(TravelParameters.sharedInstance.title), for the next \(TravelParameters.sharedInstance.days) days, it is likely to "
        
        switch Weather.sharedInstance.weatherLikelyToBe.lowercaseString {
        case "clear":
            forecastLabel.text = forecastLabel.text! + "be clear."
        case "clouds":
            forecastLabel.text = forecastLabel.text! + "be cloudy."
        case "rain":
            forecastLabel.text = forecastLabel.text! + "be rainy."
        case "snow":
            forecastLabel.text = forecastLabel.text! + "be snowy."
        default:
            forecastLabel.text = forecastLabel.text! + "fine."
        }
        
        if Weather.sharedInstance.extremeWeather != "No Extreme Weather!" && Weather.sharedInstance.weatherLikelyToBe.lowercaseString != "rain" && Weather.sharedInstance.weatherLikelyToBe.lowercaseString != "snow" {
            forecastLabel.text = forecastLabel.text! + " And there is a possibility of \(Weather.sharedInstance.extremeWeather.lowercaseString)."
        }

    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        
        return PackingListModel.sharedInstance.packingList!.count
    }
    
    func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        
        return JSONHelper.sharedInstance.getSectionTitle(section)
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return JSONHelper.sharedInstance.getItemsCount(section)
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCellWithIdentifier("tableCell", forIndexPath: indexPath)
        
        JSONHelper.sharedInstance.getItemsList(indexPath.section)
        cell.textLabel?.text = PackingListModel.sharedInstance.originalList[indexPath.row]
    
        return cell
    }
    
    @IBAction func checkFullList(sender: AnyObject) {
        
        let navController = storyboard?.instantiateViewControllerWithIdentifier("editableList")
        presentViewController(navController!, animated: true, completion: nil)
        
    }
    
}

    

