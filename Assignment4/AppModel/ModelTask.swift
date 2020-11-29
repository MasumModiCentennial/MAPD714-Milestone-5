//
//  ModelTask.swift
//  Assignment4
//
//  Created by Masum Modi on 2020-11-27.
//  Copyright © 2020 Centennial College. All rights reserved.
//

import Foundation
import UIKit

class ModelTask: Codable, Equatable {
    var name:String = ""
    var isCompleted:Bool = false
    var notes:String = ""
    var hasDueDate:Bool = false
    var dueDate:Date = Date()
    static func == (lhs: ModelTask, rhs: ModelTask) -> Bool {
        return lhs.name.lowercased() == rhs.name.lowercased() && lhs.isCompleted == rhs.isCompleted && lhs.notes.lowercased() == rhs.notes.lowercased() && lhs.hasDueDate == rhs.hasDueDate && lhs.dueDate == rhs.dueDate
    }
}
