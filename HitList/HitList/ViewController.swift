//
//  ViewController.swift
//  HitList
//
//  Created by Linh Tran on 03/06/16.
//  Copyright © 2016 Linh Tran. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDataSource  {
    
    // MARK: Properties
    @IBOutlet weak var tableView: UITableView!
    var names = [String]()
    
    
    // MARK: Actions
    @IBAction func addName(sender: AnyObject) {

        let alert = UIAlertController(title: "New name", message: "Add a new name", preferredStyle: .Alert)
        
        let saveAction = UIAlertAction(title: "Save", style: .Default, handler: { (action:UIAlertAction) -> Void in
            let textField = alert.textFields!.first
            self.names.append(textField!.text!)
            self.tableView.reloadData()
        })
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .Default, handler: {(action: UIAlertAction) -> Void in
            alert.addTextFieldWithConfigurationHandler { (textField: UITextField) -> Void in
            }
        
        })
        
        alert.addAction(saveAction)
        alert.addAction(cancelAction)
        
        presentViewController(alert, animated: true, completion: nil)
    }
    
    
    // MARK: UITableViewDataSource 
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return names.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("Cell")
        cell!.textLabel?.text = names[indexPath.row]
        return cell!
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "\"The List\""
        tableView.registerClass(UITableViewCell.self, forCellReuseIdentifier: "Cel")
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

