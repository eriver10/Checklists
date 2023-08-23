//
//  ViewController.swift
//  Checklists
//
//  Created by Grey on 8/22/23.
//



import UIKit



class ChecklistViewController: UITableViewController {
    

    /*
    let row0text = "Walk the dog"
    let row1text = "Brush teeth"
    let row2text = "Learn iOS development"
    let row3text = "Soccer practice"
    let row4text = "Eat ice cream"
    

    var row0checked = false
    var row1checked = false
    var row2checked = false
    var row3checked = false
    var row4checked = false
    */
    
    //replaced the above with this short stack of new instance variables that include initializer methods.
    
    /*
    Initializer methods create a new object instance. In the following, we create empty instances of ChecklistItem that include the default values an empty string (””) and false for checked. Previously, created in the ChecklistItem class.
    */

      var row0item = ChecklistItem()
      var row1item = ChecklistItem()
      var row2item = ChecklistItem()
      var row3item = ChecklistItem()
      var row4item = ChecklistItem()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Setting the text manually for now.
        row0item.text = "Walk the dog"
        row1item.text = "Brush my teeth"
        row1item.checked = true
        row2item.text = "Learn iOS development"
        row2item.checked = true
        row3item.text = "Soccer practice"
        row4item.text = "Eat ice cream"
        row4item.checked = true
        
    }
    
  
     
    override func tableView(
      _ tableView: UITableView,
      numberOfRowsInSection section: Int
    ) -> Int {
    return 5 }//Amended to display this many rows
    
    override func tableView(
      _ tableView: UITableView,
      cellForRowAt indexPath: IndexPath
    ) -> UITableViewCell {
      let cell = tableView.dequeueReusableCell(
        withIdentifier: "ChecklistItem",
        for: indexPath)
    
    // MARK: - Table View Data Source
        

        let label = cell.viewWithTag(1000) as! UILabel
        
        if indexPath.row == 0 {
          label.text = row0item.text
        } else if indexPath.row == 1 {
          label.text = row1item.text
        } else if indexPath.row == 2 {
          label.text = row2item.text
        } else if indexPath.row == 3 {
          label.text = row3item.text
        } else if indexPath.row == 4 {
          label.text = row4item.text
        }
        

        configureCheckmark(for: cell, at: indexPath)
       
        
        return cell
    }

    override func tableView(
      _ tableView: UITableView,
      didSelectRowAt indexPath: IndexPath
    ){

        
        if let cell = tableView.cellForRow(at: indexPath) {
            if indexPath.row == 0 {
              row0item.checked.toggle()
            } else if indexPath.row == 1 {
              row1item.checked.toggle()
            } else if indexPath.row == 2 {
              row2item.checked.toggle()
            } else if indexPath.row == 3 {
              row3item.checked.toggle()
            } else if indexPath.row == 4 {
              row4item.checked.toggle()
            }
            configureCheckmark(for: cell, at: indexPath)
        }
        tableView.deselectRow(at: indexPath, animated: true)
        
    }
        

    
    func configureCheckmark(
      for cell: UITableViewCell,
      at indexPath: IndexPath
    ){
    var isChecked = false
        
        if indexPath.row == 0 {
          isChecked = row0item.checked
        } else if indexPath.row == 1 {
          isChecked = row1item.checked
        } else if indexPath.row == 2 {
          isChecked = row2item.checked
        } else if indexPath.row == 3 {
          isChecked = row3item.checked
        } else if indexPath.row == 4 {
          isChecked = row4item.checked
        }
         if isChecked {
           cell.accessoryType = .checkmark
       } else {
           cell.accessoryType = .none
         }
       }
}


/*
 Next, we tidied up all the errored if/else logic. Now, instead of separate row0text and row0checked variables,  row0item.text and row0item.checked are in play.
 
 If you've used empty "" quotes to zero out a label or text field in the past, there is no mystery on why the labels have disappeared when running the app.
 
 Remember:
 
 class ChecklistItem {
   var text = ""
   var checked = false //initial toggle is false or hidden.
 }
 
 
 
 
 */
