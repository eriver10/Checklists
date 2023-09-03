//
//  ItemDetailViewController.swift
//  formally (AddItemViewController.swift)
//  Checklists
//
//  Created by Grey on 8/24/23.
//


import UIKit

//Ok, this is new and outside of the class.

//This code establishes AddItemViewControllerDelegate protocol
protocol ItemDetailViewControllerDelegate: AnyObject {
    
    func itemDetailViewControllerDidCancel(
        _ controller: ItemDetailViewController
    )
    func itemDetailViewController(
        _ controller: ItemDetailViewController,
        didFinishAdding item: ChecklistItem
    )
    func itemDetailViewController(
       _ controller: ItemDetailViewController,
       didFinishEditing item: ChecklistItem
     )
    
}



/*
 The book says to think of the delegate protocol a contract between screen b an the Add Item View Controller.
 
 Note: again communication themed, protocol-the rules of how to communicate.
*/




class ItemDetailViewController: UITableViewController,                            UITextFieldDelegate{
    
    //Testing
    /*
    @IBOutlet weak var textField: UITextField!
    */
    
    var itemToEdit: ChecklistItem?
    
    
    /*
     This was added after the delegate protocols outside this class was written. It has to be a hook to the protocols.
     
     Note: the keyword weak and the question mark.
     
     weak describes the type of relationship and the question mark means optional. Was wondering about that.
     
     */
    
    //Outlets: relocated to clean up reading
    @IBOutlet weak var textField: UITextField!
    @IBOutlet weak var doneBarButton: UIBarButtonItem!
    
    weak var delegate: ItemDetailViewControllerDelegate?
    
    
    //Actions:
    @IBAction func cancel() {
        delegate?.itemDetailViewControllerDidCancel(self)
    }

    /*
    @IBAction func done() {
        let item = ChecklistItem()
        item.text = textField.text!
        delegate?.itemDetailViewController(self, didFinishAdding: item)
    }
    */
     
    //Changing above action to add some logic and call new done delegates
    //didFinishAdding and didFinishEditing.
    
    @IBAction func done() {
      
        if let item = itemToEdit {
            item.text = textField.text!
            delegate?.itemDetailViewController(self, didFinishEditing: item)
      } else {
          
          let item = ChecklistItem()
          item.text = textField.text!
          delegate?.itemDetailViewController(self, didFinishAdding: item)
      }
        
    }
    
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        navigationItem.largeTitleDisplayMode = .never
        
        if let item = itemToEdit {
            title = "Edit Item"
            textField.text = item.text
            //Added this line because done is disabled by default.
            doneBarButton.isEnabled = true
            
          }
    }
    
    // MARK: - Table View Delegates
    //This function disable the grey highlight upon selection, in the add item field
    override func tableView(
        _ tableView: UITableView,
        willSelectRowAt indexPath: IndexPath
    ) -> IndexPath? {
        return nil
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        textField.becomeFirstResponder()
    }
    
    
 
    
    
    //MARK: - Text Field Delegates
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let oldText = textField.text!
        let stringRange = Range(range, in: oldText)!
        let newText = oldText.replacingCharacters(in: stringRange, with: string)
        doneBarButton.isEnabled = !newText.isEmpty
        return true
    }
    
    //This is another delegate method, it takes over for the clear method, so we may use it to disable the doneButton properly.
    func textFieldShouldClear(_ textField: UITextField) -> Bool {
        doneBarButton.isEnabled = false
        return true
    }
    
    
    
}
