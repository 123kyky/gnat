//
//  CreateView.swift
//  Gnat
//
//  Created by Kyle Roberts on 4/6/16.
//  Copyright © 2016 floundertech. All rights reserved.
//

import UIKit
import CoreData

class CreateView: UIView, UITextFieldDelegate {
    
    @IBOutlet weak var view: UIView!
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var messageTextField: UITextField!
    @IBOutlet weak var startTimeTextField: UITextField!
    @IBOutlet weak var endTimeTextField: UITextField!
    @IBOutlet weak var frequencyTextField: UITextField!
    @IBOutlet weak var unitTextField: UITextField!
    @IBOutlet weak var daysSegmentedControl: UISegmentedControl!
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        NSBundle .mainBundle().loadNibNamed("CreateView", owner: self, options: nil)
        self.addSubview(self.view)
    }
    
    @IBAction func daysSegmentTapped(sender: AnyObject) {
    }
    
    @IBAction func saveButtonTapped(sender: AnyObject) {
        let context = (UIApplication.sharedApplication().delegate as! AppDelegate).managedObjectContext
        let gnat = NSEntityDescription.insertNewObjectForEntityForName("Gnat", inManagedObjectContext: context) as! Gnat
        gnat.title = nameTextField.text!
    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        endEditing(true)
        return true
    }
}
