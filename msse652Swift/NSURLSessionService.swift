//
//  NSURLSessionService.swift
//  msse652Swift
//
//  Created by echolush on 7/4/14.
//  Copyright (c) 2014 Matt Ozer. All rights reserved.
//

import UIKit

class NSURLSessionService: NSObject, Service {
   
    let kLocationProgramURL = "http://regisscis.net/Regis2/webresources/regis2.program";
    let kLocationCourseURL = "http://regisscis.net/Regis2/webresources/regis2.course";
    
    var arrayPrograms: Array<Program> = []
    
    func downloadProgramsForTableView(tableView: UITableView) {
        var url = NSURL(string: kLocationProgramURL)
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
                    var program: Program = Program(pId: pId!, pName: pName!)
                    self.arrayPrograms.append(program)
                }
                dispatch_async(dispatch_get_main_queue(),{
                    tableView.reloadData()
                })
                self.downloadCourses(session)
            }).resume()
    }
    
    func downloadCourses(session: NSURLSession) {
        var url = NSURL(string: kLocationCourseURL)
        var request = NSMutableURLRequest(URL: url)
        
        session.dataTaskWithRequest(request,
            completionHandler: {(data: NSData!,
                response: NSURLResponse!,
                error: NSError!) in
                
                var error: NSError?
                let json = NSJSONSerialization.JSONObjectWithData(data, options: nil, error: &error) as NSArray
                
                for item in json {
                    var cId = item["id"] as? Int
                    var cName = item["name"] as? String
                    var cProgramDict: NSDictionary = item["pid"] as NSDictionary
                    var cpid = cProgramDict["id"] as? Int
                    for program in self.arrayPrograms {
                        if cpid == program.pId {
                            var course: Course = Course(cId: cId!, cName: cName!)
                            program.pCourses.append(course)
                        }
                    }
                }
                
            }).resume()
    }
    
    func retrieveAllPrograms() -> Array<Program> {
        return arrayPrograms
    }
}
