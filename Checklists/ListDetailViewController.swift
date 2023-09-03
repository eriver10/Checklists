//
//  ListDetailViewController.swift
//  Checklists
//
//  Created by Grey on 9/1/23.
//

import Foundation
import UIKit



protocol ListDetailViewControllerDelegate: AnyObject {
  func listDetailViewControllerDidCancel(_ controller: ListDetailViewController)
  func listDetailViewController(_ controller: ListDetailViewController, didFinishAdding checklist: Checklist)
  func listDetailViewController(_ controller: ListDetailViewController, didFinishEditing checklist: Checklist)
}

/*

//This one is mine.
 
protocol ListDetailViewControllerDelegate: AnyObject {
  func listDetailViewControllerDidCancel(
    _ controller: ListDetailViewController)
   func listDetailViewController(
     _ controller: ListDetailViewController,
     didFinishAdding checklist: Checklist
   )
   func listDetailViewController(
     _ controller: ListDetailViewController,
     didFinishEditing checklist: Checklist
   )
 }

*/




 class ListDetailViewController: UITableViewController,
 UITextFieldDelegate {
     
   var checklistToEdit: Checklist?
   weak var delegate: ListDetailViewControllerDelegate?
     
     
   @IBOutlet var textField: UITextField!
   @IBOutlet var doneBarButton: UIBarButtonItem!
     
   // MARK: - Actions
   @IBAction func cancel() {
   delegate?.listDetailViewControllerDidCancel(self)
   }
     
   @IBAction func done() {
       if let checklist = checklistToEdit {
         checklist.name = textField.text!
         delegate?.listDetailViewController(
     self,
           didFinishEditing: checklist)
       } else {
         let checklist = Checklist(name: textField.text!)
         delegate?.listDetailViewController(self, didFinishAdding: checklist)
       }
     }
     
   
     
    //Changes the title screen display when user is interacting with edit functionality.
     override func viewDidLoad() {
     
       super.viewDidLoad()
     
       if let checklist = checklistToEdit {
         title = "Edit Checklist"
         textField.text = checklist.name
         doneBarButton.isEnabled = true
     }
         
 }
     //Pops our keyboard.
     override func viewWillAppear(_ animated: Bool) {
       super.viewWillAppear(animated)
       textField.becomeFirstResponder()
     }
     
     
     //Setting it so the user cannot select the table cell with the text field.
     
     // MARK: - Table View Delegates
     override func tableView(
       _ tableView: UITableView,
       willSelectRowAt indexPath: IndexPath
     ) -> IndexPath? {
     return nil
     }
     
     //Adding, "text field delegate methods that enable or disable the Done button depending on whether the text field is empty or not," quoted from book. Next two functions.
     // MARK: - Text Field Delegates
     func textField(
       _ textField: UITextField,
       shouldChangeCharactersIn range: NSRange,
       replacementString string: String
     ) -> Bool {
       let oldText = textField.text!
       let stringRange = Range(range, in: oldText)!
       let newText = oldText.replacingCharacters(
         in: stringRange,
         with: string)
       doneBarButton.isEnabled = !newText.isEmpty
       return true
     }
     func textFieldShouldClear(_ textField: UITextField) -> Bool {
       doneBarButton.isEnabled = false
     return true
     }
     
     
 }
