//
//  ItemAddVC.swift
//  Organizer
//
//  Created by Lukasz Pik on 20.10.2017.
//  Copyright © 2017 Łukasz Pik. All rights reserved.
//

import UIKit
import CoreData

class ItemAddVC: UIViewController {

    @IBOutlet weak var itemText: UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func saveNewItem(_ sender: Any) {
        let context = getContext()
        
        let newItem = NSEntityDescription.insertNewObject(forEntityName: "ShopList", into: context)
        newItem.setValue(itemText.text, forKey: "item")
        newItem.setValue(false, forKey: "isBought")
        
        do {
            try context.save()
            print("Save")
            itemText.text = ""
        } catch {
            print("Cannot save new item")
        }
    }

}
