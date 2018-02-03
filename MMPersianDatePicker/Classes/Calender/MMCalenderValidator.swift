//
//  MMCalenderValidator.swift
//  VeeVappSeller
//
//  Created by Moosa Mir on 1/30/18.
//  Copyright © 2018 Noxel. All rights reserved.
//

import UIKit

class MMCalenderValidator: NSObject {
    
    override init() {
        super.init()
    }
    
    func checkValidateDay(dateEntry date:MMDate, minDate:MMDate, maxDate:MMDate) -> (isValidate:Bool, validateDate:MMDate?, invalidComponent:MMCalenderEntryType?){
        
        if(date.year.value >= maxDate.year.value){
            if(date.month.value >= maxDate.month.value){
                if(date.day.value > maxDate.day.value){
                    let dateCopy:MMDate = date.mutableCopy() as! MMDate
                    dateCopy.day = (maxDate.mutableCopy() as!MMDate).day
                    return (false, dateCopy, .day)
                }
            }
        }
        
        if(date.year.value <= minDate.year.value){
            if(date.month.value <= minDate.month.value){
                if(date.day.value < minDate.day.value){
                    let dateCopy:MMDate = date.mutableCopy() as! MMDate
                    dateCopy.day = (minDate.mutableCopy() as!MMDate).day
                    return (false, dateCopy, .day)
                }
            }
        }
        
        switch date.month.value {
        case 1, 2, 3, 4, 5, 6: break
        case 7, 8, 9, 10, 11:
            if(date.day.value > 30){
                let dateCopy:MMDate = date.mutableCopy() as! MMDate
                dateCopy.day.value = 30
                dateCopy.day.index = 29
                return (false, dateCopy, .day)
            }
            break
        case 12:
            if(date.year.value % 4 == 3){
                if(date.day.value > 30){
                    let dateCopy:MMDate = date.mutableCopy() as! MMDate
                    dateCopy.day.value = 30
                    dateCopy.day.index = 29
                    return (false, dateCopy, .day)
                }
                break
            }else{
                if(date.day.value > 29){
                    let dateCopy:MMDate = date.mutableCopy() as! MMDate
                    dateCopy.day.value = 29
                    dateCopy.day.index = 28
                    return (false, dateCopy, .day)
                }
                break
            }
        default:
            break
        }
        return (true, date, .day)
    }
    
    func checkValidateMonth(dateEntry date:MMDate, minDate:MMDate, maxDate:MMDate) -> (isValidate:Bool, validateDate:MMDate?, invalidComponent:MMCalenderEntryType?){
        
        if(date.year.value >= maxDate.year.value){
            if(date.month.value > maxDate.month.value){
                let dateCopy:MMDate = date.mutableCopy() as! MMDate
                dateCopy.month = (maxDate.mutableCopy() as!MMDate).month
                
                let (isValidateDay, validDate, _) = self.checkValidateDay(dateEntry: dateCopy, minDate: minDate, maxDate: maxDate)
                if(!isValidateDay){
                    return (false, validDate, .month)
                }
                return (false, dateCopy, .month)
            }
        }
        
        if(date.year.value <= minDate.year.value){
            if(date.month.value < minDate.month.value){
                let dateCopy:MMDate = date.mutableCopy() as! MMDate
                dateCopy.month = (minDate.mutableCopy() as!MMDate).month
                
                let (isValidateDay, validDate, _) = self.checkValidateDay(dateEntry: dateCopy, minDate: minDate, maxDate: maxDate)
                if(!isValidateDay){
                    return (false, validDate, .month)
                }
                return (false, dateCopy, .month)
            }
        }
        
        let (isValidateDay, validDate, invalidType) = self.checkValidateDay(dateEntry: date, minDate: minDate, maxDate: maxDate)
        return (isValidateDay, validDate, invalidType)
    }
    
    func checkValidateYear(dateEntry date:MMDate, minDate:MMDate, maxDate:MMDate) -> (isValidate:Bool, validateDate:MMDate?, invalidComponent:MMCalenderEntryType?){
        let (isValidateDay, validDate, invalidType) = self.checkValidateMonth(dateEntry: date, minDate: minDate, maxDate: maxDate)
        return (isValidateDay, validDate, invalidType)
    }
}
