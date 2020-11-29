//
//  TaskDetailsController.swift
//  Assignment4
//
//  Created by Masum Modi on 2020-11-14.
//  Copyright © 2020 Centennial College. All rights reserved.
//  Student Id: 301149321

import UIKit

class TaskDetailsController: UIViewController {
    
    
    @IBOutlet weak var datePicker: UIDatePicker!
    @IBOutlet weak var tfTaskName: UITextField!
    @IBOutlet weak var swDueDate: UISwitch!
    @IBOutlet weak var tfTaskDescription: UITextField!
    @IBOutlet weak var swCompleted: UISwitch!
    @IBOutlet weak var btnDelete: UIButton!
    @IBOutlet weak var btnCancel: UIButton!
    @IBOutlet weak var btnSave: UIButton!
    
    var currentIndex: Int = 0
    var currentTask: ModelTask!
    var oldTask: ModelTask!
    var parentContext: TaskListController!
    var ifAnyChanges:Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        setupUI()
    }
    
    func setupUI() {
        self.tfTaskName.text = currentTask.name
        self.tfTaskDescription.text = currentTask.notes
        self.swDueDate.isOn = currentTask.hasDueDate
        self.swCompleted.isOn = !currentTask.isCompleted
        self.datePicker.isHidden = !currentTask.hasDueDate
        if currentTask.hasDueDate {
            self.datePicker.date = currentTask.dueDate
        }
        //Apply Shadow to buttons
        setButtonShadow(self.btnSave)
        setButtonShadow(self.btnCancel)
        setButtonShadow(self.btnDelete)
        self.tfTaskName.delegate = self
        self.tfTaskDescription.delegate = self
    }
    
    // on due date switch changed
    @IBAction func onHasDueDateChanged(_ sender: UISwitch) {
        self.currentTask.hasDueDate = sender.isOn
        self.datePicker.isHidden = !sender.isOn
    }
    
    // on due date changed
    @IBAction func onDueDateChanged(_ sender: UIDatePicker) {
        self.currentTask.dueDate = sender.date
    }
    
    // on isCompleted status changed
    @IBAction func onStatusChanged(_ sender: UISwitch) {
        self.currentTask.isCompleted = !sender.isOn
    }
    
    // Set Shadow Size, Color and Radius
    func setButtonShadow(_ button: UIButton) {
        button.layer.shadowColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.5).cgColor
        button.layer.shadowOffset = CGSize(width: 0.0, height: 3.0)
        button.layer.shadowOpacity = 1.0
        button.layer.shadowRadius = 0.0
    }
    
    // Open alert dialog on remove button clicked
    @IBAction func onRemoveTaskClicked(_ sender: UIButton) {
        let alert = UIAlertController(title: nil, message: "Are sure you want to delete this task?", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Yes", style: .destructive, handler: {
            alert in
            self.parentContext.arrTaskList.remove(at: self.currentIndex)
            self.parentContext.addToPreference()
            self.navigationController?.popViewController(animated: true)
        }))
        alert.addAction(UIAlertAction(title: "No", style: .cancel, handler: {
            alert in
            self.navigationController?.popViewController(animated: true)
        }))
        self.present(alert, animated: true)
    }
    
    // Open alert dialog on cancel button clicked
    @IBAction func onCancelTaskClicked(_ sender: UIButton) {
        self.view.endEditing(true)
        if !(self.currentTask == self.oldTask) {
            let alert = UIAlertController(title: nil, message: "Are sure you want to discard the changes?", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Yes", style: .default, handler: {
                alert in
                self.navigationController?.popViewController(animated: true)
            }))
            alert.addAction(UIAlertAction(title: "No", style: .cancel, handler: {
                alert in
            }))
            self.present(alert, animated: true)
        }else{
            self.navigationController?.popViewController(animated: true)
        }
    }
    
    // Open alert dialog on save button clicked
    @IBAction func onSaveTaskClicked(_ sender: UIButton) {
        let alert = UIAlertController(title: nil, message: "Are sure you want to update this task?", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Yes", style: .default, handler: {
            alert in
            self.view.endEditing(true)
            self.parentContext.addToPreference()
            self.navigationController?.popViewController(animated: true)
        }))
        alert.addAction(UIAlertAction(title: "No", style: .cancel, handler: {
            alert in
            self.navigationController?.popViewController(animated: true)
        }))
        self.present(alert, animated: true)
    }
    
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destination.
     // Pass the selected object to the new view controller.
     }
     */
    
}

// extension for textfield delegates
extension TaskDetailsController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        if textField === self.tfTaskName {
            currentTask.name = textField.text ?? ""
        }else if textField === self.tfTaskDescription {
            currentTask.notes = textField.text ?? ""
        }
    }
}
