//
//  DateAddVC.swift
//  Organizer
//
//  Created by Lukasz Pik on 21.10.2017.
//  Copyright © 2017 Łukasz Pik. All rights reserved.
//

import UIKit
import CoreData

class DateAddVC: UIViewController {

    @IBOutlet weak var startDate: UIDatePicker!
    @IBOutlet weak var endDate: UIDatePicker!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let timeInterval = 3600.0 * 8.0
        endDate.date = startDate.date.addingTimeInterval(timeInterval)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    @IBAction func changeEndDateValue(_ sender: Any) {
        let timeInterval = 3600.0 * 8.0
        endDate.date = startDate.date.addingTimeInterval(timeInterval)
    }
    

    @IBAction func saveNewDate(_ sender: Any) {
        let context = getContext()
        let newDate = NSEntityDescription.insertNewObject(forEntityName: "WorkList", into: context)
        
        let secondsFromTimezone = TimeZone.current.secondsFromGMT()
        let start = (startDate.date.addingTimeInterval(TimeInterval(secondsFromTimezone))).description
        let startArr = start.components(separatedBy: " ")
        let end = (endDate.date.addingTimeInterval(TimeInterval(secondsFromTimezone))).description
        let endArr = end.components(separatedBy: " ")
        
        newDate.setValue(startArr[0], forKey: "date")
        newDate.setValue(startArr[1], forKey: "start")
        newDate.setValue(endArr[1], forKey: "end")
        
        do {
            try context.save()
        } catch {
            print("couldn't save new date")
        }
    }
}
