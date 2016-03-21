//
//  SearchHelper.swift
//  What to Pack
//
//  Created by MoXiafang on 3/1/16.
//  Copyright © 2016 Momo. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON


class SearchHelper: NSObject {
    
    static let sharedInstance = SearchHelper()
    
    func getDestination(correctedAddress: String, completionHandler: (result: [String: Double]?, error: NSError?) -> Void) {
        
        let url = NSURL(string: "https://maps.googleapis.com/maps/api/geocode/json?address=\(correctedAddress)&sensor=false")
        
        Alamofire.request(.GET, url!).validate().responseJSON { response in
            switch response.result {
            case .Success:
                if let value = response.result.value {
                    let json = JSON(value)
                    let lat = json["results"][0]["geometry"]["location"]["lat"].double!
                    let lon = json["results"][0]["geometry"]["location"]["lng"].double!
                    let resultDictionary = ["lat" : lat, "lon" : lon]
                    completionHandler(result: resultDictionary, error: nil)
                }
            case .Failure(let error):
                completionHandler(result: nil, error: error)
            }
        }
    }

}

    
    
