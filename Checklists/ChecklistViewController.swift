//
//  ViewController.swift
//  Checklists
//
//  Created by Grey on 8/22/23.
//



import UIKit



class ChecklistViewController: UITableViewController {
    
    

    var items = [ChecklistItem]()
    
    //NOTE: the syntax for array creation in swift.
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        
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
        item5.text = "Eat ice cream"
        items.append(item5)
        
        //Code added to enable large titles in display. It looks like something you might see in a config file.
        navigationController?.navigationBar.prefersLargeTitles = true
        
    }
    
    
    
    override func tableView(
        _ tableView: UITableView,
        numberOfRowsInSection section: Int
    ) -> Int {

        return items.count
    }
    
    
    override func tableView(
        _ tableView: UITableView,
        cellForRowAt indexPath: IndexPath
    ) -> UITableViewCell {
        
        
        
        /*
        let cell = tableView.dequeueReusableCell(
            withIdentifier: "ChecklistItem",
            for: indexPath)
        
        
         let item = items[indexPath.row]
        
              
        let label = cell.viewWithTag(1000) as! UILabel
        
        label.text = item.text
              
        configureCheckmark(for: cell, at: indexPath)
                
        */
        
        let cell = tableView.dequeueReusableCell(
            withIdentifier: "ChecklistItem",
            for: indexPath)
        
          let item = items[indexPath.row]
        
          configureText(for: cell, with: item)
          configureCheckmark(for: cell, with: item)
        
        return cell
        
    }
    
    
    
    override func tableView(
        _ tableView: UITableView,
        didSelectRowAt indexPath: IndexPath
    ){
        
        /*
        if let cell = tableView.cellForRow(at: indexPath) {
            
            let item = items[indexPath.row]
            item.checked.toggle()
            //calling toggle method where could that be?
            
            configureCheckmark(for: cell, at: indexPath)
        }
        
        */
        
        if let cell = tableView.cellForRow(at: indexPath) {
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
    
    override func tableView(
      _ tableView: UITableView,
      commit editingStyle: UITableViewCell.EditingStyle,
      forRowAt indexPath: IndexPath
    ){
    // 1
      items.remove(at: indexPath.row)
    // 2
      let indexPaths = [indexPath]
      tableView.deleteRows(at: indexPaths, with: .automatic)
    }
    //Note: the call items.remove(at:) doesn't just remove the ChecklistItem from the array but also permanently destroys the object, a form of memory management.
    
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
    
    func configureText(
      for cell: UITableViewCell,
      with item: ChecklistItem
    ){
        
        let label = cell.viewWithTag(1000) as! UILabel
        label.text = item.text
        
    }
    
    // MARK: - Actions
    @IBAction func addItem() {
        
        //This const is collecting the array's size
        //Arrays begin at zero, nearly everything in computers actually.
        let newRowIndex = items.count
        //This const instantiates, or creates, an new object, based on our newest class.
        let item = ChecklistItem()
        
        //This familiar territory, we are piping a string into item as text.
        //Or, you could say we are sending it up for display.
          item.text = "I am a new row"
          items.append(item)//Then, adding it to the end(appending the array).
          
        //These lines call up and create a new row then create an array to hold one or more rows along with activating an animation.
        
          let indexPath = IndexPath(row: newRowIndex, section: 0)
          let indexPaths = [indexPath]
        
          tableView.insertRows(at: indexPaths, with: .automatic)
        
        /*
         To quote the book:
        
        "1. Created a new ChecklistItem object.
         2. Added it to the data model.
         3. Inserted a new row for it in the table view."
        */
        
        
    }
    
}
