//
//  Course.swift
//  msse652Swift
//
//  Created by echolush on 7/27/14.
//  Copyright (c) 2014 Matt Ozer. All rights reserved.
//

import UIKit

class Course: NSObject {
   
    var cId: Int = 0
    var cName: String = ""
    
    init(cId:Int, cName:String) {
        self.cId = cId
        self.cName = cName
    }
    
    override var description: String {
    return "Course ID: \(self.cId) withName: \(self.cName)"
    }
    
}
