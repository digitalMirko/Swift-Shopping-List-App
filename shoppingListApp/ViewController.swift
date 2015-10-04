//
//  ViewController.swift
//  shoppingListApp
//
//  Created by Mirko Cukich on 9/26/15.
//  Copyright © 2015 Digital Mirko. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    // empty array of Strings for holding typed in content
    // allows us to reference even though there isn't anything there
    var items = [String]()
    
    // text field connection
    @IBOutlet weak var textField: UITextField!
    
    // Table View Prototype Content
    @IBOutlet weak var tableView: UITableView!
    
    // button connection
    @IBAction func addButton(sender: UIButton) {
        
        // when ever someone types in the textField we will hold it in this variable
        let newItem = textField.text
        
        // append text typed in to the array
        items.append(newItem!)
        
        // when user clicks into text field keyboard pops up
        // this will send it back and close the keyboard
        textField.resignFirstResponder()
        
        // creates an empty field to put in another item
        textField.text = ""
        
        // reloads table view with our data with the new information
        tableView.reloadData()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // number of rows in a section
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        // returns the items array count
        return items.count
    }
    
    // cell for row, what goes into these rows, return UITableView cell
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
    
        // constant = tableview
        let cell = tableView.dequeueReusableCellWithIdentifier("Cell", forIndexPath: indexPath)
        
        //
        cell.textLabel?.text = items[indexPath.row]
        
        // changing the color to red
        cell.textLabel?.textColor = UIColor.redColor()
        
        return cell
    }
    
    func tableView(tableView: UITableView, didDeselectRowAtIndexPath indexPath: NSIndexPath) {
        
        // create constant
        let selectedRow:UITableViewCell = tableView.cellForRowAtIndexPath(indexPath)!
        
        // if our cell doesn't have a check mark, we want to give it a green one
        // if we have it already marked we can also de-select it too
        if selectedRow.accessoryType == UITableViewCellAccessoryType.None {
            
            // change accessory to a check mark since it doesn't have one
            selectedRow.accessoryType = UITableViewCellAccessoryType.Checkmark
            
            // turn the check mark color to green
            selectedRow.tintColor = UIColor.greenColor()
            
        } else {
            // if it has a green check mark, remove it
            selectedRow.accessoryType = UITableViewCellAccessoryType.None
            
        } // end of if else statement
        
    } // end of didSelect function
    
    // delete row option, when we have row and swipe to the left
    func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        
        // create a variable
        let deletedRow:UITableViewCell = tableView.cellForRowAtIndexPath(indexPath)!
        
        if editingStyle == UITableViewCellEditingStyle.Delete {
            
            // accessing array removing from the array
            items.removeAtIndex(indexPath.row)
            
            // now physically removing the entire row
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: UITableViewRowAnimation.Automatic)
            
            // we have deleted the row but its a DQ reuseable row so when it comes
            // back up we want to make sure it does not come up with a check mark on it
            deletedRow.accessoryType = UITableViewCellAccessoryType.None
        }
    }

} // end

