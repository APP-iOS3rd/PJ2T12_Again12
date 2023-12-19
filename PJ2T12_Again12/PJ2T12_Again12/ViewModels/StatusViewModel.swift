//
//  StatusViewModel.swift
//  PJ2T12_Again12
//
//  Created by KHJ on 2023/12/19.
//

import Foundation

class StatusViewModel: ObservableObject {
    @Published var todoList: [Todo] = []
    @Published var wantTodoList: [Todo] = []
    @Published var chartData: [DataType] = [
        DataType(doType: "해야하면", data: TodoOverView.todoMonth),
        DataType(doType: "하고싶으면", data: TodoOverView.wantTodoMonth)
    ]
    
    init() {
        getAllTodoList()
        // 더미데이터로 테스트하고 싶을 시 아래 두 라인을 주석처리 해주세요.
        groupTodoByMonth(todoList: todoList, index: 0)
        groupTodoByMonth(todoList: wantTodoList, index: 1)
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
    
    func groupTodoByMonth(todoList: [Todo], index: Int) {
        // 투두리스트를 월별로 분리
        let groupdByMonth = Dictionary(grouping: todoList) { todo in
            return Calendar.current.component(.month, from: todo.wrappedDate)
        }
        
        // 차트에서 사용할 타입(TodoOverView)으로 변환
        var todoOverViews: [TodoOverView] = []
        for (month, todos) in groupdByMonth {
            let doneCount = todos.filter { $0.status == true }.count
            let undoneCount = todos.filter { $0.status == false }.count
            let todoOverView = TodoOverView(date: month, done: doneCount, undone: undoneCount)
            todoOverViews.append(todoOverView)
        }
        
        // [DataType] 배열의 인덱스, 0은 투두, 1은 원투두
        let type = (index == 0) ? "Todo" : "WantTodo"
        
        // 날짜순으로 정렬
        chartData[index].data = todoOverViews.sorted { $0.date < $1.date }
        
        // 디버그용 프린트
        for todoOverView in todoOverViews {
            print("[\(type)] Month: \(todoOverView.date), Done: \(todoOverView.done), Undone: \(todoOverView.undone)")
        }
    }

}
