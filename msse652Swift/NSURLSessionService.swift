//
//  NSURLSessionService.swift
//  msse652Swift
//
//  Created by echolush on 7/4/14.
//  Copyright (c) 2014 Matt Ozer. All rights reserved.
//

import UIKit

class NSURLSessionService: NSObject, Service {
   
    let kLocationURL = "http://regisscis.net/Regis2/webresources/regis2.program";
    var arrayPrograms: Array<Program> = []
    
    func downloadProgramsForTableView(tableView: UITableView) {
        var url = NSURL(string: kLocationURL)
        var request = NSMutableURLRequest(URL: url)
        
        var sessionConfig: NSURLSessionConfiguration = NSURLSessionConfiguration.defaultSessionConfiguration()
        sessionConfig.allowsCellularAccess = true
        sessionConfig.HTTPAdditionalHeaders = ["Accept": "application/json"]
        sessionConfig.timeoutIntervalForRequest = 30.0
        sessionConfig.timeoutIntervalForResource = 60.0
        sessionConfig.HTTPMaximumConnectionsPerHost = 1
        
        var session = NSURLSession(configuration: sessionConfig)
        request.HTTPMethod = "GET"
        session.dataTaskWithRequest(request,
            completionHandler: {(data: NSData!,
                response: NSURLResponse!,
                error: NSError!) in
                
                var error: NSError?
                let json = NSJSONSerialization.JSONObjectWithData(data,     options: nil, error: &error) as NSArray

                for item in json {
                    var pId = item["id"] as? Int
                    var pName = item["name"] as? String
                    var program: Program = Program(pId: String(pId!), pName: pName!)
                    self.arrayPrograms.append(program)
                }
                dispatch_async(dispatch_get_main_queue(),{
                    tableView.reloadData()
                })
            }).resume()
    }
    
    func retrieveAllPrograms() -> Array<Program> {
        return arrayPrograms
    }
}
