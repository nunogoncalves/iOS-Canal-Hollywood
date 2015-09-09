//
//  DayPickerController.swift
//  Canal Hollywood
//
//  Created by Nuno Gonçalves on 06/09/15.
//  Copyright (c) 2015 Nuno Gonçalves. All rights reserved.
//

import UIKit

protocol DateDelegate {
    func canceledDateSelection()
    func gotDate(date: NSDate)
}

class DayPickerController: UIViewController {
    
    @IBOutlet weak var datePicker: UIDatePicker!

    var dateDelegator: DateDelegate?
    
    @IBAction func cancelClicked(sender: AnyObject) {
        dateDelegator?.canceledDateSelection()
    }
    
    @IBAction func okClicked(sender: AnyObject) {
        dateDelegator?.gotDate(datePicker.date)
//        dismissViewControllerAnimated(true, completion: nil)
    }
    
    
}