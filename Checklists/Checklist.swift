//
//  Checklist.swift
//  Checklists
//
//  Created by Grey on 9/1/23.
//

import UIKit


class Checklist: NSObject, Codable {
    
    var name = ""
    var items = [ChecklistItem]()
    var iconName = "No Icon"

  //The parameter here should fix error messages?
    
    init(name: String, iconName: String = "No Icon") {
      self.name = name
      self.iconName = iconName
      super.init()
    }

    func countUncheckedItems() -> Int {
      var count = 0
      for item in items where !item.checked {//This time ! means !not.
         count += 1//this reads, count+1= (new)count, rinse, lather, repeat.
      }
      return count
    }
  
}
