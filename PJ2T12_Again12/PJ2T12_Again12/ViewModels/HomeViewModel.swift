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
    @Published var isTodo = false
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
}
