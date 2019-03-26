//
//  CategoryViewController.swift
//  Todoo
//
//  Created by Apple on 24/03/2019.
//  Copyright © 2019 Gravico. All rights reserved.
//

import UIKit
import RealmSwift



class CategoryViewController: SwipetableViewController {
    
    let realm = try! Realm()
    
    var categories: Results<Category>?
    
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        loadCategories()
        
        
        
    }
    
    //MARK: - TableView Datasource Methods
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return categories?.count ?? 1
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = super.tableView(tableView, cellForRowAt: indexPath)
        
        cell.textLabel?.text = categories?[indexPath.row].name ?? "No categories added yet"
        
        return cell
        
        
    }
    
    //MARK: - TableWiew Delegate Methods
    
   override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "goToItems", sender: self)
        
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destinationVC = segue.destination as! TodoListViewController
        
        if let indexPath = tableView.indexPathForSelectedRow {
            destinationVC.selectedCategory = categories?[indexPath.row]
        }
    }
    
    
    
    //MARK: - Data Manipulation Methods
    
    
    
    func save(category: Category) {
        
        do {
            try realm.write {
                realm.add(category)
            }
        } catch {
            print("error saving context \(error)")
            
        }
        
        self.tableView.reloadData()
    }
    
    func loadCategories() {
        
        categories = realm.objects(Category.self)


        tableView.reloadData()

    }
    
    //MARK: - Delete Data From Swipe
    
    override func updateModel(at indexPath: IndexPath) {
        if let categoryForDeletion = self.categories?[indexPath.row] {
            do {
                try self.realm.write {
                    self.realm.delete(categoryForDeletion)
                }
            } catch {
                print("error deleting category, \(error)")
            }
        }
        
    }
    
    
    
    
    
    
    //MARK: - Add New Categories
    
    @IBAction func AddButtonPressed(_ sender: UIBarButtonItem) {

    
    var textField = UITextField()
    
    let alert = UIAlertController(title: "Add New Category", message: "", preferredStyle: .alert)
    
    let action = UIAlertAction(title: "Add", style: .default) { (action) in
        //What will happen once the user clicks the Add Item button on our UIAlert
        
        let newCategory = Category()
        newCategory.name = textField.text!
//        newItem.done = false
        
        
        
        self.save(category: newCategory)
        
    }
    alert.addAction(action)
    alert.addTextField { (field) in
        textField = field
        textField.placeholder = "Create new category"
    
    }
    
    present(alert, animated: true, completion: nil)
    
    }
  
}
