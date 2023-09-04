//
//  Checklistitem.swift
//  Checklists
//
//  Created by Grey on 8/23/23.
//

import Foundation
import UserNotifications


 class ChecklistItem: NSObject, Codable{
  var text = ""
  var checked = false
  var dueDate = Date()
  var shouldRemind = false
  var itemID = -1
     
 //A way to ask for new item ID at start.
     override init() {
         
         super.init()
         
         itemID = DataModel.nextChecklistItemID()
         
     }
     
     func scheduleNotification() {
       if shouldRemind && dueDate > Date() {
           // 1
               let content = UNMutableNotificationContent()
               content.title = "Reminder:"
               content.body = text
               content.sound = UNNotificationSound.default
           // 2
               let calendar = Calendar(identifier: .gregorian)
               let components = calendar.dateComponents(
                 [.year, .month, .day, .hour, .minute],
                 from: dueDate)
           // 3
               let trigger = UNCalendarNotificationTrigger(
                 dateMatching: components,
                 repeats: false)
           // 4
               let request = UNNotificationRequest(
                 identifier: "\(itemID)",
                 content: content,
                 trigger: trigger)
             // 5
                 let center = UNUserNotificationCenter.current()
                 center.add(request)
                 print("Scheduled: \(request) for itemID: \(itemID)")
               }
     }
}

