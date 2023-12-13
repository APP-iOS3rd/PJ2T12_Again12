//
//  User.swift
//  PJ2T12_Again12
//
//  Created by KHJ on 2023/12/07.
//

import Foundation

struct User: Identifiable {
    let id = UUID()
    let name: String?
    var profileImage: String?
    var todoByMonthList: [TodoByMonth]
    var friendList: [User]?
    var medalList: [Medal]
}

struct TodoByMonth {
    let date: Date
    var todoList: [Todo]
    var wantTodoList: [WantTodo]
}

struct Todo: Identifiable {
    let id = UUID()
    let date: Date
    var title: String
    var image: String?
    var review: String
    var status: Bool
}

struct WantTodo: Identifiable {
    let id = UUID()
    let date: Date
    var title: String
    var image: String?
    var review: String
    var status: Bool
}

struct Medal {
    var title: String
    var image: String
    var status: Bool
    var count: Int
}

struct ViewMonth: Identifiable {
        let id = UUID()
        let date: String
        let done: Int
        let undone: Int
    }
    
extension ViewMonth {
        static let wantTodoMonth: [ViewMonth] = [
            .init(date: "1월", done: 1, undone: 2),
            .init(date: "2월", done: 1, undone: 2),
            .init(date: "3월", done: 1, undone: 2),
            .init(date: "4월", done: 1, undone: 2),
            .init(date: "5월", done: 2, undone: 1),
            .init(date: "6월", done: 2, undone: 1),
            .init(date: "7월", done: 1, undone: 2),
            .init(date: "8월", done: 1, undone: 2),
            .init(date: "9월", done: 1, undone: 2),
            .init(date: "10월", done: 1, undone: 2),
            .init(date: "11월", done: 3, undone: 0)
        ]
        
        static let todoMonth: [ViewMonth] = [
            .init(date: "1월", done: 3, undone: 0),
            .init(date: "2월", done: 3, undone: 0),
            .init(date: "3월", done: 1, undone: 2),
            .init(date: "4월", done: 1, undone: 2),
            .init(date: "5월", done: 1, undone: 2),
            .init(date: "6월", done: 1, undone: 2),
            .init(date: "7월", done: 1, undone: 2),
            .init(date: "8월", done: 1, undone: 2),
            .init(date: "9월", done: 1, undone: 2),
            .init(date: "10월", done: 1, undone: 2),
            .init(date: "11월", done: 2, undone: 1)
        ]

    }

var sampleUser: User = User(
    name: "양주원",
    profileImage: "person",
    todoByMonthList: [TodoByMonth(date: Date.now, todoList: toDoList, wantTodoList: haveToList)],
    friendList: nil,
    medalList: [Medal(title: "한 달 달성", image: "star.fill", status: false, count: 0)]
)

var toDoOne = Todo(date: Date.now, title: "일찍일어나기", image: "airplane", review: "했다", status: true)
var toDoTwo = Todo(date: Date.now, title: "크리스마스 쿠키 만들기", review: "", status: false)
var toDoThree = Todo(date: Date.now, title: "열심히 공부하기", review: "", status: false)
var haveToOne = WantTodo(date: Date.now, title: "네트워크 공부", review: "", status: false)
var haveToTow = WantTodo(date: Date.now, title: "수업 복습", image: "airplane", review: "무진장 많았는데 결국 난 해냈다", status: true)
var haveToThree = WantTodo(date: Date.now, title: "수영하기", image: "airplane", review: "드디어 신청", status: true)

var toDoList: [Todo] = [toDoOne, toDoTwo, toDoThree]
var haveToList: [WantTodo] = [haveToOne, haveToTow, haveToThree]
