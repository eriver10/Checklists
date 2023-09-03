//
//  AllListsViewController.swift
//  Checklists
//
//  Created by Grey on 9/1/23.
//

import UIKit

//Adding UINavigationControllerDelegate to relay the user's key presses.

class AllListsViewController: UITableViewController, ListDetailViewControllerDelegate, UINavigationControllerDelegate {
    
    let cellIdentifier = "ChecklistCell"
    var dataModel: DataModel!
    
    
    override func viewDidLoad() {

      super.viewDidLoad()
    
      navigationController?.navigationBar.prefersLargeTitles = true
        
      //tableView.register(UITableViewCell.self, forCellReuseIdentifier: cellIdentifier)
        
        
    }
    

    
    
    //MARK: -Navigation
    override func prepare(
        for segue: UIStoryboardSegue,
        sender: Any?
    ){
        if segue.identifier == "ShowChecklist" {
            let controller = segue.destination as!
            ChecklistViewController
            //The as? (as something, and except nil(anything)) keyword if for type casting is like var for setting types.
            controller.checklist = sender as? Checklist
        }else if segue.identifier == "AddChecklist" {
            let controller = segue.destination as!
            ListDetailViewController
            controller.delegate = self
        }
        
    }
    
    
            //tableView Section\\
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
      return dataModel.lists.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
      //let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath)
        
        //Get cell and logic to determine there is a cached cell.
        let cell: UITableViewCell!
        
        if let tmp = tableView.dequeueReusableCell(
          withIdentifier: cellIdentifier) {
          cell = tmp
        } else {
          cell = UITableViewCell(
            style: .subtitle,
            reuseIdentifier: cellIdentifier)
        }
      
      let checklist = dataModel.lists[indexPath.row]
      cell.textLabel!.text = checklist.name
      cell.accessoryType = .detailDisclosureButton
        
      //In swift you are able to, "...call the countUncheckedItems() method on the Checklist object and put the count into a new string that you display using the detailTextLabel," says the book.
      cell.detailTextLabel!.text = "\(checklist.countUncheckedItems())Remaining"

      return cell
    }
    

    
    /*
     
          
    override func tableView(
        _ tableView: UITableView,
        didSelectRowAt indexPath: IndexPath
    ){
        let checklist = dataModel.lists[indexPath.row]
        performSegue(withIdentifier: "ShowChecklist",
                     sender: checklist)
        
        
        //Setting up user defaults. The goal is to save the last list the user access in order to serve it up when the app opens again.
        UserDefaults.standard.set(
            indexPath.row,
            forKey: "ChecklistIndex")
        
        /*
        Was introduced to the Dictionary concept when creating a morse code app. This looks similar in that is has an key-value pairs.
         
         Not unlike and array, calling for the key retrieves the value.
         
         
        */
    }
    
    */
    
    
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
      dataModel.indexOfSelectedChecklist = indexPath.row
      
        let checklist = dataModel.lists[indexPath.row]
      performSegue(withIdentifier: "ShowChecklist", sender: checklist)
    }
    
    
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath){
        
        dataModel.lists.remove(at: indexPath.row)
        
        let indexPaths = [indexPath]
        tableView.deleteRows(at: indexPaths, with: .automatic)
    }
    
    
    override func tableView(
        _ tableView: UITableView,
        accessoryButtonTappedForRowWith indexPath: IndexPath
    ){
        let controller = storyboard!.instantiateViewController(
            withIdentifier: "ListDetailViewController") as!
        ListDetailViewController
        controller.delegate = self

        let checklist = dataModel.lists[indexPath.row]
        controller.checklistToEdit = checklist
        navigationController?.pushViewController(
            controller,
            animated: true)
    }
    
    
    
    
    /*
    //After collecting user behavior, and at the next startup, this function will invoke/display the recored defaults, or in-other-words, show the last list used.
    override func viewDidAppear(_ animated: Bool) {
      super.viewDidAppear(animated)
      navigationController?.delegate = self
      let index = UserDefaults.standard.integer(
        forKey: "ChecklistIndex")
      if index != -1 {
        let checklist = dataModel.lists[index]
        performSegue(
          withIdentifier: "ShowChecklist",
          sender: checklist)
      }
        
      */
        
    override func viewDidAppear(_ animated: Bool) {
        
      super.viewDidAppear(animated)

      navigationController?.delegate = self

      let index = dataModel.indexOfSelectedChecklist
        
        if index >= 0 && index < dataModel.lists.count {
        let checklist = dataModel.lists[index]
        performSegue(withIdentifier: "ShowChecklist", sender: checklist)
        }
    }
     
    /*
     This function uses view will appear instead of view did.
     I will wait till after the view is initiated to update, or appear, to the display. Note: this only by a fraction of a second.
     */
     
     
    override func viewWillAppear(_ animated: Bool) {
      super.viewWillAppear(animated)
      tableView.reloadData()
    }
    
    /*
     The book states the following:
     
     Here, viewWillAppear() tells the table view to reload its entire contents. That will cause tableView(_:cellForRowAt:) to be called again for every visible row. When you tap the back button on the ChecklistViewController’s navigation bar, the AllListsViewController screen will slide back into view. Just before that happens, viewWillAppear() is called.
     Thanks to the call to tableView.reloadData() the app will update all of the table cells, including the detailTextLabels.
     
     */
    
    
    
    
    
    
    
    // MARK: - List Detail View Controller Delegates
    func listDetailViewControllerDidCancel(
        _ controller: ListDetailViewController
    ){
        navigationController?.popViewController(animated: true)
    }
    
    func listDetailViewController(
        _ controller: ListDetailViewController,
        didFinishAdding checklist: Checklist
    ){
        let newRowIndex = dataModel.lists.count
        dataModel.lists.append(checklist)
        
        let indexPath = IndexPath(row: newRowIndex, section: 0)
        let indexPaths = [indexPath]
        
        tableView.insertRows(at: indexPaths, with: .automatic)
        
        navigationController?.popViewController(animated: true)
    }
    
    func listDetailViewController(
        _ controller: ListDetailViewController,
        didFinishEditing checklist: Checklist
    ){
        if let index = dataModel.lists.firstIndex(of: checklist) {
            let indexPath = IndexPath(row: index, section: 0)
            if let cell = tableView.cellForRow(at: indexPath) {
                cell.textLabel!.text = checklist.name
            }
        }
        navigationController?.popViewController(animated: true)
    }
    
    //MARK: - Navigation Controller Delegates
    /*
    This method (assoc. with the navigation controller Delegate) check for key press in order to eventually record screen changes them for our user defaults.
     */
     
     /*
      
      
    func navigationController(
      _ navigationController: UINavigationController,
      willShow viewController: UIViewController,
      animated: Bool ){
          
        //Check for button press.
        if viewController === self {
          UserDefaults.standard.set(-1, forKey: "ChecklistIndex")
        }
      }
    */
    
    
    //MARK: - Navigation Controller Delegates
    func navigationController(_ navigationController: UINavigationController, willShow viewController: UIViewController, animated: Bool) {
          
        //Check for button press.
        if viewController === self {
              dataModel.indexOfSelectedChecklist = -1
        }
      }
    
    
    /*
     A note on equal signs:
     
     =      one means, "is set to"
     ==     two means, "this equates to this"
     ===    three means "this is exactly that," and errors if not.
     
     */
    
}
