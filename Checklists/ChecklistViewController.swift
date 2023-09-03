//
//  ViewController.swift
//  Checklists
//
//  Created by Grey on 8/22/23.
//



import UIKit

//***DEBUG: ItemDetailViewControllerDelegate or AddItemViewControllerDelegate
// if we are renaming why is something still calling AddItemViewControllerDelegate


//Note: added this delegate to the class
class ChecklistViewController: UITableViewController,                 ItemDetailViewControllerDelegate {
    
    /*
     
     Removing to make way for Pass the Array. The array is still set to use its internal array.
     
     var items = [ChecklistItem]()
     //NOTE: the syntax for array creation in swift.
     
     
     // The book says this is an instance variable. It is quite unusual to me does the exclamation mean not. Also note, Checklist! is capitalized: is this calling a class?
     
     
     
     */
    
    
    var checklist: Checklist!
    
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        /*
         //Moving to AllListsViewController
         navigationController?.navigationBar.prefersLargeTitles = true
         
         */
        
        //Not loading from file directly from here anymore.
        //loadChecklistItems()
        
        /*
         As predicted these were just place holders, Now the function loadChecklistItems() will retrieve user saved inputs.
         
         
         //These are most likely temp place holders
         let item1 = ChecklistItem()
         item1.text = "Walk the dog"
         items.append(item1)
         let item2 = ChecklistItem()
         item2.text = "Brush my teeth"
         item2.checked = true
         items.append(item2)
         let item3 = ChecklistItem()
         item3.text = "Learn iOS development"
         item3.checked = true
         items.append(item3)
         let item4 = ChecklistItem()
         item4.text = "Soccer practice"
         items.append(item4)
         let item5 = ChecklistItem()
         item5.text = "Eat Pizza"
         items.append(item5)
         
         
        
        
        
        //Keep this here incase you need to find the directory again.
        print("Documents folder is \(documentsDirectory())")
        print("Data file path is \(dataFilePath())")
        //Looking good showing paths in console.
        */
        
        // Disable large titles for this view controller
        navigationItem.largeTitleDisplayMode = .never
        
        //This pipes in text from the name field into our title variable to set the checklist's name.
        title = checklist.name
        
    }
    
    
    // MARK: - Table View Data Source
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return checklist.items.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) ->
    UITableViewCell {
        let cell = tableView.dequeueReusableCell(
            withIdentifier: "ChecklistItem",
            for: indexPath)
        
        let item = checklist.items[indexPath.row]
        configureText(for: cell, with: item)
        configureCheckmark(for: cell, with: item)
        return cell
    }
    
    
    //MARK: - Table View Delegate
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let cell = tableView.cellForRow(at: indexPath) {
            
            
            let item = checklist.items[indexPath.row]
            item.checked.toggle()
            configureCheckmark(for: cell, with: item)
        }
        tableView.deselectRow(at: indexPath, animated: true)
        
        
        /*
         Removing we are not longer calling/saving to file from here.
         
         //Note: the call to this new function to handle saving to file. Here within the check or not check function.
         saveChecklistItems()
         
         */
        
    }
    
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        checklist.items.remove(at: indexPath.row)
        
        let indexPaths = [indexPath]
        tableView.deleteRows(at: indexPaths, with: .automatic)
        
        /*
         Not using this save function locally anymore.
         
         //Note: the call to this new function to handle saving to file. Here within our swipe to delete.
         saveChecklistItems()
         */
    }
    
    
    
    
    
    
    
    
    
    // MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "AddItem" {
            let controller = segue.destination as! ItemDetailViewController
            controller.delegate = self
        } else if segue.identifier == "EditItem" {
            let controller = segue.destination as! ItemDetailViewController
            controller.delegate = self
            
            if let indexPath = tableView.indexPath(for: sender as! UITableViewCell) {
                controller.itemToEdit = checklist.items[indexPath.row]
            }
        }
    }
    
    
    
    
    
    
    
    
    
    // MARK: - Add Item ViewController Delegates
    func itemDetailViewControllerDidCancel(_ controller: ItemDetailViewController) {
        navigationController?.popViewController(animated: true)
    }
    
    func itemDetailViewController(_ controller: ItemDetailViewController, didFinishAdding item: ChecklistItem) {
        let newRowIndex = checklist.items.count
        checklist.items.append(item)
        
        let indexPath = IndexPath(row: newRowIndex, section: 0)
        let indexPaths = [indexPath]
        tableView.insertRows(at: indexPaths, with: .automatic)
        
        navigationController?.popViewController(animated: true)
        /*
         Not using this locally anymore.
         
         //Note: the call to this new function to handle saving to file.
         saveChecklistItems()
         */
    }
    
    func itemDetailViewController(
        _ controller: ItemDetailViewController,
        didFinishEditing item: ChecklistItem
    ) {
        if let index = checklist.items.firstIndex(of: item) {
            let indexPath = IndexPath(row: index, section: 0)
            if let cell = tableView.cellForRow(at: indexPath) {
                configureText(for: cell, with: item)
            }
        }
        navigationController?.popViewController(animated: true)
        
        
    }
    
    func configureCheckmark(for cell: UITableViewCell, with item: ChecklistItem) {
        let label = cell.viewWithTag(1001) as! UILabel
        if item.checked {
            label.text = "√"
        } else {
            label.text = ""
        }
    }
    
    func configureText(for cell: UITableViewCell, with item: ChecklistItem) {
        
        let label = cell.viewWithTag(1000) as! UILabel
        label.text = item.text
    }
}

    
    

    

 

    
