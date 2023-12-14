////
////  User.swift
////  PJ2T12_Again12
////
////  Created by KHJ on 2023/12/07.
////

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
    var todoList: [FriendsTodo]
    var wantTodoList: [WantTodo]
}

struct FriendsTodo: Identifiable {
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

struct Medal: Hashable {
    var title: String
    var image: String
    var status: Bool
    var count: Int
}

//struct ViewMonth: Identifiable {
//        let id = UUID()
//        let date: String
//        let done: Int
//        let undone: Int
//}

struct TodoOverView: Identifiable {
    let id =  UUID()
    let date: Int
    let done: Int
    let undone: Int
}

struct DataType {
    var doType: String
    var data: [TodoOverView]
}
//
extension TodoOverView {
        static let wantTodoMonth: [TodoOverView] = [
            .init(date: 1, done: 1, undone: 2),
            .init(date: 2, done: 1, undone: 2),
            .init(date: 3, done: 1, undone: 2),
            .init(date: 4, done: 1, undone: 2),
            .init(date: 5, done: 2, undone: 1),
            .init(date: 6, done: 2, undone: 1),
            .init(date: 7, done: 1, undone: 2),
            .init(date: 8, done: 1, undone: 2),
            .init(date: 9, done: 1, undone: 2),
            .init(date: 11, done: 1, undone: 2),
            .init(date: 12, done: 3, undone: 0)
        ]
        
        static let todoMonth: [TodoOverView] = [
            .init(date: 1, done: 3, undone: 0),
            .init(date: 2, done: 3, undone: 0),
            .init(date: 3, done: 1, undone: 2),
            .init(date: 4, done: 1, undone: 2),
            .init(date: 5, done: 1, undone: 2),
            .init(date: 6, done: 1, undone: 2),
            .init(date: 7, done: 1, undone: 2),
            .init(date: 8, done: 1, undone: 2),
            .init(date: 9, done: 1, undone: 2),
            .init(date: 10, done: 1, undone: 2),
            .init(date: 11, done: 2, undone: 1)
        ]

    }

var sampleUser: User = User(
    name: "양주원",
    profileImage: "person",
    todoByMonthList: [TodoByMonth(date: Date.now, todoList: toDoList, wantTodoList: haveToList)],
    friendList: nil,
    medalList: [Medal(title: "한 달 달성", image: "star.fill", status: false, count: 0)]
)

var toDoOne = FriendsTodo(date: Date.now, title: "일찍일어나기", image: "airplane", review: "했다", status: true)
var toDoTwo = FriendsTodo(date: Date.now, title: "크리스마스 쿠키 만들기", review: "", status: false)
var toDoThree = FriendsTodo(date: Date.now, title: "열심히 공부하기", review: "", status: false)
var haveToOne = WantTodo(date: Date.now, title: "네트워크 공부", review: "", status: false)
var haveToTow = WantTodo(date: Date.now, title: "수업 복습", image: "airplane", review: "무진장 많았는데 결국 난 해냈다", status: true)
var haveToThree = WantTodo(date: Date.now, title: "수영하기", image: "airplane", review: "드디어 신청", status: true)

var toDoList: [FriendsTodo] = [toDoOne, toDoTwo, toDoThree]
var haveToList: [WantTodo] = [haveToOne, haveToTow, haveToThree]
