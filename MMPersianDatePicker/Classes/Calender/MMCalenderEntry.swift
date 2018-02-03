//
//  MMCalenderEntry.swift
//  VeeVappSeller
//
//  Created by Moosa Mir on 1/30/18.
//  Copyright © 2018 Noxel. All rights reserved.
//

import UIKit

class MMCalenderEntry: NSObject, NSMutableCopying {
    var title:String = ""
    var value:Int = 0
    var index:Int = 0
    
    override init(){
        super.init()
    }
    
    init(title:String = "", value:Int = 0, index:Int = 0) {
        super.init()
        
        self.index = index
        self.title = title
        self.value = value
    }
    
    func mutableCopy(with zone: NSZone? = nil) -> Any {
        let newObject = MMCalenderEntry()
        newObject.title = self.title
        newObject.value = self.value
        newObject.index = self.index
        
        return newObject
    }
}

enum MMCalenderEntryType:Int {
    case year = 0
    case month = 1
    case day = 2
}
