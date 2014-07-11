//
//  Program.swift
//  msse652Swift
//
//  Created by echolush on 7/10/14.
//  Copyright (c) 2014 Matt Ozer. All rights reserved.
//

import UIKit

class Program: NSObject {
   
    var pId: String?
    var pName: String?
    
    init(pId:String, pName:String) {
        self.pId = pId
        self.pName = pName
    }
    
    override var description: String {
    return "Program ID: \(self.pId) withName: \(self.pName)"
    }
}
