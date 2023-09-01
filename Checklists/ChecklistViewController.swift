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
        
        loadChecklistItems()
        
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
        
         */
         
         
         
        //Most likely temporary just to show and test if our documents are pointing to correct directory. 
        print("Documents folder is \(documentsDirectory())")
        print("Data file path is \(dataFilePath())")
        //Looking good showing paths in console.
        
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
        
       
        
          let item = items[indexPath.row]
          item.checked.toggle()
          configureCheckmark(for: cell, with: item)
        }
        tableView.deselectRow(at: indexPath, animated: true)
        
        //Note: the call to this new function to handle saving to file. Here within the check or not check function.
        saveChecklistItems()
      }
    
    
    
    
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
      items.remove(at: indexPath.row)

      let indexPaths = [indexPath]
      tableView.deleteRows(at: indexPaths, with: .automatic)
        
        //Note: the call to this new function to handle saving to file. Here within our swipe to delete.
        saveChecklistItems()
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
        
        //Note: the call to this new function to handle saving to file.
        saveChecklistItems()
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
        
        saveChecklistItems()
    }
    
    /*
    New functions bellow: for chap 15, adding a way to access this apps sandboxed file and save our checklist data to it.
    */
    
    //This function points to a URL or URL as an address to save to.
    func documentsDirectory() -> URL {
      let paths = FileManager.default.urls(
        for: .documentDirectory,
        in: .userDomainMask)
      return paths[0]
    }
    //This function calls the documentsDirectory() to get the address and inserts a file, Checklists.plist, to hold our information
        
    func dataFilePath() -> URL {
      return
    documentsDirectory().appendingPathComponent("Checklists.plist")
    }
    
    /*
     .plist stands for Property List. It is an XML file format. Similar to a config file, it a stores a Property list of settings and their values.
     */
    
    
    
    /*
    Note: this functioned errored with:
     
     Class 'PropertyListEncoder' requires that 'ChecklistItem' conform to 'Encodable'
    
     Moving forward, I think this may resolve itself with next code...
     */
     
    
    /*
     Question Answered. The book says says the error occurs because, "... any object encoded (or decoded) by a PropertyListEncoder — or for that matter, any of the other encoders/decoders compatible with the Codable protocol — must support the Codable protocol, and ChecklistItem does not."
     
     Fixing this Now.
     
     */
    
     
    func saveChecklistItems() {
      // 1 This called function encodes, or converts, our array data, the list items, into text the file can use to, thus, save it to the hardware.
      let encoder = PropertyListEncoder()
      // 2 Looks like a try/catch to catch an error, most likely if empty or data is in wrong format.
      do {
    // 3
        let data = try encoder.encode(items)
        // 4
        try data.write(
          to: dataFilePath(),
          options: Data.WritingOptions.atomic)
        // 5
    } catch { // 6
        //Note: this will print ot the console not in a text field.
        print("Error encoding item array: \(error.localizedDescription)")
    
      }
        
    }
    
    //Note: the do/catch statements. Are they the same as try/catch??
    
    func loadChecklistItems() {
      // 1
      let path = dataFilePath()
      // 2
      if let data = try? Data(contentsOf: path) {
    // 3
        let decoder = PropertyListDecoder()
        do {
    // 4
          items = try decoder.decode(
            [ChecklistItem].self,
            from: data)
        } catch {
          print("Error decoding item array: \(error.localizedDescription)")
    } }
    }
    
  }
    
    



    
    
    
    
    

    

    
    
    
    
    
    
    

    

    
    

    


    
    
 
    

