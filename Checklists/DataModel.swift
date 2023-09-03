//
//  DataModel.swift
//  Checklists
//
//  Created by Grey on 9/2/23.
//

import Foundation

class DataModel {
    
  var lists = [Checklist]()
  
    
    init() {
      loadChecklists()
      //Note: we are calling this function to tell the app what the defaults should be at startup. (and avoid a crash with conflicting values)
      registerDefaults()
      //Calling this function handles the first time experience logic.
        handleFirstTime()
    }
    
    
    func documentsDirectory() -> URL {
        
      let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        
      return paths[0]
    }

    
    func dataFilePath() -> URL {
      return documentsDirectory().appendingPathComponent("Checklists.plist")
    }

  
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

   
    func loadChecklists() {
        
      let path = dataFilePath()
      if let data = try? Data(contentsOf: path) {
          
        let decoder = PropertyListDecoder()
          
        do {
          // You decode to an object of [Checklist] type to lists
          lists = try decoder.decode([Checklist].self, from: data)
            
        } catch {
          print("Error decoding list array: \(error.localizedDescription)")
        }
      }
    }
    
    /*
    We are setting a default to our opening page view in order to avoid a crash when no default user behaviors are recorded.
        For this we are using the dictionary again.
     */
     
    /*
    func registerDefaults() {
      let dictionary = [ "ChecklistIndex": -1 ]
      UserDefaults.standard.register(defaults: dictionary)
    }
    */
    
    
    
    //Changing this function in order to use add a "first time experiencet."
    func registerDefaults() {
        
      let dictionary = ["ChecklistIndex": -1, "FirstTime": true] as        [String: Any]
      UserDefaults.standard.register(defaults: dictionary)
    }
    
    
    
    
    //MARK: Computed Property
    
    //... This style is new.. var typing a function??
    
    /*
     "This is an example of a computed property," the book responds;
     
     "There isn’t any storage allocated for this property — so it’s not really a variable. Instead, when the app tries to read the value of indexOfSelectedChecklist, the code in the get block is performed. And when the app tries to put a new value into indexOfSelectedChecklist, the set block is performed.
     From now on, you can simply use indexOfSelectedChecklist and it will automatically update UserDefaults. How cool is that?"
     
     */
    
    var indexOfSelectedChecklist: Int {
      get {
        return UserDefaults.standard.integer(
          forKey: "ChecklistIndex")
    } set {
        UserDefaults.standard.set(
          newValue,
          forKey: "ChecklistIndex")
        }
        
    }
    
    //Checking for user default values, if true then the first time experience runs its defaults instead of user collected defaults.
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
    
    
}
