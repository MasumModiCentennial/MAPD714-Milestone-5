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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        self.tableView.dataSource = self
             
        //Apply Shadow to buttons
        setButtonShadow(self.btnAddMore)
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
extension TaskListController: UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5 // Returns number of rows
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "AddTaskCell", for: indexPath) //Find the cell and recycle it
        return cell
    }
}
