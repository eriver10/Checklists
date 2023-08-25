//
//  AddItemViewController.swift
//  Checklists
//
//  Created by Grey on 8/24/23.
//


import UIKit

//Ok, this is new and outside of the class.

//This code establishes AddItemViewControllerDelegate protocol
protocol AddItemViewControllerDelegate: AnyObject {
  
    func addItemViewControllerDidCancel(
    _ controller: AddItemViewController)
    func addItemViewController(
    _ controller: AddItemViewController,
    didFinishAdding item: ChecklistItem
  )
}



/*
 The book says to think of the delegate protocol a contract between screen b an the Add Item View Controller.
 
 Note: again communication themed, protocol-the rules of how to communicate.
*/




class AddItemViewController: UITableViewController,
                             UITextFieldDelegate{
    
    
    /*
     This was added after the delegate protocols outside this class was written. It has to be a hook to the protocols.
     
     Note: the keyword weak and the question mark.
     
     weak describes the type of relationship and the question mark means optional. Was wondering about that.
     
     */
    
    //Outlets: relocated to clean up reading
    @IBOutlet weak var textField: UITextField!
    @IBOutlet weak var doneBarButton: UIBarButtonItem!
    
    weak var delegate: AddItemViewControllerDelegate?
    
    
    //Actions:
    @IBAction func cancel() {
        delegate?.addItemViewControllerDidCancel(self)
    }
    
    @IBAction func done() {
        let item = ChecklistItem()
        item.text = textField.text!
        delegate?.addItemViewController(self, didFinishAdding: item)
    }
    
    

    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.largeTitleDisplayMode = .never
    }
    
    // MARK: - Actions
    
    /*
     @IBAction func cancel() {
     navigationController?.popViewController(animated: true)
     }
     @IBAction func done() {
     
     //When done is pressed, this statement will collect text and print it to the console.
     print("Contents of the text field: \(textField.text!)")
     
     navigationController?.popViewController(animated: true)
     }
     */
    
    
    
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
    
    
    
    
    //Quote from book,"This is one of the UITextField delegate methods. It is invoked every time the user changes the text, whether by tapping on the keyboard or via cut/paste.
    
    // MARK: - Text Field Delegates
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
