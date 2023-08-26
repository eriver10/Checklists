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
        
    var items = [ChecklistItem]()
    //NOTE: the syntax for array creation in swift.

    
    
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        //Code added to enable large titles in display. It looks like something you might see in a config file.
        navigationController?.navigationBar.prefersLargeTitles = true
        
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
    }

    // MARK: - Table View Data Source
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
      return items.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) ->
    UITableViewCell {
      let cell = tableView.dequeueReusableCell(
        withIdentifier: "ChecklistItem",
        for: indexPath)

      let item = items[indexPath.row]
      configureText(for: cell, with: item)
      configureCheckmark(for: cell, with: item)
      return cell
    }
    
    //MARK: - Table View Delegate
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
      if let cell = tableView.cellForRow(at: indexPath) {
        
        /*
        if let cell = tableView.cellForRow(at: indexPath) {
            
            let item = items[indexPath.row]
            item.checked.toggle()
            //calling toggle method where could that be?
            
            configureCheckmark(for: cell, at: indexPath)
        }
        
        */
        
          let item = items[indexPath.row]
          item.checked.toggle()
          configureCheckmark(for: cell, with: item)
        }
        tableView.deselectRow(at: indexPath, animated: true)
      }
    
    
    
    /*
     This method provide a swipe-to-delete function.
     As, before it uses a built in animation, however,
     this time we are removing instead of appending the row and array.
        
     */
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
      items.remove(at: indexPath.row)

      let indexPaths = [indexPath]
      tableView.deleteRows(at: indexPaths, with: .automatic)
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
          controller.itemToEdit = items[indexPath.row]
        }
      }
    }
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    /*
    func configureCheckmark(
      for cell: UITableViewCell,
      with item: ChecklistItem
    ){
    if item.checked {
        cell.accessoryType = .checkmark
      } else {
        cell.accessoryType = .none
      }
    }
    */
     //Changed checkmark location and added a custom check, Now changing this code to:
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
    
    // MARK: - Add Item ViewController Delegates
    func itemDetailViewControllerDidCancel(_ controller: ItemDetailViewController) {
      navigationController?.popViewController(animated: true)
    }
    
    func itemDetailViewController(_ controller: ItemDetailViewController, didFinishAdding item: ChecklistItem) {
      let newRowIndex = items.count
      items.append(item)

      let indexPath = IndexPath(row: newRowIndex, section: 0)
      let indexPaths = [indexPath]
      tableView.insertRows(at: indexPaths, with: .automatic)

      navigationController?.popViewController(animated: true)
    }

    
    func itemDetailViewController(
      _ controller: ItemDetailViewController,
      didFinishEditing item: ChecklistItem
    ) {
      if let index = items.firstIndex(of: item) {
        let indexPath = IndexPath(row: index, section: 0)
        if let cell = tableView.cellForRow(at: indexPath) {
          configureText(for: cell, with: item)
        }
      }
      navigationController?.popViewController(animated: true)
    }
  }
    
    


        /*
         To quote the book:
        
        "1. Created a new ChecklistItem object.
         2. Added it to the data model.
         3. Inserted a new row for it in the table view."
        */
        
        
    
    //...............................
    
    
    
    
    
    

    

    
    
    
    
    
    
    

    

    
    

    

     /*
     //Is this my error??
      
      
    // MARK: -Item Control Delegates, added by fix then added code
    func itemDetailViewControllerDidCancel(
      _ controller: ItemDetailViewController
    ){
      navigationController?.popViewController(animated: true)
    }
    */
    

    
    
 
    

