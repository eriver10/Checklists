//
//  ViewController.swift
//  Checklists
//
//  Created by Grey on 8/22/23.
//



import UIKit



class ChecklistViewController: UITableViewController {
    
    //These variable a within this class but out of the scope of any functions/methods
    //I would consider these global and constant (keyword let), lets see.
    
    let row0text = "Walk the dog"
    let row1text = "Brush teeth"
    let row2text = "Learn iOS development"
    let row3text = "Soccer practice"
    let row4text = "Eat ice cream"
    
    //The book calls these instance variables.
    //I don't recall the author introducing instance variables.
    
    //The var here is asking to infer the type of these variables by what is set in them.
    //In this case false id's them as booleans (true or false).
    var row0checked = false
    var row1checked = false
    var row2checked = false
    var row3checked = false
    var row4checked = false
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
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
        
        //To describe this part of the lesson, I would translate this as hard coded versus dynamic or constants versus variable. If I understood how to write in this language this might be the way I go about before learning the more dynamic way.
        
        let label = cell.viewWithTag(1000) as! UILabel
          if indexPath.row == 0 {
            label.text = row0text
          } else if indexPath.row == 1 {
            label.text = row1text
          } else if indexPath.row == 2 {
            label.text = row2text
          } else if indexPath.row == 3 {
            label.text = row3text
          } else if indexPath.row == 4 {
            label.text = row4text
          }
        
        //calling this method come into play later when fixing the check mark problem
        configureCheckmark(for: cell, at: indexPath)
       
        
        return cell
    }

    override func tableView(
      _ tableView: UITableView,
      didSelectRowAt indexPath: IndexPath
    ){
        /*
         if let cell = tableView.cellForRow(at: indexPath) {
         var isChecked = false
         if indexPath.row == 0 {
         row0checked.toggle()
         isChecked = row0checked
         } else if indexPath.row == 1 {
         row1checked.toggle()
         isChecked = row1checked
         } else if indexPath.row == 2 {
         row2checked.toggle()
         isChecked = row2checked
         } else if indexPath.row == 3 {
         row3checked.toggle()
         isChecked = row3checked
         } else if indexPath.row == 4 {
         row4checked.toggle()
         isChecked = row4checked
         }
         if isChecked {
         cell.accessoryType = .checkmark
         } else {
         cell.accessoryType = .none
         }
         }
         tableView.deselectRow(at: indexPath, animated: true)
         }
         */
        
        //Replaced above with this. Now instead of setting the checkmark, it now toggles the checked state.
        
        if let cell = tableView.cellForRow(at: indexPath) {
            if indexPath.row == 0 {
                row0checked.toggle()
            } else if indexPath.row == 1 {
                row1checked.toggle()
            } else if indexPath.row == 2 {
                row2checked.toggle()
            } else if indexPath.row == 3 {
                row3checked.toggle()
            } else if indexPath.row == 4 {
                row4checked.toggle()
            }
            configureCheckmark(for: cell, at: indexPath)
        }
        tableView.deselectRow(at: indexPath, animated: true)
        
    }
        
    /*
     This function/method fixes our check mark problem where the the initial setting (bool) of the check mark was set when it is called from:
     override func tableView(_ tableView:
     
     I encountered a similar issue in vscode where the solution was to toggle a boolean value under the objects attribute, what we call attribute inspector. 

     */
    
    func configureCheckmark(
      for cell: UITableViewCell,
      at indexPath: IndexPath
    ){
    var isChecked = false
      if indexPath.row == 0 {
          isChecked = row0checked
         } else if indexPath.row == 1 {
           isChecked = row1checked
         } else if indexPath.row == 2 {
           isChecked = row2checked
         } else if indexPath.row == 3 {
           isChecked = row3checked
         } else if indexPath.row == 4 {
           isChecked = row4checked
         }
         if isChecked {
           cell.accessoryType = .checkmark
       } else {
           cell.accessoryType = .none
         }
       }
}

/*
 At this point the book goes into how Swift, or rather objective c, organizes its function/methods' syntax.
 
 Instead of the way I might be used seeing a function called:
 
    configureCheckmark(someCell, someIndexPath)
 
 It formats like so:
 
    configureCheckmark(for: someCell, at: someIndexPath)
 
 The prepositions for, at, and with are required in the Arguments section. They add bit of english and more understanding of what is being asked (or called) of the function.
 
 On the other end, at the actual function, the parameters look this.
 
 func configureCheckmark( for cell: UITableViewCell,
    at indexPath: IndexPath ){
    
    //This is inside. Note the internal name of the variable
    if indexPath.row == 0 {...
 
    ||side note ==
 
    For me, my best translation would be: this function excepts cell of type UITableViewCell and indexPath of type IndexPath
    However, I'm still getting used it may change it in the future or I'm wrong altogether.
 
 */
