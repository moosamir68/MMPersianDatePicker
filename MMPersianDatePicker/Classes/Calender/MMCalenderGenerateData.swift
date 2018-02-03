//
//  MMCalenderGenerateData.swift
//  VeeVappSeller
//
//  Created by Moosa Mir on 1/30/18.
//  Copyright © 2018 Noxel. All rights reserved.
//

import UIKit

class MMCalenderGenerateData: NSObject {
    
    func getYears(minDate:MMDate, maxDate:MMDate) -> [MMCalenderEntry]{
        var years = [MMCalenderEntry]()
        var index = 0
        for yearIndex in minDate.year.value...maxDate.year.value{
            let year = MMCalenderEntry(title: String(format:"%d", yearIndex), value: yearIndex, index:index)
            years.append(year)
            index = index + 1
        }
        
        return years
    }
    
    func getMonths() ->[MMCalenderEntry]{
        let farvardin = MMCalenderEntry(title: "فروردین", value: 1, index: 0)
        let ord = MMCalenderEntry(title: "اردیبشت", value: 2, index: 1)
        let khord = MMCalenderEntry(title: "خرداد", value: 3, index: 2)
        let tir = MMCalenderEntry(title: "تیر", value: 4, index: 3)
        let mord = MMCalenderEntry(title: "مرداد", value: 5, index: 4)
        let shah = MMCalenderEntry(title: "شهریور", value: 6, index: 5)
        let meh = MMCalenderEntry(title: "مهر", value: 7, index: 6)
        let aba = MMCalenderEntry(title: "آبان", value: 8, index: 7)
        let aza = MMCalenderEntry(title: "آذر", value: 9, index: 8)
        let day = MMCalenderEntry(title: "دی", value: 10, index: 9)
        let bah = MMCalenderEntry(title: "بهمن", value: 11, index: 10)
        let esf = MMCalenderEntry(title: "اسفند", value: 12, index: 11)
        
        return [farvardin, ord, khord, tir, mord, shah, meh, aba, aza , day, bah, esf]
    }
    
    func getDayes() ->[MMCalenderEntry]{
        var days = [MMCalenderEntry]()
        for dayIndex in 1...31 {
            let day = MMCalenderEntry(title: String(format:"%d", dayIndex), value: dayIndex, index: dayIndex - 1)
            days.append(day)
        }
        
        return days
    }
    
    func getMinDate() -> MMDate{
        let nowDate = Date()
        let calender = Calendar(identifier: .persian)
        let year = calender.component(.year, from: nowDate)
        let month = calender.component(.month, from: nowDate)
        let day = calender.component(.day, from: nowDate)
        
        return MMDate(year: MMCalenderEntry(title: String(format:"%d", year), value: year, index: 0), month: MMCalenderEntry(title: String(format:"%d", month), value: month, index: month - 1), day: MMCalenderEntry(title: String(format:"%d", day), value: day, index: day - 1))
    }
    
    func getMaxDate() -> MMDate{
        let nowDate = Date()
        let calender = Calendar(identifier: .persian)
        let year = calender.component(.year, from: nowDate) + 25
        let month = 12
        let day = 31
        
        return MMDate(year: MMCalenderEntry(title: String(format:"%d", year), value: year, index: 0), month: MMCalenderEntry(title: String(format:"%d", month), value: month, index: month - 1), day: MMCalenderEntry(title: String(format:"%d", day), value: day, index: day - 1))
    }
    
    func getDefaultDate() -> MMDate{
        let nowDate = Date()
        let calender = Calendar(identifier: .persian)
        let year = calender.component(.year, from: nowDate)
        let month = calender.component(.month, from: nowDate)
        let day = calender.component(.day, from: nowDate)
        
        return MMDate(year: MMCalenderEntry(title: String(format:"%d", year), value: year, index: 0), month: MMCalenderEntry(title: String(format:"%d", month), value: month, index: month - 1), day: MMCalenderEntry(title: String(format:"%d", day), value: day, index: day - 1))
    }
    
    
    func getMinDateFromSimpleDate(simpleDate:MMSimpleDate) -> MMDate{
        let indexYear = 0
        var indexMonth = 0
        var indexDay = 0
        
        if(simpleDate.month > 0 && simpleDate.month < 13){
            indexMonth = simpleDate.month - 1
        }
        if(simpleDate.day > 0  && simpleDate.day < 32){
            indexDay = simpleDate.day - 1
        }
        
        let minDate = MMDate(year: MMCalenderEntry(title: String(format:"%d", simpleDate.year), value: simpleDate.year, index: indexYear), month: MMCalenderEntry(title: String(format:"%d", simpleDate.month), value: simpleDate.month, index: indexMonth), day: MMCalenderEntry(title: String(format:"%d", simpleDate.day), value: simpleDate.day, index: indexDay))
        
        return minDate
    }
    
    
    func getMaxDateFromSimpleDate(simpleDate:MMSimpleDate, minDate:MMDate) -> MMDate{
        var indexYear = 0
        var indexMonth = 0
        var indexDay = 0
        
        if(simpleDate.year > 0 && simpleDate.year >= minDate.year.value){
            indexYear = simpleDate.year - minDate.year.value
        }
        
        if(simpleDate.month > 0 && simpleDate.month < 13){
            indexMonth = simpleDate.month - 1
        }
        if(simpleDate.day > 0  && simpleDate.day < 32){
            indexDay = simpleDate.day - 1
        }
        
        let maxDate = MMDate(year: MMCalenderEntry(title: String(format:"%d", simpleDate.year), value: simpleDate.year, index: indexYear), month: MMCalenderEntry(title: String(format:"%d", simpleDate.month), value: simpleDate.month, index: indexMonth), day: MMCalenderEntry(title: String(format:"%d", simpleDate.day), value: simpleDate.day, index: indexDay))
        
        return maxDate
    }
    
    
    func getDefaultDateFromSimpleDate(simpleDate:MMSimpleDate, minDate:MMDate, maxDate:MMDate) -> MMDate{
        var indexYear = 0
        var indexMonth = 0
        var indexDay = 0
        
        if(simpleDate.year > 0 && simpleDate.year >= minDate.year.value && simpleDate.year <= maxDate.year.value){
            indexYear = simpleDate.year - minDate.year.value
        }
        
        if(simpleDate.month > 0 && simpleDate.month < 13){
            indexMonth = simpleDate.month - 1
        }
        if(simpleDate.day > 0  && simpleDate.month < 32){
            indexDay = simpleDate.day - 1
        }
        
        let defaultDate = MMDate(year: MMCalenderEntry(title: String(format:"%d", simpleDate.year), value: simpleDate.year, index: indexYear), month: MMCalenderEntry(title: String(format:"%d", simpleDate.month), value: simpleDate.month, index: indexMonth), day: MMCalenderEntry(title: String(format:"%d", simpleDate.day), value: simpleDate.day, index: indexDay))
        
        return defaultDate
    }
}
