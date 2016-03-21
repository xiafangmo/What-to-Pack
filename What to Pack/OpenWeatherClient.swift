//
//  OpenWeatherClient.swift
//  What to Pack
//
//  Created by MoXiafang on 3/1/16.
//  Copyright © 2016 Momo. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

class OpenWeatherClient: NSObject {
    
    static let sharedInstance = OpenWeatherClient()
    
    func getWeather(lat: Double, lon: Double, cnt: Int, completionHandler: (success: Bool?, result: [String: AnyObject]?, errorString: String?) -> Void) {
        let methodParameters = [Keys.lat: lat, Keys.lon: lon, Keys.cnt: cnt, Keys.mode: Keys.json, Keys.appID: Constants.openWeatherAPIKey]
        
        Alamofire.request(.GET, Constants.baseUrl, parameters: methodParameters as? [String : AnyObject]).validate().responseJSON { response in

                switch response.result {
                case .Success:
                    if let value = response.result.value {
                        let json = JSON(value)
                        let list: Array<JSON> = json["list"].arrayValue
                        
                        var maxTempList = [Double]()
                        var minTempList = [Double]()
                        var forecast = [String]()
                        for item in list {
                            let maxOfTheDay = item["temp"]["max"].double
                            maxTempList.append(maxOfTheDay!)
                            let minOfTheDay = item["temp"]["min"].double
                            minTempList.append(minOfTheDay!)
                            
                            let weatherList: Array<JSON> = item["weather"].arrayValue
                            for weather in weatherList {
                                let weatherOfTheDay = weather["main"].string
                                forecast.append(weatherOfTheDay!)
                            }
                        }
                        
                        let forecastCast = forecast.frequencies()
                        
                        let weatherLikelyToBe = forecastCast[0].0
                        
                        var extremeWeather: String!
                        
                        if forecast.contains("Snow") {
                            extremeWeather = "Snow"
                        } else if forecast.contains("Rain") {
                            extremeWeather = "Rain"
                        } else {
                            extremeWeather = "No Extreme Weather!"
                        }
                        
                        let maxTemp = maxTempList.maxElement()!
                        let minTemp = minTempList.minElement()!
                        
                        let resultDictory = ["maxTemp": maxTemp as Double, "minTemp": minTemp as Double, "weatherLikelyToBe": weatherLikelyToBe as String, "extremeWeather": extremeWeather as String]
                        
                        completionHandler(success: true, result: resultDictory as? [String : AnyObject], errorString: nil)
                    }
                case .Failure(let error):
                    completionHandler(success: false, result: nil, errorString: error.localizedDescription)
                }
        }
    }

}

extension SequenceType where Generator.Element: Hashable {
    
    //Get the most common element of a certain array
    func frequencies() -> [(Generator.Element,Int)] {
        
        var frequency: [Generator.Element:Int] = [:]
        
        for x in self {
            frequency[x] = (frequency[x] ?? 0) + 1
        }
        
        return frequency.sort { $0.1 > $1.1 }
    }
}
