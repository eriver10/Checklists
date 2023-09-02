//
//  AllListsViewController.swift
//  Checklists
//
//  Created by Grey on 9/1/23.
//

import UIKit

class AllListsViewController: UITableViewController, ListDetailViewControllerDelegate {
    
    let cellIdentifier = "ChecklistCell"
    
    var lists = [Checklist]()
    //Note: Above is short hand for:
    //var lists = Array<Checklist>()
    
    

    override func viewDidLoad() {
        super.viewDidLoad()

        
        //This, "registers our cell identifier with the table view so that the table view knows which cell class should be used to create a new table view cell instance when a dequeue request comes in with that cell identifier." quoted from book.
        
        tableView.register(UITableViewCell.self, forCellReuseIdentifier:
        cellIdentifier)

        //Enabling large titles
        navigationController?.navigationBar.prefersLargeTitles = true
        
        
        //Adding some placeholders for our list of checklists.
          var list = Checklist(name: "Hurricane prep")
          lists.append(list)
          list = Checklist(name: "Groceries")
          lists.append(list)
          list = Checklist(name: "Cool Apps")
          lists.append(list)
          list = Checklist(name: "To Do")
          lists.append(list)
        
    }

    /*
     Book says to remove this section for without it there will always be a single section in the table view.
     
    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 0
    }
    */
    
    override func tableView(_ tableView: UITableView,                              numberOfRowsInSection section: Int) -> Int {
             
        /*
        //Notice, changing the default number of items for an adaptable command that returns what ever the size of the array is.
         return 3
        */
         
        return lists.count
         
         
    }

    //Implementing: tableView(_:cellForRowAt:) function.
    
    //Current error: Cannot find 'cellIdentifier' in scope
    //Fixed by adding the const. let cellIdentifier = "ChecklistCell" to this class
    
    override func tableView(
      _ tableView: UITableView,
      cellForRowAt indexPath: IndexPath
    ) -> UITableViewCell {
      let cell = tableView.dequeueReusableCell(
        withIdentifier: cellIdentifier, for: indexPath)
        
        
        //Updating Cell info.
          let checklist = lists[indexPath.row]
          cell.textLabel!.text = checklist.name
          cell.accessoryType = .detailDisclosureButton

      return cell
    }
    
    //This function add functionality to our newly connected views. It should initiate by user press on a row, hence, didSelectRowAt.
    override func tableView(
      _ tableView: UITableView,
      didSelectRowAt indexPath: IndexPath
    ){
        let checklist = lists[indexPath.row]
        performSegue(withIdentifier: "ShowChecklist",
            sender: checklist)
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
    
    override func tableView(
      _ tableView: UITableView,
      commit editingStyle: UITableViewCell.EditingStyle,
      forRowAt indexPath: IndexPath
    ){
    lists.remove(at: indexPath.row)
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
      let checklist = lists[indexPath.row]
      controller.checklistToEdit = checklist
      navigationController?.pushViewController(
        controller,
        animated: true)
    }
    
    
    
    
    
    
    
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
        let newRowIndex = lists.count; lists.append(checklist)
       
      let indexPath = IndexPath(row: newRowIndex, section: 0)
      let indexPaths = [indexPath]
        
      tableView.insertRows(at: indexPaths, with: .automatic)
        
      navigationController?.popViewController(animated: true)
    }
    
    func listDetailViewController(
      _ controller: ListDetailViewController,
      didFinishEditing checklist: Checklist
    ){
    if let index = lists.firstIndex(of: checklist) {
        let indexPath = IndexPath(row: index, section: 0)
        if let cell = tableView.cellForRow(at: indexPath) {
            cell.textLabel!.text = checklist.name
           }
       }
         navigationController?.popViewController(animated: true)
       }
    
    
    
    
    
}
