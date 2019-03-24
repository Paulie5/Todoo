//
//  CategoryViewController.swift
//  Todoo
//
//  Created by Apple on 24/03/2019.
//  Copyright © 2019 Gravico. All rights reserved.
//

import UIKit
import CoreData


class CategoryViewController: UITableViewController {
    
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    var categories = [Category]()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        loadCategories()
        
    }
    
    //MARK: - TableView Datasource Methods
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return categories.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "CategoryCell", for: indexPath)
        
        
        cell.textLabel?.text = categories[indexPath.row].name
        
        
        return cell
        
    }
    
    //MARK: - TableWiew Delegate Methods
    
   override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "goToItems", sender: self)
        
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destinationVC = segue.destination as! TodoListViewController
        
        if let indexPath = tableView.indexPathForSelectedRow {
            destinationVC.selectedCategory = categories[indexPath.row]
        }
    }
    
    
    
    //MARK: - Data Manipulation Methods
    
    
    func saveCategories() {
        
        do {
            try context.save()
        } catch {
            print("error saving context \(error)")
            
        }
        
        self.tableView.reloadData()
    }
    
    func loadCategories(with request : NSFetchRequest<Category> = Category.fetchRequest()) {
        
        do {
            categories = try  context.fetch(request)
        } catch {
            print("error fetching data from context \(error)")
        }
        
        tableView.reloadData()
        
    }
    
    
    
    
    //MARK: - Add New Categories
    
    @IBAction func AddButtonPressed(_ sender: UIBarButtonItem) {

    
    var textField = UITextField()
    
    let alert = UIAlertController(title: "Add New Category", message: "", preferredStyle: .alert)
    
    let action = UIAlertAction(title: "Add", style: .default) { (action) in
        //What will happen once the user clicks the Add Item button on our UIAlert
        
        let newCategory = Category(context: self.context)
        newCategory.name = textField.text!
//        newItem.done = false
        
        self.categories.append(newCategory)
        
        self.saveCategories()
        
    }
    alert.addAction(action)
    alert.addTextField { (field) in
        textField = field
        textField.placeholder = "Create new category"
    
    }
    
    present(alert, animated: true, completion: nil)
    
}
    
    

  
    
    
  
}
