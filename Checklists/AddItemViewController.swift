//
//  AddItemViewController.swift
//  Checklists
//
//  Created by Grey on 8/24/23.
//


import UIKit



/*
class AddItemViewController: UITableViewController {
 */
//changed from above to add a delegate

class AddItemViewController: UITableViewController,
                             UITextFieldDelegate{
 
 
 

    
    override func viewDidLoad() {
    super.viewDidLoad()
  }
    
    // MARK: - Actions
    @IBAction func cancel() {
      navigationController?.popViewController(animated: true)
    }
    @IBAction func done() {
        
        //When done is pressed, this statement will collect text and print it to the console.
          print("Contents of the text field: \(textField.text!)")
        
      navigationController?.popViewController(animated: true)
    }
    
    // MARK: - Table View Delegates
    
    //This function disable the grey highlight upon selection, in the add item field
    override func tableView(
      _ tableView: UITableView,
      willSelectRowAt indexPath: IndexPath
    ) -> IndexPath? {
    return nil
    }
 
    /*
     As you may have function are coded to do a something. However, they can also be coded to return a value. In this case, when called this function returns a nil.
     
     And, not unlike other languages, you have to specify the type to be returned. It looks a little odd but IndexPath must be a type.

     A reminder, functions are usually set to Void if they are not returning any values.
     
     
     Note the use of nil above. If you have some familiarity with other languages you know that each have a special key word to denote a nothing, unknown or no value, Swift looks like it has nil.


     A note on the -->, it is a corner cutting way to say returns and save you some typing. It is often referred to as notation

     */
    
    /*
    I am guessing by lookin at this code that it will be superseding its default to hide the keyboard to now showing it.
     
     First Responder is great name and descriptive.
     
     Often, in other languages, you can set code or function to auto execute the moment a window is open regardless of other code or user interaction.
    */
    
    override func viewWillAppear(_ animated: Bool) {
      super.viewWillAppear(animated)
      textField.becomeFirstResponder()
    }
 
    /*
     Adding this book quote for my personal use.
     
     Delegates are used everywhere in the iOS SDK, so it’s good to remember that it always takes three steps to become a delegate.
     
     1. You declare yourself capable of being a delegate. To become the delegate for UITextField you need to include UITextFieldDelegate in the class line for the view controller. This tells the compiler that this particular view controller can actually handle the notification messages that the text field sends to it.
     
     2. You let the object in question, in this case the UITextField, know that the view controller wishes to become its delegate. If you forget to tell the text field that it has a delegate, it will never send you any notifications.
     
     3. Implement the delegate methods. It makes no sense to become a delegate if you’re not responding to the messages you’re being sent!
     
     */
    /*
     
     added this by pulling storyboard line into this class and naming it doneBarButton in the popup context menu. This is important because it went wrong the first time and didn't show the context box, making the next function, textField, unusable. Also, it doesn't show it the book, be sure that the context menu reads IBOutlet not IBAction.
    
     Oh, it's really easy to create breakpoint when dragging here.
     
    */
    
    @IBOutlet weak var doneBarButton: UIBarButtonItem!
    
    //Quote from book,"This is one of the UITextField delegate methods. It is invoked every time the user changes the text, whether by tapping on the keyboard or via cut/paste.
    
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
      if newText.isEmpty {
        doneBarButton.isEnabled = false
      } else {
        doneBarButton.isEnabled = true
      }
    return true
    }
    
    //This is another delegate method, it takes over for the clear method, so we may use it to disable the doneButton properly.
    func textFieldShouldClear(_ textField: UITextField) -> Bool {
      doneBarButton.isEnabled = false
    return true
    }
    
    
}
