//
//  WorkVC.swift
//  Organizer
//
//  Created by Lukasz Pik on 20.10.2017.
//  Copyright © 2017 Łukasz Pik. All rights reserved.
//

import UIKit
import CoreData

class WorkVC: UITableViewController {

    var dateArray: [NSManagedObject] = []
    
    
    func getContext() -> NSManagedObjectContext {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        
        return appDelegate.persistentContainer.viewContext
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let context = getContext()
        
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "WorkList")
        request.returnsObjectsAsFaults = false
        
        do {
            let results = try context.fetch(request)
            if results.count > 0 {
                dateArray = results as! [NSManagedObject]
                dateArray = dateArray.sorted(by: { (first, second) -> Bool in
                    if first.value(forKey: "date") as! String > second.value(forKey: "date") as! String {
                        return false
                    }
                    return true
                })
            }
        } catch {
            // error handling
        }
        
        var todayDate: String = String(describing: Date()).components(separatedBy: "-")[2].components(separatedBy: " ")[0]
        
        todayDate += "-" + Date().description.components(separatedBy: "-")[1]
        print(todayDate)
        if dateArray.count > 0 {
            print((dateArray[0].value(forKey: "date") as! String).reversed())
        }
        var row = 0;
        for obj in dateArray {
            let dateArr = (obj.value(forKey: "date") as! String).components(separatedBy: "-")
            let objDate = String("\(dateArr[2])-\(dateArr[1])")
            print(objDate)
            if objDate < todayDate {
                let context = getContext()
                context.delete(obj)
                
                do {
                    try context.save()
                    dateArray.remove(at: row)
                    row -= 1
                } catch {
                    //error handling
                }
            }
            row += 1
        }
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
        tableView.rowHeight = 100
        tableView.reloadData()
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
        return dateArray.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "WorkCell", for: indexPath) as! HoursCell
        
        
        let dateString: String = dateArray[indexPath.row].value(forKey: "date") as! String
        let startTime = dateArray[indexPath.row].value(forKey: "start") as! String
        let endTime = dateArray[indexPath.row].value(forKey: "end") as! String
        let dateArr = dateString.components(separatedBy: "-")
        let startArr = startTime.components(separatedBy: ":")
        let endArr = endTime.components(separatedBy: ":")
        
        cell.dateLabel.text = String("\(dateArr[2])-\(dateArr[1])")
        cell.startLabel.text = String("\(startArr[0]):\(startArr[1])")
        cell.endLabel.text = String("\(endArr[0]):\(endArr[1])")

        return cell
    }
 

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let context = getContext()
            let object = dateArray[indexPath.row]
            
            context.delete(object)
            do {
                try context.save()
                dateArray.remove(at: indexPath.row)
            } catch {
                // error handler
            }
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
            
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
 

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
}
