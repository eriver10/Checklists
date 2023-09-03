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
     
    func registerDefaults() {
      let dictionary = [ "ChecklistIndex": -1 ]
      UserDefaults.standard.register(defaults: dictionary)
    }
    
}
