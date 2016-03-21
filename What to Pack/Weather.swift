//
//  Weather.swift
//  What to Pack
//
//  Created by MoXiafang on 3/5/16.
//  Copyright © 2016 Momo. All rights reserved.
//

import Foundation

struct Weather {
    
    static var sharedInstance = Weather()
    
    var maxTemp: Double!
    var minTemp: Double!
    var weatherLikelyToBe: String!
    var extremeWeather: String!
    
}