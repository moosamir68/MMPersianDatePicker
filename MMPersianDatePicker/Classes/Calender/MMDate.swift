//
//  MMDate.swift
//  VeeVappSeller
//
//  Created by Moosa Mir on 1/30/18.
//  Copyright © 2018 Noxel. All rights reserved.
//

import UIKit

class MMDate: NSObject, NSMutableCopying {
    var year = MMCalenderEntry()
    var month = MMCalenderEntry()
    var day = MMCalenderEntry()
    
    override init() {
        super.init()
    }
    
    init(year:MMCalenderEntry = MMCalenderEntry(), month:MMCalenderEntry = MMCalenderEntry(), day:MMCalenderEntry = MMCalenderEntry()) {
        super.init()
        
        self.year = year
        self.month = month
        self.day = day
    }
    
    func mutableCopy(with zone: NSZone? = nil) -> Any {
        let newObject = MMDate()
        newObject.year = self.year.mutableCopy() as! MMCalenderEntry
        newObject.month = self.month.mutableCopy() as! MMCalenderEntry
        newObject.day = self.day.mutableCopy() as! MMCalenderEntry

        return newObject
    }
}

public class MMSimpleDate: NSObject, NSMutableCopying {
    public var year:Int = 0
    public var month:Int = 0
    public var day:Int = 0
    
    public override init() {
        super.init()
    }
    
    public init(year:Int = 1, month:Int = 1, day:Int = 1) {
        super.init()
        
        self.year = year
        self.month = month
        self.day = day
    }
    
    public func mutableCopy(with zone: NSZone? = nil) -> Any {
        let newObject = MMSimpleDate()
        newObject.year = self.year
        newObject.month = self.month
        newObject.day = self.day
        
        return newObject
    }
    
    public func getTimeStamp() -> Double{
        let calender = Calendar(identifier: .persian)
        var components = DateComponents()
        components.year = self.year
        components.month = self.month
        components.day = self.day
        let date = calender.date(from: components)
        let timeStamp = date?.timeIntervalSince1970
        return timeStamp!
    }
    
    public static func getSimpleDateFromTimeStamp(timeStamp:Double) ->MMSimpleDate{
        let date = Date(timeIntervalSince1970: timeStamp)
        let calender = Calendar(identifier: .persian)
        let year = calender.component(.year, from: date)
        let month = calender.component(.month, from: date)
        let day = calender.component(.day, from: date)
        
        return MMSimpleDate(year: year, month: month, day: day)
    }
}
