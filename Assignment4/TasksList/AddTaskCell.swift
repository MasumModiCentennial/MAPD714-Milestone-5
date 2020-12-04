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
    var currentTask: ModelTask! {
        didSet{
            if let ct = self.currentTask {
                self.swPending.isOn = !ct.isCompleted
                self.lblDueDate.isHidden = !ct.hasDueDate
                if ct.hasDueDate{
                    let df = DateFormatter()
                    df.dateFormat = "yyyy-MM-dd hh:mm:ss"
                    let strDate = df.string(from: ct.dueDate)
                    if ct.dueDate < Date() {
                        self.lblDueDate.textColor = .red
                    } else {
                        self.lblDueDate.textColor = .black
                    }
                    self.lblDueDate.text = "Due: " + strDate
                }
            }
        }
    }
    
    var currentIndex: Int = -1
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        //Hide keyboard
        self.tfTaskName.delegate = self
        self.imgEdit.isHidden = true
        self.swPending.isHidden = true
        self.imgEdit.addTarget(self, action: #selector(self.openDetailsScreen), for:UIControl.Event.touchUpInside)
    }
    
    //Open details screen with some parameters
    @objc func openDetailsScreen(){
        let story = UIStoryboard(name: "Main", bundle: nil)
        if let detailScreen = story.instantiateViewController(withIdentifier: "TaskDetailsController") as? TaskDetailsController{
            self.tfTaskName.resignFirstResponder()
            detailScreen.currentTask = self.currentTask
            let oldTask:ModelTask = ModelTask()
            oldTask.name = self.currentTask.name
            oldTask.notes = self.currentTask.notes
            oldTask.isCompleted = self.currentTask.isCompleted
            oldTask.hasDueDate = self.currentTask.hasDueDate
            oldTask.dueDate = self.currentTask.dueDate
            detailScreen.oldTask = oldTask
            detailScreen.currentIndex = currentIndex
            detailScreen.parentContext = self.parentContext
            self.parentContext.navigationController?.pushViewController(detailScreen, animated: true)
        }
    }
}


//  // extension for textfield delegates
extension AddTaskCell: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        self.swPending.isHidden = true
        self.imgEdit.isHidden = true
        return true
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        self.swPending.isHidden = true
        self.imgEdit.isHidden = true
            currentTask.name = textField.text ?? ""
            parentContext.addToPreference()
        
    }
}
