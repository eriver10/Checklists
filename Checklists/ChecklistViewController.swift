//
//  ViewController.swift
//  Checklists
//
//  Created by Grey on 8/22/23.
//



import UIKit



class ChecklistViewController: UITableViewController {
    
    
    /*
     var row0item = ChecklistItem()
     var row1item = ChecklistItem()
     var row2item = ChecklistItem()
     var row3item = ChecklistItem()
     var row4item = ChecklistItem()
     */
    
    //Replaced the above with this shiny new array.
    var items = [ChecklistItem]()
    
    //NOTE: the syntax for array creation in swift.
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        /*
         //Setting the text manually for now.
         row0item.text = "Walk the dog"
         row1item.text = "Brush my teeth"
         row1item.checked = true
         row2item.text = "Learn iOS development"
         row2item.checked = true
         row3item.text = "Soccer practice"
         row4item.text = "Eat ice cream"
         row4item.checked = true
         */
        
        
        /*
         Still manually for now. Notice it is calling our new friend ChecklistItem. This is called instantiation. Or in other words, creating an object based on the template we previously created.
         */
        
        
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

        
        //NOT: how Swift add items to our array with .append and how it graphically changes the label with .text
        
        //Is there an Item zero?
    }
    
    
    
    override func tableView(
        _ tableView: UITableView,
        numberOfRowsInSection section: Int
    ) -> Int {
        /*
         return 5 }//Amended to display this many rows
         */
        
        //Ok, now I've see this before! where returning the array count or in other word, looking up how many items it holds.
        return items.count
    }
    
    
    override func tableView(
        _ tableView: UITableView,
        cellForRowAt indexPath: IndexPath
    ) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(
            withIdentifier: "ChecklistItem",
            for: indexPath)
        
        // MARK: - Table View Data Source
        
        
        //This looks a bit familiar.
        let item = items[indexPath.row]
        
        
        let label = cell.viewWithTag(1000) as! UILabel
        
        /*
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
         */
        
        //Above replaced. Short and sweet.
        label.text = item.text
        
        
        configureCheckmark(for: cell, at: indexPath)
        
        
        return cell
    }
    
    override func tableView(
        _ tableView: UITableView,
        didSelectRowAt indexPath: IndexPath
    ){
        
        
        if let cell = tableView.cellForRow(at: indexPath) {
            
            /*
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
             */
            //Another short and sweet replacement.
            let item = items[indexPath.row]
            item.checked.toggle()
            //calling toggle method where could that be?
            
            configureCheckmark(for: cell, at: indexPath)
        }
        
        tableView.deselectRow(at: indexPath, animated: true)
        
    }
    
    
    
    func configureCheckmark(
        for cell: UITableViewCell,
        at indexPath: IndexPath
    ){
        
        
        /*
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
         */
        
        //Replaced above.
        let item = items[indexPath.row]
        if item.checked {
            cell.accessoryType = .checkmark
        } else {
            cell.accessoryType = .none
        }
    }
}
//Speaking of Arrays: let item = items[indexPath.row]
//Translates to let this variable stand in for the index and access that index, or what is holds and set it to item.


