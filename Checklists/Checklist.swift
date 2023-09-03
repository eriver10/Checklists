//
//  Checklist.swift
//  Checklists
//
//  Created by Grey on 9/1/23.
//

import UIKit


//Added Codable here to fix an error I ran into in last lesson. Just incase I miss it.
class Checklist: NSObject, Codable {
    
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
    
    //This function probes our checked items and give total using a running total, the += in a for/in loop.
    func countUncheckedItems() -> Int {
        
      var count = 0
        
      for item in items where !item.checked {
    count += 1 }//This reads count+count = (new)count, rinse, lather, repeat.
      
        return count
    }
    
}
