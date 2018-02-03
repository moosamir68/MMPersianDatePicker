//
//  ASAlertViewController.swift
//  Artiscovery
//
//  Created by Moosa Mir on 10/18/17.
//  Copyright © 2017 Artiscovery. All rights reserved.
//
import UIKit

public protocol MMCalenderDelegate {
    func userDidTapOnConfirmDate(fromController:MMCalenderViewController?, withDate date:MMSimpleDate?)
    func userDidTapOnDismissCalender(fromController:MMCalenderViewController?)
}

public class MMCalenderViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {
    
    @IBOutlet var containerView: UIView!
    @IBOutlet var doneButton: UIButton!
    @IBOutlet var dismissView: UIView!
    @IBOutlet var calenderView: UIView!
    @IBOutlet var titleLabel: UILabel!
    @IBOutlet var lineUnderTitle: UIView!
    @IBOutlet var lineTopOfDoneButton: UIView!
    @IBOutlet var pickerView: UIPickerView!
    @IBOutlet var cancelButton: UIButton!
    
    public var delegate:MMCalenderDelegate?
    var minDate = MMDate()
    var maxDate = MMDate()
    var defaultDate = MMDate()
    var selectedDate = MMDate()
    
    public var titleDone:String = "تایید"
    public var titleCancel:String = "لغو"
    public var titleTextLabel:String = "انتخاب تاریخ"
    public var fontTitle:UIFont = UIFont.systemFont(ofSize: 14.0)
    public var fontButton:UIFont = UIFont.systemFont(ofSize: 14.0)
    public var fontRow:UIFont = UIFont.systemFont(ofSize: 14.0)
    public var colorRowInvalid:UIColor = .lightGray
    public var colorRow:UIColor = .black
    public var backgroundColorRow:UIColor = .white
    public var backgroundColorTitle:UIColor = .white
    public var backgroundColorCancel:UIColor = .red
    public var backgroundColorDone:UIColor = .blue
    public var colorLine:UIColor = .lightGray
    public var colorDone:UIColor = .white
    public var colorCancel:UIColor = .white
    public var heightRow:CGFloat = 44.0
    
    var years = [MMCalenderEntry]()
    var months = [MMCalenderEntry]()
    var days = [MMCalenderEntry]()
    
    var validator = MMCalenderValidator()
    
    public init(minDate:MMSimpleDate?, maxDate:MMSimpleDate?, defaultDate:MMSimpleDate?) {
        
        self.months = MMCalenderGenerateData().getMonths()
        
        self.days = MMCalenderGenerateData().getDayes()
        
        if(minDate == nil){
            self.minDate = MMCalenderGenerateData().getMinDate()
        }else{
            self.minDate = MMCalenderGenerateData().getMinDateFromSimpleDate(simpleDate: minDate!)
        }
        
        if(maxDate == nil){
            self.maxDate = MMCalenderGenerateData().getMaxDate()
        }else{
            self.maxDate = MMCalenderGenerateData().getMaxDateFromSimpleDate(simpleDate: maxDate!, minDate: self.minDate)
        }
        
        if(defaultDate == nil){
            self.defaultDate = MMCalenderGenerateData().getDefaultDate()
        }else{
            self.defaultDate = MMCalenderGenerateData().getDefaultDateFromSimpleDate(simpleDate: defaultDate!, minDate: self.minDate, maxDate: self.maxDate)
        }
        
        self.years = MMCalenderGenerateData().getYears(minDate:self.minDate , maxDate: self.maxDate)

        let (_, validDate, _) = validator.checkValidateYear(dateEntry: self.defaultDate, minDate: self.minDate, maxDate: self.maxDate)
        
        self.selectedDate = validDate!
        
        super.init(nibName: "MMCalenderViewController", bundle: Bundle(for: MMCalenderViewController.classForCoder()))
    }
    
    public required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    public override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.initUI()
        self.setSelectedDateOnUi()
    }

    public override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    public override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
    }
    
    //MARK:- initUI
    func initUI(){
        self.view.backgroundColor = .clear
        
        self.doneButton.backgroundColor = self.backgroundColorDone
        self.doneButton.layer.masksToBounds = true
        self.doneButton.titleLabel?.font = self.fontButton
        self.doneButton.setTitle(self.titleDone, for: .normal)
        self.doneButton.setTitleColor(self.colorDone, for: .normal)
        
        self.cancelButton.backgroundColor = self.backgroundColorCancel
        self.cancelButton.layer.masksToBounds = true
        self.cancelButton.titleLabel?.font = self.fontButton
        self.cancelButton.setTitle(self.titleCancel, for: .normal)
        self.cancelButton.setTitleColor(self.colorCancel, for: .normal)
        
        self.titleLabel.font = self.fontTitle
        self.titleLabel.text = self.titleTextLabel
        self.titleLabel.backgroundColor = self.backgroundColorTitle
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(MMCalenderViewController.dismissView(_:)))
        self.dismissView.addGestureRecognizer(tapGesture)
        
        self.cancelButton.addTarget(self, action: #selector(MMCalenderViewController.dismissView(_:)), for: .touchUpInside)
        
        self.lineUnderTitle.layer.masksToBounds = true
        self.lineUnderTitle.backgroundColor = self.colorLine
        self.lineTopOfDoneButton.layer.masksToBounds = true
        self.lineTopOfDoneButton.backgroundColor = self.colorLine
        
    }
    
    //Mark:- set date on ui
    func setDefaultDateOnUi(){
        self.pickerView.selectRow(self.defaultDate.year.index, inComponent: 0, animated: true)
        self.pickerView.selectRow(self.defaultDate.month.index, inComponent: 1, animated: true)
        self.pickerView.selectRow(self.defaultDate.day.index, inComponent: 2, animated: true)
    }
    
    func setSelectedDateOnUi(){
        self.pickerView.selectRow(self.selectedDate.year.index, inComponent: 0, animated: true)
        self.pickerView.selectRow(self.selectedDate.month.index, inComponent: 1, animated: true)
        self.pickerView.selectRow(self.selectedDate.day.index, inComponent: 2, animated: true)
    }
    
    //Mark:- picker delegate
    public func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 3
    }
    
    public func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        switch component {
        case 0:
            return self.years.count
        case 1:
            return self.months.count
        case 2:
            return self.days.count
        default:
            return 0
        }
    }
    
    public func pickerView(_ pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusing view: UIView?) -> UIView {

        let label = UILabel(frame: .zero)
        label.textAlignment = .center
        label.font = self.fontRow
        label.backgroundColor = self.backgroundColorRow
        label.textColor = self.colorRow
        
        var dataEntry:MMCalenderEntry = MMCalenderEntry()
        var isValidateThisDate = true
        var validateDate:MMDate?
        var validateType:MMCalenderEntryType?
        let dateCopy:MMDate = self.selectedDate.mutableCopy() as! MMDate
        switch component {
        case 0:
            dataEntry = self.years[row]
            
            dateCopy.year = dataEntry
            (isValidateThisDate, validateDate, validateType) = self.validator.checkValidateYear(dateEntry: dateCopy, minDate: self.minDate, maxDate: self.maxDate)
            if(!isValidateThisDate && validateType != nil && validateType == .year){
                label.textColor = self.colorRowInvalid
            }
        case 1:
            dataEntry = self.months[row]
            
            dateCopy.month = dataEntry
            (isValidateThisDate, validateDate, validateType) = self.validator.checkValidateMonth(dateEntry: dateCopy, minDate: self.minDate, maxDate: self.maxDate)
            if(!isValidateThisDate && validateType != nil && validateType == .month){
                label.textColor = self.colorRowInvalid
            }
        case 2:
            dataEntry = self.days[row]
            
            dateCopy.day = dataEntry
            (isValidateThisDate, validateDate, validateType) = self.validator.checkValidateDay(dateEntry: dateCopy, minDate: self.minDate, maxDate: self.maxDate)
            if(!isValidateThisDate && validateType != nil && validateType == .day){
                label.textColor = self.colorRowInvalid
            }
        default:
            break
        }
        
        label.text = dataEntry.title
        
        if(validateDate != nil){
            print(String(format:"date invalid = %d / %d / %d - date validate = %d / %d / %d", dateCopy.year.value, dateCopy.month.value, dateCopy.day.value, (validateDate?.year.value)!, (validateDate?.month.value)!, (validateDate?.day.value)!))
        }
        
        return label
    }
    
    public func pickerView(_ pickerView: UIPickerView, rowHeightForComponent component: Int) -> CGFloat {
        return self.heightRow
    }
    
    public func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        switch component {
        case 0:
            let dateCopy:MMDate = self.selectedDate.mutableCopy() as! MMDate
            dateCopy.year = self.years[row]
            let (isValidate, dateValid, _) = self.validator.checkValidateYear(dateEntry: dateCopy, minDate: self.minDate, maxDate: self.maxDate)
            if(isValidate){
                self.selectedDate = dateCopy
            }else{
                self.selectedDate = dateValid!
                self.setSelectedDateOnUi()
            }
            
            break
        case 1:
            let dateCopy:MMDate = self.selectedDate.mutableCopy() as! MMDate
            dateCopy.month = self.months[row]
            let (isValidate, dateValid, _) = self.validator.checkValidateMonth(dateEntry: dateCopy, minDate: self.minDate, maxDate: self.maxDate)
            if(isValidate){
                self.selectedDate = dateCopy
            }else{
                self.selectedDate = dateValid!
                self.setSelectedDateOnUi()
            }
            break
        case 2:
            let dateCopy:MMDate = self.selectedDate.mutableCopy() as! MMDate
            dateCopy.day = self.days[row]
            let (isValidate, dateValid, _) = self.validator.checkValidateDay(dateEntry: dateCopy, minDate: self.minDate, maxDate: self.maxDate)
            if(isValidate){
                self.selectedDate = dateCopy
            }else{
                self.selectedDate = dateValid!
                self.setSelectedDateOnUi()
            }
            break
        default:
            break
        }
        
        self.pickerView.reloadAllComponents()
        print(String(format:"Selected Date = %d / %d / %d", self.selectedDate.year.value, selectedDate.month.value, selectedDate.day.value))
    }
    
    //MARK:- user did tap
    @IBAction func dismissView(_ sender: AnyObject) {
        self.delegate?.userDidTapOnDismissCalender(fromController: self)
    }
    
    @IBAction func userDidTapOnConfirmButton(_ sender: Any) {
        
        let (_, validDate, _) = self.validator.checkValidateYear(dateEntry: self.selectedDate, minDate: self.minDate, maxDate: self.maxDate)
        let simpleValidDate = MMSimpleDate(year: (validDate?.year.value)!, month: (validDate?.month.value)!, day: (validDate?.day.value)!)
        self.delegate?.userDidTapOnConfirmDate(fromController: self, withDate: simpleValidDate)
        
    }
}
