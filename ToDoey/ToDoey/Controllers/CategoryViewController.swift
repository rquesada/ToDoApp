//
//  CategoryTableViewController.swift
//  ToDoey
//
//  Created by Roy Quesada on 9/6/23.
//

import UIKit
import CoreData

class CategoryViewController: UITableViewController {

    var categories = [CategoryEntity]()
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadCategories()
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destinationVC = segue.destination as! ToDoListViewController
        if let indexPath = tableView.indexPathForSelectedRow {
            destinationVC.selectedCategory = self.categories[indexPath.row]
        }
    }
    //MARK: - Tableview Datasource Methods
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return categories.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CategoryCell", for: indexPath)
        
        let category = categories[indexPath.row]
        cell.textLabel?.text = category.name
        
        return cell
    }
    
    //MARK: - Data Manipulation Methods
    func saveCategories(){
        do{
            try context.save()
        } catch {
            print("Error saving category \(error)")
        }
        tableView.reloadData()
    }
    
    func loadCategories(){
        let request : NSFetchRequest<CategoryEntity> =  CategoryEntity.fetchRequest()
        do{
            categories = try context.fetch(request)
        }catch{
            print("Error loading categories \(error)")
        }
        tableView.reloadData()
    }
    //MARK: - Add New Categories
    
    @IBAction func addButtonPressed(_ sender: Any) {
        var textField = UITextField()
        let alert = UIAlertController(title: "Add New Category", message: "", preferredStyle: .alert)
        let action = UIAlertAction(title: "Add", style: .default){ action in
            let newCategory = CategoryEntity(context: self.context)
            newCategory.name = textField.text
            self.categories.append(newCategory)
            self.saveCategories()
        }
        alert.addAction(action)
        alert.addTextField{ field in
            textField = field
            textField.placeholder = "Add a new category"
        }
        
        present(alert, animated: true, completion: nil)
    }
    
    //MARK: - Tableview Delegate Methods
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "goToItems", sender: self)
    }
}
