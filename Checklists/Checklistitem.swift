//
//  Checklistitem.swift
//  Checklists
//
//  Created by Grey on 8/23/23.
//

import Foundation

//Theres a milestone, my first class in Swift!

class ChecklistItem {
  var text = ""
  var checked = false
}

/*
 It's important to note that the book states that the terms property and instance variable are interchangeable (in Swift but not objective-c). And, that both to refer to an object’s data items.
 Quoting directly it says:
    
 "In Swift terminology, a property is a variable or constant that is used in the context of an object. That’s exactly what an instance variable is."
 
 This answers my earlier question on instance variables.
 
 
 */



/*
 
 Notes on delegates.
 
 So far we have use delegate to: (quoting from book)
 
 "the table view has a delegate that responds to taps on the rows;
 
 the text field has a delegate that you used to validate the length of the text;"
 
 
 For us, we are using delegate to overcome barriers in communication. Delegate is a great name for an object that takes on the duties of another object, but there's more. The are triggered by events and run across separated area in the code. Kind of like Hermes, the winged foot god of message running between heaven and earth, if you will, and remember any greek mythology.
 
 
 */
