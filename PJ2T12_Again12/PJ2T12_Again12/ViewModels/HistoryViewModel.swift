//
//  HistoryViewModel.swift
//  PJ2T12_Again12
//
//  Created by KHJ on 2023/12/19.
//

import Foundation

class HistoryViewModel: ObservableObject {
    @Published var searchTitle = ""
    @Published var selectedSegment = 0
    @Published var todoList: [Todo] = []
    @Published var wantTodoList: [Todo] = []
    
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
