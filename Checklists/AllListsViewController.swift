//
//  AllListsViewController.swift
//  Checklists
//
//  Created by Grey on 9/1/23.
//

import UIKit

class AllListsViewController: UITableViewController, ListDetailViewControllerDelegate {
    
    let cellIdentifier = "ChecklistCell"
    
    
    /*
    var lists = [Checklist]()
    //Note: Above is short hand for:
    //var lists = Array<Checklist>()
    */
     
     var dataModel: DataModel!
    
    
    //test
    override func viewDidLoad() {
      super.viewDidLoad()
      navigationController?.navigationBar.prefersLargeTitles = true
      tableView.register(
        UITableViewCell.self,
        forCellReuseIdentifier: cellIdentifier)
    // Load data
      //loadChecklists()
    }
    
    override func tableView(_ tableView: UITableView,                              numberOfRowsInSection section: Int) -> Int {
        
        /*
         //Notice, changing the default number of items for an adaptable command that returns what ever the size of the array is.
         return 3
         */
        
        return dataModel.lists.count
        
        
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
        cellForRowAt indexPath: IndexPath
    ) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(
            withIdentifier: cellIdentifier, for: indexPath)
        
        
        //Updating Cell info.
        let checklist = dataModel.lists[indexPath.row]
        cell.textLabel!.text = checklist.name
        cell.accessoryType = .detailDisclosureButton
        
        return cell
    }
    
    //This function add functionality to our newly connected views. It should initiate by user press on a row, hence, didSelectRowAt.
    override func tableView(
        _ tableView: UITableView,
        didSelectRowAt indexPath: IndexPath
    ){
        let checklist = dataModel.lists[indexPath.row]
        performSegue(withIdentifier: "ShowChecklist",
                     sender: checklist)
    }
    
    override func tableView(
        _ tableView: UITableView,
        commit editingStyle: UITableViewCell.EditingStyle,
        forRowAt indexPath: IndexPath
    ){
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
    
    
    
    
    //override................................
    
    /*
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
        
        //Temporary Add placeholder item data
        for list in lists {
            let item = ChecklistItem()
            item.text = "Item for \(list.name)"
            list.items.append(item)
            //Note: Swifts way of working a for loop.
            
        }
        
    }
    
 */

     
    
    
    
    
    /*
     Book says to remove this section for without it there will always be a single section in the table view.
     
     // MARK: - Table view data source
     
     override func numberOfSections(in tableView: UITableView) -> Int {
     // #warning Incomplete implementation, return the number of sections
     return 0
     }
     */
    

    
    //Implementing: tableView(_:cellForRowAt:) function.
    
    //Current error: Cannot find 'cellIdentifier' in scope
    //Fixed by adding the const. let cellIdentifier = "ChecklistCell" to this class
    

    
 
    

    

    

    
    
    
    
    
    
    
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
    
    
    
    /*
    
    // MARK: - Data Saving
    func documentsDirectory() -> URL {
      let paths = FileManager.default.urls(
        for: .documentDirectory,
        in: .userDomainMask)
      return paths[0]
    }
    
    
    func dataFilePath() -> URL {
      return
    documentsDirectory().appendingPathComponent("Checklists.plist")
    }
    
    /*
    func saveChecklists() {
        let encoder = PropertyListEncoder()
        do {
            // You encode lists instead of "items"
            let data = try encoder.encode(lists)
            try data.write(
                to: dataFilePath(),
                options: Data.WritingOptions.atomic)
        } catch {
            print("Error encoding list array: \(error.localizedDescription)")
        }
        
        // this method is now called loadChecklists()
        func loadChecklists() {
            let path = dataFilePath()
            if let data = try? Data(contentsOf: path) {
                let decoder = PropertyListDecoder()
                do {
                    // You decode to an object of [Checklist] type to lists
                lists = try decoder.decode(
                        [Checklist].self,
                        from: data)
                } catch {
                    print("Error decoding list array: \(error.localizedDescription)")
                }
            }
        }
        */
         
         
    
              
              
    
    
    */
    
    
    
    
    
    
}
