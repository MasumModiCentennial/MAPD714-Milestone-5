//
//  ViewController.swift
//  Assignment4
//
//  Created by Masum Modi on 2020-11-14.
//  Copyright © 2020 Centennial College. All rights reserved.
//  Student Id: 301149321


import UIKit

class TaskListController: UIViewController {
    
    @IBOutlet weak var btnAddMore: UIButton!
    @IBOutlet weak var tableView: UITableView!
    
    
    var arrTaskList: Array<ModelTask> = Array<ModelTask>()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        self.tableView.dataSource = self
        self.tableView.delegate = self
        self.tableView.allowsMultipleSelectionDuringEditing = false;
        //Apply Shadow to buttons
        setButtonShadow(self.btnAddMore)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setupUI()
    }
    
    func setupUI() {
        if let taskList = getValueFromPreference(forKey: "taskList") as? Data{
            let arrTaskList = try! JSONDecoder().decode([ModelTask].self, from: taskList)
            self.arrTaskList.removeAll()
            self.arrTaskList.append(contentsOf: arrTaskList)
            self.tableView.reloadData()
        }
    }
    
    //save list to offline
    func addToPreference() {
        let taskList = try! JSONEncoder().encode(self.arrTaskList)
        setValueInPreference(forKey: "taskList", value: taskList)
    }
    
    @IBAction func onAddTaskClicked(_ sender: UIButton) {
        let newTask = ModelTask()
        self.arrTaskList.append(newTask)
        self.tableView.reloadData()
        addToPreference()
    }
}


// Set Shadow Size, Color and Radius
func setButtonShadow(_ button: UIButton) {
    button.layer.shadowColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.5).cgColor
    button.layer.shadowOffset = CGSize(width: 0.0, height: 3.0)
    button.layer.shadowOpacity = 1.0
    button.layer.shadowRadius = 0.0
}


// Table view data source controller
extension TaskListController: UITableViewDataSource, UITableViewDelegate{
    

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.arrTaskList.count // Returns number of rows
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "AddTaskCell", for: indexPath) as! AddTaskCell //Find the cell and recycle it
        let currentTask = self.arrTaskList[indexPath.row]
        cell.currentTask = currentTask
        cell.parentContext = self
        cell.currentIndex = indexPath.row
        cell.tfTaskName.text = currentTask.name
        return cell
    }
    
    //Swipe left open details screen
   func tableView(_ tableView: UITableView,
                   leadingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration?
    {
        let editAction = UIContextualAction(style: .normal, title:  "Edit", handler: { (ac:UIContextualAction, view:UIView, success:(Bool) -> Void) in
            if let cell = tableView.cellForRow(at: indexPath) as? AddTaskCell{
                cell.openDetailsScreen()
            }
                success(true)
            })
   editAction.backgroundColor = .blue

            return UISwipeActionsConfiguration(actions: [editAction])
    }

    //Swipe right delete on long swipe and toggle button
    func tableView(_ tableView: UITableView,
                   trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration?
    {
        let deleteAction = UIContextualAction(style: .normal, title:  "Delete", handler: { (ac:UIContextualAction, view:UIView, success:(Bool) -> Void) in
            self.arrTaskList.remove(at: indexPath.row)
            self.addToPreference()
            tableView.reloadData()
            success(true)
        })
        deleteAction.backgroundColor = .red
        
        let toggleAction = UIContextualAction(style: .normal, title:  "Toggle", handler: { (ac:UIContextualAction, view:UIView, success:(Bool) -> Void) in
            if let cell = tableView.cellForRow(at: indexPath) as? AddTaskCell{
                cell.currentTask.isCompleted = !cell.currentTask.isCompleted
                self.addToPreference()
                tableView.reloadData()
                success(true)
            }
            success(false)
        })
        toggleAction.backgroundColor = .green

        return UISwipeActionsConfiguration(actions: [deleteAction,toggleAction])
    }
    
    
}
