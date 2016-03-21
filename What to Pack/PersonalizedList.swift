//
//  PersonalizedList.swift
//  What to Pack
//
//  Created by MoXiafang on 3/17/16.
//  Copyright © 2016 Momo. All rights reserved.
//

import Foundation
import CoreData

class PersonalizedList: NSManagedObject {
    
    @NSManaged var data: NSData?
    @NSManaged var location: Location
    
    override init(entity: NSEntityDescription, insertIntoManagedObjectContext context: NSManagedObjectContext?) {
        super.init(entity: entity, insertIntoManagedObjectContext: context)
    }
    
    init(data: NSData, context: NSManagedObjectContext) {
        let entity = NSEntityDescription.entityForName("PersonalizedList", inManagedObjectContext: context)!
        super.init(entity: entity, insertIntoManagedObjectContext: context)
        
        self.data = data
        
    }

    
}
