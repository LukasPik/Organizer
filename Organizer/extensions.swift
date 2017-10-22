//
//  extensions.swift
//  Organizer
//
//  Created by Lukasz Pik on 22.10.2017.
//  Copyright © 2017 Łukasz Pik. All rights reserved.
//

import Foundation
import CoreData
import UIKit

extension UIViewController {
    
    func getContext() -> NSManagedObjectContext {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        return appDelegate.persistentContainer.viewContext
    }
    
    func createAlert(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    
}
