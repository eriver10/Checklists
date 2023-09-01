//
//  Checklistitem.swift
//  Checklists
//
//  Created by Grey on 8/23/23.
//

import Foundation

//Add in : NSObject, Codable

//Codable, allows us to change the listed items to be saved into a form that can be saved and read from, when sent to file.

 class ChecklistItem: NSObject, Codable{
  var text = ""
  var checked = false
}

