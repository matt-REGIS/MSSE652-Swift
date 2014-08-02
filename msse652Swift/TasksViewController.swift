//
//  TasksViewController.swift
//  msse652Swift
//
//  Created by echolush on 7/2/14.
//  Copyright (c) 2014 Matt Ozer. All rights reserved.
//

import UIKit

class TasksViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    var arrayNotes: NSMutableArray = []
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        var store: NSUbiquitousKeyValueStore = NSUbiquitousKeyValueStore.defaultStore()
        NSNotificationCenter.defaultCenter().addObserver(self, selector: Selector("storeDidChange:"), name: NSUbiquitousKeyValueStoreDidChangeExternallyNotification, object: store)
        store.synchronize()
        NSNotificationCenter.defaultCenter().addObserver(self, selector: Selector("didAddNewNote:"), name: "New Note", object: nil)
        self.arrayNotes = NSMutableArray(array: store.arrayForKey("Tasks"))
        
        self.tableView.reloadData()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func didAddNewNote(notification: NSNotification) {
        var userInfo: NSDictionary = notification.userInfo
        var taskStr: String = userInfo.valueForKey("Tasks") as String
        self.arrayNotes.addObject(taskStr)
        var store: NSUbiquitousKeyValueStore = NSUbiquitousKeyValueStore.defaultStore()
        if store != nil {
            store.setObject(self.arrayNotes, forKey: "Tasks")
        }
        store.synchronize()
        self.tableView.reloadData()
    }
    
    func storeDidChange(notification: NSNotification) {
        var userInfo: NSDictionary = notification.userInfo
        var reason: NSNumber = userInfo.objectForKey(NSUbiquitousKeyValueStoreChangeReasonKey) as NSNumber
        
        if reason != nil {
            var reasonValue: NSInteger = reason.integerValue
            if reasonValue == NSUbiquitousKeyValueStoreServerChange || reasonValue == NSUbiquitousKeyValueStoreInitialSyncChange {
                var store: NSUbiquitousKeyValueStore = NSUbiquitousKeyValueStore.defaultStore()
                if store != nil {
                    self.arrayNotes = NSMutableArray(array: store.arrayForKey("Tasks"))
                    self.tableView.reloadData()
                }
            }
        }
    }
    
    // #pragma mark - Table view data source
    func numberOfSectionsInTableView(tableView: UITableView?) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView?, numberOfRowsInSection section: Int) -> Int {
        return arrayNotes.count
    }
    
    func tableView(tableView: UITableView!, cellForRowAtIndexPath indexPath: NSIndexPath!) -> UITableViewCell! {
        let CELLIDENTIFIER = "CELLIDENTIFIER"
        var cell = tableView.dequeueReusableCellWithIdentifier(CELLIDENTIFIER, forIndexPath: indexPath) as? UITableViewCell
        if !cell {
            cell = UITableViewCell(style: UITableViewCellStyle.Value1, reuseIdentifier: "CELL")
        }
        // Configure the cell...
        cell!.textLabel.text = self.arrayNotes.objectAtIndex(indexPath.row) as String
        return cell
    }
    
    func tableView(tableView: UITableView!, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath!) {
        if editingStyle == UITableViewCellEditingStyle.Delete {
            self.arrayNotes.removeObjectAtIndex(indexPath.row)
            self.tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: UITableViewRowAnimation.Fade)
            NSUbiquitousKeyValueStore.defaultStore().setArray(self.arrayNotes, forKey: "Tasks")
        }
    }
    

    /*
    // #pragma mark - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue?, sender: AnyObject?) {
        // Get the new view controller using [segue destinationViewController].
        // Pass the selected object to the new view controller.
    }
    */

}
