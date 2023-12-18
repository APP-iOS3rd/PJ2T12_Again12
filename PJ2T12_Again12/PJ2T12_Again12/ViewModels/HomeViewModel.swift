//
//  HomeViewModel.swift
//  PJ2T12_Again12
//
//  Created by KHJ on 2023/12/08.
//

import Foundation
import SwiftUI

@MainActor
class HomeViewModel: ObservableObject {
    @Published var showingAlert = false
    @Published var showingModalAlert = false
    @Published var title = ""
    @Published var images: [String] = ["paperplane", "book.closed", "moon", "dumbbell"]
    @Published var selectedImage = "paperplane"
    @Published var isTodo = false
    @Published var selectedTodoId: UUID = UUID()
    
    @Published var todoList: [Todo] = []
    @Published var wantTodoList: [Todo] = []
    @Published var selectedTodo: Todo?
    init() {
        getAllTodoList()
    }
    func getAllTodoList() {
        getTodoList()
        getWantTodoList()
    }
    
    func getTodoList() {
        todoList = CoreDataManager.shared.getTodoList()
    }
    
    func getWantTodoList() {
        wantTodoList = CoreDataManager.shared.getWantTodoList()
    }
    
    func getTodoById(_ id: UUID) -> Todo? {
        return CoreDataManager.shared.getTodoById(id)
    }
    
    func addTodo(title: String, image: String, isTodo: Bool) {
        CoreDataManager.shared.addTodo(title: title, image: image, isTodo: isTodo)
        getAllTodoList()
    }
    
    func updateTodo() {
        CoreDataManager.shared.saveContext()
        getAllTodoList()
    }
    
    func deleteTodo(todo: Todo) {
        CoreDataManager.shared.deleteTodo(todo: todo)
        getAllTodoList()
    }
    func updateViewModel(with todo: Todo) {
        title = todo.wrappedTitle
        selectedImage = todo.wrappedImage
    }
}
