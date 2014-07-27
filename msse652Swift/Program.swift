//
//  Program.swift
//  msse652Swift
//
//  Created by echolush on 7/10/14.
//  Copyright (c) 2014 Matt Ozer. All rights reserved.
//

import UIKit

class Program: NSObject {
   
    var pId: Int = 0
    var pName: String = ""
    var pCourses: Array<Course> = []
    
    init(pId:Int, pName:String) {
        self.pId = pId
        self.pName = pName
    }
    
    override var description: String {
    return "Program ID: \(self.pId) withName: \(self.pName) courses: \(self.pCourses)"
    }
}
