//
//  CategoryViewController.swift
//  Todoo
//
//  Created by Apple on 24/03/2019.
//  Copyright © 2019 Gravico. All rights reserved.
//

import UIKit
import RealmSwift
import ChameleonFramework



class CategoryViewController: SwipetableViewController {
    
    let realm = try! Realm()
    
    var categories: Results<Category>?
    
    var colorArray = [FlatPurpleDark().lighten(byPercentage: 0.25), FlatPurple().lighten(byPercentage: 0.25)]
    
//    var colorArray = [ColorSchemeOf(ColorScheme.analogous, color: FlatGray(), isFlatScheme: true)]

    override func viewDidLoad() {
        super.viewDidLoad()
        
        loadCategories()
        
        tableView.separatorStyle = .none
        
        
    }
    
    //MARK: - TableView Datasource Methods
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return categories?.count ?? 1
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = super.tableView(tableView, cellForRowAt: indexPath)
        
        if let category = categories?[indexPath.row] {
//
            cell.textLabel?.text = category.name

//            guard let categoryColour = UIColor(hexString: category.colour) else {fatalError()}
            
            if (indexPath.row % 2 == 0) {
                cell.backgroundColor = FlatPurpleDark()
            } else {
                    cell.backgroundColor = FlatPurple()
                }
                
            
            
//            cell.backgroundColor = UIColor(hexString: category.colour)
//
            if let textLabelColour = UIColor(hexString: category.colour) {

                cell.textLabel?.textColor = ContrastColorOf(textLabelColour, returnFlat: true)
            }
        
//        cell.textLabel?.text = categories?[indexPath.row].name ?? "No categories added yet"
//
//        cell.backgroundColor = UIColor(hexString: category.colour)
//
////        cell.backgroundColor = UIColor(hexString: categories? [indexPath.row].colour ?? "7A81FF")
//// HAVE USED FORCE UNWRAPPING HERE AS COULD NOT SET OPTIONAL IF NIL NEEDS FIXING
//            cell.textLabel?.textColor = ContrastColorOf(UIColor(hexString: category.colour)!, returnFlat: true)
        
    }
        
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
        newCategory.colour = (self.colorArray.randomElement()??.hexValue())!
        
//        newCategory.colour = FlatWatermelonDark().hexValue()

        
        
        
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
