//
//  ViewController.swift
//  Checklists
//
//  Created by Grey on 8/22/23.
//

/*
 Imports add extra functionality to the code. Interestingly, these may be added to the language properly in the future or kept imports depending on the use case.
 */

import UIKit



class ChecklistViewController: UITableViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    /*
     So far our class has not discussed Overrides. It is my understanding that this function is inherited from its class, that is a rule set by the class it requires it to exist as perhaps a default. Then is up to the programmer to override or to specify what the function does in their new object.
    */
    
    /*
     What's notable about these functions is that they carry more than one parameter or inputs if you will. And they are functions that return a value, or output.
     */
     
    /*
     I am  unfamiliar with this syntax using the colon. I am fairly new to programming. It may suggest something along the lines of get this from this and be this variable. Then the inside mechanics of the function manipulate those values and send out, return that is, a value. In this case it most likely returns a single row?
     */
     
    override func tableView(
      _ tableView: UITableView,
      numberOfRowsInSection section: Int
    ) -> Int {
    return 100 }//Amended to display this many rows
    
    // MARK: - Table View Data Source
    
    /*
     The above comment is using a keyword "mark." It is used an indicator to find this passage.
     This is reminiscent of "TODO and FIXME" highlighting found in VSCode.
     */
    
    override func tableView(
      _ tableView: UITableView,
      cellForRowAt indexPath: IndexPath
    ) -> UITableViewCell {
      let cell = tableView.dequeueReusableCell(
        withIdentifier: "ChecklistItem",
        for: indexPath)
        
        /*
         Previously, we set the View,Tag with the unique identifier 1000. Then we added the following logic to this code to set the cell labels:
        
         
         To quote the book " Using tags is a handy trick to get a reference to a UI element without having to make an @IBOutlet variable for it."
         */
        
        
        let label = cell.viewWithTag(1000) as! UILabel
        
        
        if indexPath.row % 5 == 0 {
          label.text = "Walk the dog"
        } else if indexPath.row % 5 == 1 {
          label.text = "Brush my teeth"
        } else if indexPath.row % 5 == 2 {
          label.text = "Learn iOS development"
        } else if indexPath.row % 5 == 3 {
          label.text = "Soccer practice"
        } else if indexPath.row % 5 == 4 {
          label.text = "Eat ice cream"
        }
        
        //Note: as always we start with the number zero.
        //The Book changed the code above to introduce the modulo operator. Is is Typo? I've always heard it referred to as the Modulus operator.
        
        //Most, likely this will change to allow the user to set the labels?
        
        return cell
    }

    //Reminder: the book introduces break points. 234
    
    /*Note to self:
    
     func tableView(_ tableView: UITableView,
       numberOfRowsInSection section: Int
    
     is comparable to the following in other languages:
     
    Int numberOfRowsInSection(UITableView tableView, Int section) {
     
     
    Quote from book:
     
     "The _ underscore is used when you don’t want a parameter to have an external name.
     
     ...the _ on the first parameter of methods that come from Objective-C frameworks. With such methods the first parameter only has one name but the other parameters have two.
     
     Sometimes people with experience in other languages get confused because they think that ChecklistViewController.swift contains three functions that are all named tableView().
     
     ...in Swift: the names of the parameters are part of the full method name."
     
     For example,
     
     "tableView(_:numberOfRowsInSection:)
     tableView(_:cellForRowAt:)
     tableView(_:didSelectRowAt:),"
     
     these are three different names.
     
    */
}

