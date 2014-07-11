//
//  Service.swift
//  msse652Swift
//
//  Created by echolush on 7/4/14.
//  Copyright (c) 2014 Matt Ozer. All rights reserved.
//

import Foundation
import UIKit

protocol Service {
    
    func downloadProgramsForTableView(tableView: UITableView)
    
    func retrieveAllPrograms() -> Array<Program>


}

