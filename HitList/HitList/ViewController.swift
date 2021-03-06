//
//  ViewController.swift
//  HitList
//
//  Created by Linh Tran on 03/06/16.
//  Copyright © 2016 Linh Tran. All rights reserved.
//

import UIKit
import CoreData

class ViewController: UIViewController, UITableViewDataSource  {
    
    // MARK: Properties
    @IBOutlet weak var tableView: UITableView!
    var people = [NSManagedObject]()
    
    
    // MARK: Actions
    @IBAction func addName(sender: AnyObject) {

        let alert = UIAlertController(title: "New name", message: "Add a new name", preferredStyle: .Alert)
        
        let saveAction = UIAlertAction(title: "Save", style: .Default, handler: { (action:UIAlertAction) -> Void in
            let textField = alert.textFields!.first
            self.saveName(textField!.text!)
            self.tableView.reloadData()
        })
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .Default, handler: {(action: UIAlertAction) -> Void in})
        
        alert.addTextFieldWithConfigurationHandler { (textField: UITextField) -> Void in}

        
        alert.addAction(saveAction)
        alert.addAction(cancelAction)
        
        presentViewController(alert, animated: true, completion: nil)
    }
    
    func saveName(name: String) {
        let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        
        let managedContext = appDelegate.managedObjectContext
        
        let entity = NSEntityDescription.entityForName("Person", inManagedObjectContext: managedContext)
        
        let person = NSManagedObject(entity: entity!, insertIntoManagedObjectContext: managedContext)
        
        person.setValue(name, forKey: "name")
        
        do {
            try managedContext.save()
            people.append(person)
        } catch let error as NSError {
             print("Could not save \(error), \(error.userInfo)")
        }
    }
    
    
    // MARK: UITableViewDataSource 
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return people.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCellWithIdentifier("Cell")
        let person = people[indexPath.row]
        cell!.textLabel!.text = person.valueForKey("name") as? String
        
        return cell!
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "\"The List\""
        tableView.registerClass(UITableViewCell.self, forCellReuseIdentifier: "Cell")
    }
    
    // Fetching records from persistent store into the context
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        // grab the reference of the AppDelegate.swift
        let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        
        let managedContext = appDelegate.managedObjectContext
        
        //NSFetchRequest class is responsible for fetching from Core Data
        let fetchRequest = NSFetchRequest(entityName: "Person")
        
        do {
            // execute the fetch request
            let results = try managedContext.executeFetchRequest(fetchRequest)
            
            // push values into people array and convert it as NSManagedObject
            people = results as! [NSManagedObject]
        } catch let error as NSError {
            print("Could not fetch \(error), \(error.userInfo)")
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

