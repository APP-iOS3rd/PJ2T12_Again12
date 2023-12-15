//
//  DataController.swift
//  PJ2T12_Again12
//
//  Created by KHJ on 2023/12/11.
//

import CoreData
import Foundation

class DataController: ObservableObject {
    
    static let shared = DataController()
    
    var containerURL: URL {
        return FileManager.default.containerURL(forSecurityApplicationGroupIdentifier: "group.Todori.Widget")!
    }
    
    let container: NSPersistentContainer
    
    // 그런 다음 영구 컨테이너의 저장소 설명에 URL을 설정
    init(inMemory: Bool = false) {
        container = NSPersistentContainer(name: "Todori")
        if inMemory {
            container.persistentStoreDescriptions.first!.url = URL(fileURLWithPath: "/dev/null")
        } else {
            let storeURL = containerURL.appendingPathComponent("Todori.sqlite")
            container.persistentStoreDescriptions.first!.url = storeURL
        }
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        container.viewContext.automaticallyMergesChangesFromParent = true
    }
}
    
//    let container = NSPersistentContainer(name: "Todori")
//    init() {
//        container.loadPersistentStores { description, error in
//            if let error = error {
//                print("Failed to load persistent store")
//                return
//            }
            
//        }
//    }
//}
//
