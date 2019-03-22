//
//  ViewController.swift
//  Todoo
//
//  Created by Apple on 22/03/2019.
//  Copyright © 2019 Gravico. All rights reserved.
//

import UIKit

class TodoListViewController: UITableViewController {
    
    var itemArray = ["buy electric bike", "work out", "complete project"]

    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    //MARK: - Tableview Datasource Methods
    
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
       let numberOfRows = itemArray.count
        return numberOfRows
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        let cell = tableView.dequeueReusableCell(withIdentifier: "ToDoItemCell", for: indexPath)
        
        cell.textLabel?.text = itemArray[indexPath.row]
        
        return cell
    }
    
    //MARK; - TableView Delegate Methods
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        print(itemArray[indexPath.row])
        
        if tableView.cellForRow(at: indexPath)?.accessoryType == .checkmark {
            tableView.cellForRow(at: indexPath)?.accessoryType = .none
        } else { tableView.cellForRow(at: indexPath)?.accessoryType = .checkmark
            
        }
        
        
        tableView.deselectRow(at: indexPath, animated: true)
    }

   
    //MARK: - Add New Items
    
    @IBAction func AddButtonPressed(_ sender: UIBarButtonItem) {
        
        var textField = UITextField()
        
        let alert = UIAlertController(title: "Add New Todoo Item", message: "", preferredStyle: .alert)
        
        let action = UIAlertAction(title: "Add Item", style: .default) { (action) in
            //What will happen once the user clicks the Add Item button on our UIAlert
            self.itemArray.append(textField.text!)
            
            self.tableView.reloadData()
            
        }
    
        
            alert.addTextField { (alertTextField) in
            alertTextField.placeholder = "Create new item"
            textField = alertTextField
//          print(alertTextField.text)
        }
        
        alert.addAction(action)
        
        present(alert, animated: true, completion: nil)
        
    }
    


}


