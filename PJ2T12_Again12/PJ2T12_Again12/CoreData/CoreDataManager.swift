//
//  CoreDataManager.swift
//  PJ2T12_Again12
//
//  Created by KHJ on 2023/12/18.
//

import CoreData
import Foundation

class CoreDataManager {
    static let shared = CoreDataManager()
    let persistentContainer: NSPersistentContainer
    
    var viewContext: NSManagedObjectContext {
        return persistentContainer.viewContext
    }
    
    private init() {
        persistentContainer = NSPersistentContainer(name: "Todori")
        
        persistentContainer.loadPersistentStores { description, error in
            if let error = error {
                fatalError("Unable to initialize CoreData \(error)")
            }
        }
    }
    func saveContext() {
        do {
            try viewContext.save()
        } catch {
            viewContext.rollback()
            print("Failed to save view context \(error)")
        }
    }
}

// MARK: - Todo

extension CoreDataManager {
        
    func getTodoList() -> [Todo] {
        let request = NSFetchRequest<Todo>(entityName: "Todo")
        request.sortDescriptors = [NSSortDescriptor(key: "date", ascending: true)]
        request.predicate =   NSPredicate(format: "isTodo == true AND date >= %@ AND date <= %@", Calendar.current.startOfMonth(for: Date.now) as CVarArg, Calendar.current.endOfMonth(for: Date.now) as CVarArg)
        
        do {
            return try viewContext.fetch(request)
        } catch {
            return []
        }
    }
    
    func getWantTodoList() -> [Todo] {
        let request = NSFetchRequest<Todo>(entityName: "Todo")
        request.sortDescriptors = [NSSortDescriptor(key: "date", ascending: true)]
        request.predicate =  NSPredicate(format: "isTodo == false AND date >= %@ AND date <= %@", Calendar.current.startOfMonth(for: Date.now) as CVarArg, Calendar.current.endOfMonth(for: Date.now) as CVarArg)
        
        do {
            return try viewContext.fetch(request)
        } catch {
            return []
        }
    }
    
    func getTodoById(_ id: UUID) -> Todo? {
        let request = NSFetchRequest<Todo>(entityName: "Todo")
        request.fetchLimit = 1
        request.predicate = NSPredicate(format: "id == %@", id as CVarArg)
        
        do {
            return try viewContext.fetch(request).first
        } catch {
            return nil
        }
    }
    
    func addTodo(title: String, image: String, isTodo: Bool) {
        let todo = Todo(context: viewContext)
        todo.title = title
        todo.date = Date.now // 제목 수정시 날짜 덮어씌워짐
        todo.isTodo = isTodo
        todo.review = ""
        todo.status = false
        todo.image = image
        todo.isSaved = false
        todo.id = UUID()
        todo.reviewImage = nil
        
        saveContext()
    }
    
    func deleteTodo(todo: Todo) {
        viewContext.delete(todo)
        
        saveContext()
    }
}

