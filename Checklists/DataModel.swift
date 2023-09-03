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
    
    
    
}