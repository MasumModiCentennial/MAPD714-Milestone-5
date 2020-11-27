//
//  ModelTask.swift
//  Assignment4
//
//  Created by Masum Modi on 2020-11-27.
//  Copyright © 2020 Centennial College. All rights reserved.
//

import Foundation
import UIKit

class ModelTask: Codable{
    var name:String = ""
    var isCompleted:Bool = false
    var notes:String = ""
    var hasDueDate:Bool = false
    var dueDate:Int64 = 0
}
