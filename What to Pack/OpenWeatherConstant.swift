//
//  OpenWeatherConstant.swift
//  What to Pack
//
//  Created by MoXiafang on 3/1/16.
//  Copyright © 2016 Momo. All rights reserved.
//

import Foundation

extension OpenWeatherClient {
    
    struct Constants {
        static let openWeatherAPIKey = "Open-Weather-API-Key"
        static let baseUrl: String = "http://api.openweathermap.org/data/2.5/forecast//daily"
    }
    
    struct Keys {
        static let lat = "lat"
        static let lon = "lon"
        static let cnt = "cnt"
        static let mode = "mode"
        static let json = "json"
        static let appID = "appid"
    }
    
}