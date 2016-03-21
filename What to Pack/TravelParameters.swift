//
//  TravelParameters.swift
//  What to Pack
//
//  Created by MoXiafang on 3/8/16.
//  Copyright © 2016 Momo. All rights reserved.
//

import Foundation

struct TravelParameters {
    
    static var sharedInstance = TravelParameters()
    
    var lat: Double!
    var lon: Double!
    var title: String!
    var days: Int!
    var travelType: String! = "Business"
    var travelPeople: Int! = 1
}