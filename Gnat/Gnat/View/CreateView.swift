//
//  CreateView.swift
//  Gnat
//
//  Created by Kyle Roberts on 4/6/16.
//  Copyright © 2016 floundertech. All rights reserved.
//

import UIKit
import CoreData

class CreateView: UIView, UITextFieldDelegate, UIPickerViewDelegate, UIPickerViewDataSource {
    
    @IBOutlet weak var view: UIView!
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var messageTextField: UITextField!
    @IBOutlet weak var startTimeTextField: UITextField!
    @IBOutlet weak var endTimeTextField: UITextField!
    @IBOutlet weak var frequencyTextField: UITextField!
    @IBOutlet weak var unitTextField: UITextField!
    @IBOutlet weak var daysSegmentedControl: UISegmentedControl!
    
    var dateFormatter = NSDateFormatter()
    var datePicker = UIDatePicker()
    var frequencyPicker = UIPickerView()
    var frequencyUnitPicker = UIPickerView()
    
    var startTime: NSDate!
    var endTime: NSDate!
    var frequencyUnit: FrequencyUnit!
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        NSBundle .mainBundle().loadNibNamed("CreateView", owner: self, options: nil)
        self.addSubview(self.view)
        
        setUpDatePicker()
        setUpFrequencyPickers()
    }
    
    func setUpDatePicker() {
        datePicker.date = NSDate()
        datePicker.datePickerMode = .Time
        datePicker.backgroundColor = UIColor.whiteColor()
        datePicker.addTarget(self, action: #selector(CreateView.datePickerDateChanged), forControlEvents: .ValueChanged)
        
        dateFormatter.dateStyle = .FullStyle
        
        startTimeTextField.inputView = datePicker
        startTimeTextField.text = dateFormatter.stringFromDate(datePicker.date)
        endTimeTextField.inputView = datePicker
        endTimeTextField.text = dateFormatter.stringFromDate(datePicker.date)
    }
    
    func setUpFrequencyPickers() {
        frequencyTextField.text = "1"
        frequencyTextField.inputView = frequencyPicker
        frequencyPicker.backgroundColor = UIColor.whiteColor()
        frequencyPicker.delegate = self
        frequencyPicker.dataSource = self
        
        unitTextField.text = frequencyUnitLabel(FrequencyUnit(rawValue: 0)!)
        unitTextField.inputView = frequencyUnitPicker
        frequencyUnitPicker.backgroundColor = UIColor.whiteColor()
        frequencyUnitPicker.delegate = self
        frequencyUnitPicker.dataSource = self
    }
    
    @IBAction func daysSegmentTapped(sender: AnyObject) {
    }
    
    @IBAction func saveButtonTapped(sender: AnyObject) {
        let context = (UIApplication.sharedApplication().delegate as! AppDelegate).managedObjectContext
        let gnat = NSEntityDescription.insertNewObjectForEntityForName("Gnat", inManagedObjectContext: context) as! Gnat
        gnat.title = nameTextField.text!
        gnat.message = messageTextField.text!
        gnat.startTime = startTime
        gnat.endTime = endTime
        gnat.frequency = Int(frequencyTextField.text!)!
        gnat.frequencyUnit = frequencyUnit
        gnat.days = daysFromSegmentedControl()
    }
    
    func datePickerDateChanged(sender: AnyObject) {
        let date = datePicker.date
        let string = dateFormatter.stringFromDate(date)
        if startTimeTextField.isFirstResponder() {
            startTime = date
            startTimeTextField.text = string
        } else if endTimeTextField.isFirstResponder() {
            endTime = date
            endTimeTextField.text = string
        }
    }
    
    func setStartTimePickerLimits() {
    }
    
    func setEndTimePickerLimits() {
        
    }
    
    func daysFromSegmentedControl() -> [String] {
        return []
    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        endEditing(true)
        return true
    }
    
    // Mark: - UIPickerView Delegate & DataSource
    
    func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if pickerView == frequencyPicker {
            return 99
        } else if pickerView == frequencyUnitPicker {
            return 3
        }
        
        return 0
    }
    
    func pickerView(pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if pickerView == frequencyPicker {
            return "\(row + 1)"
        } else if pickerView == frequencyUnitPicker {
            return frequencyUnitLabel(FrequencyUnit(rawValue: row)!)
        }
        
        return nil
    }
    
    func pickerView(pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if pickerView == frequencyPicker {
            frequencyTextField.text = "\(row + 1)"
        } else if pickerView == frequencyUnitPicker {
            frequencyUnit = FrequencyUnit(rawValue: row)
            unitTextField.text = frequencyUnitLabel(frequencyUnit)
        }
    }
    
    // MARK: - First Responder
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        super.touchesBegan(touches, withEvent: event)
        
        self.view.endEditing(true)
    }
}
