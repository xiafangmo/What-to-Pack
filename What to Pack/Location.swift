//
//  Location.swift
//  What to Pack
//
//  Created by MoXiafang on 3/5/16.
//  Copyright © 2016 Momo. All rights reserved.
//

import Foundation
import CoreData

class Location: NSManagedObject {
    
    @NSManaged var lat: NSNumber
    @NSManaged var lon: NSNumber
    @NSManaged var title: String
    @NSManaged var list: PersonalizedList
    
    override init(entity: NSEntityDescription, insertIntoManagedObjectContext context: NSManagedObjectContext?) {
        super.init(entity: entity, insertIntoManagedObjectContext: context)
    }
    
    init(lat: Double, lon: Double, title: String?, context: NSManagedObjectContext) {
        let entity = NSEntityDescription.entityForName("Location", inManagedObjectContext: context)!
        super.init(entity: entity, insertIntoManagedObjectContext: context)
        
        self.lat = lat
        self.lon = lon
        
        if let title = title {
            self.title = title
        } else {
            self.title = "Unknown"
        }
    }
    
}