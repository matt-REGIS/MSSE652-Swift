//
//  AddTasksViewController.swift
//  msse652Swift
//
//  Created by echolush on 8/2/14.
//  Copyright (c) 2014 Matt Ozer. All rights reserved.
//

import UIKit

class AddTasksViewController: UIViewController {

    @IBOutlet weak var outletTextView: UITextView!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func actionSave(sender: UIBarButtonItem) {
        NSNotificationCenter.defaultCenter().postNotificationName("New Note", object: self, userInfo:["Tasks": self.outletTextView.text])
        self.dismissViewControllerAnimated(true, completion: nil)
        
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue!, sender: AnyObject!) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
