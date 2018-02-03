//
//  ViewController.swift
//  MMPersianDatePicker
//
//  Created by Moosa Mir on 02/03/2018.
//  Copyright (c) 2018 Moosa Mir. All rights reserved.
//

import UIKit
import MMPersianDatePicker

let DEFAULT_FONT_NAME_LIGHT = "IRANSansMobileFaNum-Light"
let DEFAULT_FONT_NAME_BOLD = "IRANSansMobileFaNum-Bold"

class ViewController: UIViewController, MMCalenderDelegate {
    
    
    @IBOutlet weak var button: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    @IBAction func userDidTapOnButton(_ sender: UIButton) {
        self.showDatePicker()
    }
    
    func showDatePicker(){
        let nowDate = Date()
        let calender = Calendar(identifier: .persian)
        let year = calender.component(.year, from: nowDate)
        let month = calender.component(.month, from: nowDate)
        let day = calender.component(.day, from: nowDate)
        
        let minDate = MMSimpleDate(year: year, month: month, day: day)
        let maxDate = MMSimpleDate(year: year + 25, month: 12, day: 31)
        let defaultDate = minDate.mutableCopy() as! MMSimpleDate
        
        let controller  = MMCalenderViewController(minDate: nil, maxDate: nil, defaultDate: nil)
        controller.transitioningDelegate = self
        controller.fontRow = UIFont(name: DEFAULT_FONT_NAME_LIGHT, size: 14.0)!
        controller.fontButton = UIFont(name: DEFAULT_FONT_NAME_BOLD, size: 14.0)!
        controller.fontTitle =  UIFont(name: DEFAULT_FONT_NAME_BOLD, size: 14.0)!
        controller.backgroundColorDone = UIColor(displayP3Red:52.0/255.0, green: 74.0/255.0, blue: 99.0/255.0, alpha: 1.000)
        controller.backgroundColorCancel = .lightGray
        controller.delegate = self
        
        self.present(controller, animated: true) {
            
        }
    }
    
    //MARK:- calender delegate
    func userDidTapOnDismissCalender(fromController: MMCalenderViewController?) {
        fromController?.dismiss(animated: true, completion: {
            
        })
    }
    
    func userDidTapOnConfirmDate(fromController: MMCalenderViewController?, withDate date: MMSimpleDate?) {
        self.button.setTitle(String(format:"%d/%d/%d", date!.year, date!.month, date!.day), for: .normal)
        fromController?.dismiss(animated: true, completion: {
            
        })
    }
}

extension ViewController:UIViewControllerTransitioningDelegate{
    //MARK:- transition Delegate
    
    func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        print("animation dismiss")
        if(dismissed.isKind(of: MMCalenderViewController.classForCoder())){
            return AnimationFromCalenderControllerToController()
        }
        return nil
    }
    
    func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        print("animation present")
        if(presented.isKind(of: MMCalenderViewController.classForCoder())){
            return AnimationFromControllerToCalenderController()
        }
        
        return nil
    }
}
