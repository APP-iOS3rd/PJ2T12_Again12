//
//  DataController.swift
//  PJ2T12_Again12
//
//  Created by KHJ on 2023/12/11.
//

import CoreData
import Foundation

class DataController: ObservableObject {
    let container = NSPersistentContainer(name: "Todori")
    init() {
        container.loadPersistentStores { description, error in
            if let error = error {
                print("Failed to load persistent store")
                return
            }
            
        }
    }
}
