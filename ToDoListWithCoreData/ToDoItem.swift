//
//  ToDoItem.swift
//  toDoApp
//
//  Created by Takamiya Kengo on 2021/01/07.
//

import Foundation

struct toDoItem :Codable{
    var name:String
    var date:String
  var priority:String

//static var archiveURL: URL {
//    let documentsURL = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
//    let archiveURL = documentsURL.appendingPathComponent("toDoItems").appendingPathExtension("plist")
//return archiveURL
//}
//    static var sampleItems : [[toDoItem]] = [[toDoItem(name: "Take a walk",date: "2021/01/11"), toDoItem(name: "Study Design pattern",date:  "2021/01/22")], [toDoItem(name: "Study iOS",date:  "2021/01/23"), toDoItem(name: "Update Resume",date:  "2021/01/25")], [toDoItem(name: "Watch Netflix",date:  "2021/01/26")]]
//
//
//    static func savetoFile(toDoItems: [[toDoItem]]) {
//        let encoder = PropertyListEncoder()
//        do {
//            let encodedItems = try encoder.encode(toDoItems)
//            try encodedItems.write(to: toDoItem.archiveURL)
//        } catch {
//            print("Error encoding toDoItems: \(error.localizedDescription)")
//        }
//    }
//    static func loadFromFile() -> [[toDoItem]]? {
//        guard let toDoItemData = try? Data(contentsOf: toDoItem.archiveURL) else { return nil }
//        do {
//            let decoder = PropertyListDecoder()
//            let decodedItems = try decoder.decode([[toDoItem]].self,from: toDoItemData)
//            return decodedItems
//        } catch {
//            print("Error decoding toDoItems: \(error)")
//return nil
//        }
//    }
//    
//
}
