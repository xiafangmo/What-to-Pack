//
//  JSONHelper.swift
//  What to Pack
//
//  Created by MoXiafang on 3/12/16.
//  Copyright © 2016 Momo. All rights reserved.
//

import Foundation
import SwiftyJSON

class JSONHelper: NSObject {
    
    static let sharedInstance = JSONHelper()
    
    func jsonParsingFromFile() {
        
        var mainJSON: JSON!
        var extraJSON: JSON!
        
        if let packingListJSON = NSBundle.mainBundle().URLForResource("PackingList", withExtension: "json") {
            if let rawData = NSData(contentsOfURL: packingListJSON) {
                let json = JSON(data: rawData)
                if json != nil {
                    mainJSON = json
                }
            }
        }
        
        if let extraPackingListJSON = NSBundle.mainBundle().URLForResource("ExtraPackingList", withExtension: "json") {
            if let rawData = NSData(contentsOfURL: extraPackingListJSON) {
                let json = JSON(data: rawData)
                if json != nil {
                    switch TravelParameters.sharedInstance.travelType {
                    case "Business": extraJSON = json[1]
                    case "Beach": extraJSON = json[2]
                    case "Adventure": extraJSON = json[0]
                    case "Vacation": extraJSON = json[3]
                    default: break
                    }
                }
            }
        }
        
        let completeArray = mainJSON.arrayValue + extraJSON.arrayValue
        PackingListModel.sharedInstance.packingList = completeArray
    }
    
    func getSectionTitle(section: Int) -> String! {
        var sectionTitle: String?
        for (key, _) in PackingListModel.sharedInstance.packingList[section] {
            sectionTitle = key
        }
        return sectionTitle
    }
    
    func getItemsCount(section: Int) -> Int {
        var count = 0
        
        for (_, value) in PackingListModel.sharedInstance.packingList![section] {
            if let arr = value.array {
                count = arr.count
            } else if let dic = value.dictionary {
                for (_, dicValue) in dic {
                    count += dicValue.arrayValue.count
                }
            }
        }
        return count
    }
    
    func getItemsList(section: Int) {
        PackingListModel.sharedInstance.originalList = dealWithJSON(section)
    }
    
    func getItemsFullList() {
        
        var fullItems = [String]()
        
        let count = PackingListModel.sharedInstance.packingList.count 
        for n in 0...count - 1 {
            fullItems += dealWithJSON(n)
            }
        PackingListModel.sharedInstance.editableList = fullItems
    }
    
    func dealWithJSON(number: Int) -> [String] {
        
        var items = [String]()
        
        for (_, value) in PackingListModel.sharedInstance.packingList![number] {
            if let arr = value.array {
                for item in arr {
                    items.append(item.stringValue)
                }
            } else if let dic = value.dictionary {
                for (_, dicValue) in dic {
                    for item in dicValue.arrayValue {
                        items.append(item.stringValue)
                    }
                }
            }
        }
        return items
    }
    
}