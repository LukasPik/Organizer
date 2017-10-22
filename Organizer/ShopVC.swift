//
//  ShopVC.swift
//  Organizer
//
//  Created by Lukasz Pik on 20.10.2017.
//  Copyright © 2017 Łukasz Pik. All rights reserved.
//

import UIKit
import CoreData

class ShopVC: UITableViewController {

    var shopArray: [NSManagedObject] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let context = getContext()
        
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "ShopList")
        request.returnsObjectsAsFaults = false
        
        do {
            let results = try context.fetch(request)
            
            print(results.count)
            if results.count > 0 {
                shopArray = results as! [NSManagedObject]
            }
            
        } catch {
            createAlert(title: "Error", message: "Couldn't get data")
        }
        
        tableView.reloadData()
        self.navigationItem.rightBarButtonItem = self.editButtonItem
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return shopArray.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ShopCell", for: indexPath) as! ShopCell
        cell.label.text = shopArray[indexPath.row].value(forKey: "item") as? String
        cell.state.isOn = shopArray[indexPath.row].value(forKey: "isBought") as! Bool
        
        return cell
    }
    
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        
        let context = getContext()
        if editingStyle == .delete {
            // Delete the row from the data source
            let object = shopArray[indexPath.row]
            shopArray.remove(at: indexPath.row)
            context.delete(object)
            
            do {
                try context.save()
            } catch {
                createAlert(title: "Error", message: "Couldn't delete requested item")
            }
            
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }

    @IBAction func deleteAll(_ sender: Any) {
        //add alert with confirmation
        let alert = UIAlertController(title: "Please confirm", message: "Do you want to delete all items in list?", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Yes", style: .destructive, handler: { (alertAction) in
            let context = self.getContext()
            for object in self.shopArray {
                context.delete(object)
            }
            
            do {
                try context.save()
                self.shopArray.removeAll()
                self.tableView.reloadData()
            } catch let error as NSError {
                print("Couldnt save \(error)")
            } catch {
                
            }
            
        }))
        alert.addAction(UIAlertAction(title: "No", style: .cancel, handler: nil))
        self.present(alert, animated: true, completion: nil)
   
    }
    
}
