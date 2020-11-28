//
//  AddTaskCell.swift
//  Assignment4
//
//  Created by Masum Modi on 2020-11-14.
//  Copyright © 2020 Centennial College. All rights reserved.
//  Student Id: 301149321


import UIKit

class AddTaskCell: UITableViewCell {

    @IBOutlet weak var lblDueDate: UILabel!
    @IBOutlet weak var imgEdit: UIButton!
    @IBOutlet weak var swPending: UISwitch!
    @IBOutlet weak var tfTaskName: UITextField!
    
    var parentContext: TaskListController!
    var currentTask: ModelTask!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        
        //Hide keyboard
        self.tfTaskName.delegate = self
        
        self.imgEdit.isHidden = true
        self.swPending.isHidden = true
        
    }
}


//  Hide keyboard extension
extension AddTaskCell: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        self.swPending.isHidden = false
        self.imgEdit.isHidden = false
        return true
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        self.swPending.isHidden = true
        self.imgEdit.isHidden = true
        currentTask.name = textField.text ?? ""
        parentContext.addToPreference()
    }
}
