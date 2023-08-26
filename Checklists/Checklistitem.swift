//
//  Checklistitem.swift
//  Checklists
//
//  Created by Grey on 8/23/23.
//

import Foundation

/*
class ChecklistItem {
*/
 
/*
changes above in order to fix an error:
Referencing instance method 'firstIndex(of:)' on 'Collection' requires that 'ChecklistItem' conform to 'Equatable'
*/
 class ChecklistItem: NSObject {
  var text = ""
  var checked = false
}

/*
 NSObject is the root class in Objective-C. Swift can borrow from it to add additional  functionality to Swift objects.
 
 */
