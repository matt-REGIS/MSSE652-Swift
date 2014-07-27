//
//  SCISProgramsTableViewController.swift
//  msse652Swift
//
//  Created by echolush on 7/2/14.
//  Copyright (c) 2014 Matt Ozer. All rights reserved.
//

import UIKit

class SCISProgramsTableViewController: UITableViewController {

    @IBOutlet weak var rightBarButtonItem: UIBarButtonItem!

    var service = NSURLSessionService()
    /*
    init(style: UITableViewStyle) {
        super.init(style: style)
        // Custom initialization
    }
    */
    override func viewDidLoad() {
        super.viewDidLoad()
        service.downloadProgramsForTableView(self.tableView)
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // #pragma mark - Table view data source
    override func numberOfSectionsInTableView(tableView: UITableView?) -> Int {
        return 1
    }

    override func tableView(tableView: UITableView?, numberOfRowsInSection section: Int) -> Int {
        return service.arrayPrograms.count
    }
    
    override func tableView(tableView: UITableView!, cellForRowAtIndexPath indexPath: NSIndexPath!) -> UITableViewCell! {
        let CELLIDENTIFIER = "CELLIDENTIFIER"
        var cell = tableView.dequeueReusableCellWithIdentifier(CELLIDENTIFIER, forIndexPath: indexPath) as? UITableViewCell
        if !cell {
            cell = UITableViewCell(style: UITableViewCellStyle.Value1, reuseIdentifier: "CELL")
        }
        // Configure the cell...
        var program : Program = service.arrayPrograms[indexPath.row]
        cell!.textLabel.text = program.pName
        return cell
    }
    
    @IBAction func actionShare(sender: UIBarButtonItem) {
        //Init an activity indicator to show that a task is in progress
        var activityView: UIActivityIndicatorView = UIActivityIndicatorView(activityIndicatorStyle:UIActivityIndicatorViewStyle.Gray)
        //Init a bar button item with activity indicator as its view
        var rightBarButtonItemActivity: UIBarButtonItem = UIBarButtonItem(customView:activityView)
        //Set the nav bar's right bar button item to activity view
        self.navigationItem.rightBarButtonItem = rightBarButtonItemActivity;
        //Start animation
        activityView.startAnimating()
        
        //Create a queue for animation
        var queue: dispatch_queue_t = dispatch_queue_create("openActivityIndicatorQueue", nil)
        
        //Run asynchronously
        dispatch_async(queue, {
            //Set custom message with numbered program names
            var head: String = "SCIS Programs\n"
            var programList: String = ""
            var count: Int = 1
            for program in self.service.arrayPrograms {
                var number: String = NSString(format: "%lu. ", count)
                programList = "\(programList) \(number) \(program.pName) \n"
                //programList = [[[programList stringByAppendingString:number] stringByAppendingString:program.name] stringByAppendingString:@"\n"];
                count++;
            }
            head = "\(head) \(programList)"
            //head = [head stringByAppendingString:programList];
            var textToShare: String = "\(head)\nRetrieved from\n"
            //NSString *textToShare = [head stringByAppendingString:@"\nRetrieved from\n"];
            
            //Create the image to share
            var imageToShare: UIImage = UIImage(named: "REGIS")
            //Create the url to share
            var url: NSURL = NSURL.URLWithString("http://regisscis.net/Regis2/webresources/regis2.program")
            //Create array that holds the text, url and image to share
            var activityItems: Array  = []
            
            //Init activity service to feed the text, url and image to share
            var activity: UIActivity = UIActivity()
            //Create array of activity to feed into UIActivityViewController
            var applicationActivities: Array = [activity]
            //Init the UIActivityViewController with array of activities
            var activityVC:UIActivityViewController = UIActivityViewController(activityItems: activityItems, applicationActivities: applicationActivities)
            //Specify the types of services that should be excluded
            activityVC.excludedActivityTypes = [UIActivityTypeAddToReadingList, UIActivityTypeCopyToPasteboard, UIActivityTypeSaveToCameraRoll, UIActivityTypeAssignToContact, UIActivityTypePrint, UIActivityTypeAirDrop];
            //Call the main queue to perform UI operations
            dispatch_async(dispatch_get_main_queue(), {
                //Stop animation
                activityView.stopAnimating()
                //Present activity window
                self.presentViewController(activityVC, animated: true, completion: nil)
                //Set back the right bar button item to its original state
                self.navigationItem.rightBarButtonItem = self.rightBarButtonItem;
            })
        })
    }

    /*
    // Override to support conditional editing of the table view.
    override func tableView(tableView: UITableView?, canEditRowAtIndexPath indexPath: NSIndexPath?) -> Bool {
        // Return NO if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(tableView: UITableView?, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath?) {
        if editingStyle == .Delete {
            // Delete the row from the data source
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        } else if editingStyle == .Insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(tableView: UITableView?, moveRowAtIndexPath fromIndexPath: NSIndexPath?, toIndexPath: NSIndexPath?) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(tableView: UITableView?, canMoveRowAtIndexPath indexPath: NSIndexPath?) -> Bool {
        // Return NO if you do not want the item to be re-orderable.
        return true
    }
    */

    override func prepareForSegue(segue: UIStoryboardSegue!, sender: AnyObject?) {
        
        if segue.identifier == "fromProgramsToCourses"  {
            var cvc: SCISCoursesTableViewController = segue!.destinationViewController as SCISCoursesTableViewController
            var cell: UITableViewCell = sender as UITableViewCell
            var indexPath: NSIndexPath = self.tableView.indexPathForCell(cell)
            var program: Program = self.service.arrayPrograms[indexPath.row]
            cvc.program = program
        }
        
        // Get the new view controller using [segue destinationViewController].
        // Pass the selected object to the new view controller.
    }

}
