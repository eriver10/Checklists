//
//  Checklist.swift
//  Checklists
//
//  Created by Grey on 9/1/23.
//

import UIKit

class Checklist: NSObject {
    
    var name = ""
    var items = [ChecklistItem]()

    /*
     Note: Can also be written in longer formats:
     var items: [ChecklistItem] = [ChecklistItem]()
     or
     var items: [ChecklistItem] = []
     */
    
 
    //Reminder: init(initializer) is like a function.
    init(name: String) {
      self.name = name
      super.init()
    }
    
    /*
     Note: similar to the "this." keyword "self." tells swift that self.name refers the variable within this class and not the variable piped in from the function.
     
     In other words, take this here and set it to that (this) that came from over there.
     */
    
}
