//
//  PackingListModel.swift
//  What to Pack
//
//  Created by MoXiafang on 3/12/16.
//  Copyright © 2016 Momo. All rights reserved.
//

import Foundation
import SwiftyJSON


struct PackingListModel {
    
    static var sharedInstance = PackingListModel()
    
    var packingList: [JSON]!
    var originalList: [String]!
    var editableList: [String]!
    var personalizedDic: [String: Bool]!

}