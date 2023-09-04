//
//  DataModel.swift
//  Checklists
//
//  Created by Grey on 9/2/23.
//

import Foundation

class DataModel {
    
  var lists = [Checklist]()

    var indexOfSelectedChecklist: Int {
    get {
      return UserDefaults.standard.integer(forKey: "ChecklistIndex")
    }
    set {
      UserDefaults.standard.set(newValue, forKey: "ChecklistIndex")
    }
  }

  init() {
    loadChecklists()
    registerDefaults()
    //Calling this function sets up the defaults for first time use.
    handleFirstTime()
  }

  func documentsDirectory() -> URL {
      
    let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
      
    return paths[0]
  }

  func dataFilePath() -> URL {
      
    return documentsDirectory().appendingPathComponent("Checklists.plist")
  }

  // this method is now called saveChecklists()
  func saveChecklists() {
      
    let encoder = PropertyListEncoder()
      
    do {
      // You encode lists instead of "items"
      let data = try encoder.encode(lists)
      try data.write(to: dataFilePath(), options: Data.WritingOptions.atomic)
    } catch {
      print("Error encoding list array: \(error.localizedDescription)")
    }
  }

  // this method is now called loadChecklists()
  func loadChecklists() {
      
    let path = dataFilePath()
      
    if let data = try? Data(contentsOf: path) {
      let decoder = PropertyListDecoder()
        
      do {
        // You decode to an object of [Checklist] type to lists
        lists = try decoder.decode([Checklist].self, from: data)
        sortChecklists()
      } catch {
        print("Error decoding list array: \(error.localizedDescription)")
      }
    }
  }

  func registerDefaults() {
      
    let dictionary = [ "ChecklistIndex": -1, "FirstTime": true ] as [String: Any]
    UserDefaults.standard.register(defaults: dictionary)
  }

  func handleFirstTime() {
      
    let userDefaults = UserDefaults.standard
    let firstTime = userDefaults.bool(forKey: "FirstTime")

    if firstTime {
        
      let checklist = Checklist(name: "List")
      lists.append(checklist)

      indexOfSelectedChecklist = 0
      userDefaults.set(false, forKey: "FirstTime")
    }
  }

  func sortChecklists() {
      
    lists.sort { list1, list2 in
      return list1.name.localizedStandardCompare(list2.name) == .orderedAscending
    }
  }
 
    /*
     The class keyword before the method indicates a Class Method.
     
     The book says," ...this kind of method applies to the class as a whole. ...the word func — without class, works " only on a specific instance of that class."
     
     And then goes on to say, "For now, just remember that a method starting with class func allows you to call methods on an object even when you don’t have a reference to that object."
     
     Is this a sneaky way of getting around scopes??
     
     */
    
    class func nextChecklistItemID() -> Int {
        
      let userDefaults = UserDefaults.standard
      let itemID = userDefaults.integer(forKey: "ChecklistItemID")
      userDefaults.set(itemID + 1, forKey: "ChecklistItemID")
      
        return itemID
    }
    
    
}



