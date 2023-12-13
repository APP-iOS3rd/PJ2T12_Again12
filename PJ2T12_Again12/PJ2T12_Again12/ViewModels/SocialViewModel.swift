//
//  SocialViewModel.swift
//  PJ2T12_Again12
//
//  Created by Eunsu JEONG on 12/12/23.
//

import SwiftUI

@MainActor
class SocialViewModel: ObservableObject {
    @Published var isLogin = false
    @Published var myFriendsList: [User] = [SampleUsers().userOne, SampleUsers().userTwo, SampleUsers().userThree, SampleUsers().userFour]
    
    func setDateFormat(_ date: Date) -> String {
        let year = date.formatted(Date.FormatStyle().year(.defaultDigits))
        let month = date.formatted(Date.FormatStyle().month(.twoDigits))
        
        return "\(year).\(month)"
    }
    
    ///어떤 유저의 가장 최신의 TodoByMonth 데이터가 이번 달인지 판별한다.
    func isThisMonth(_ user: User) -> Bool {
        var isThisMonth = false
        
        if let recentTodoDate = user.todoByMonthList.last?.date {
            if setDateFormat(recentTodoDate) == setDateFormat(Date.now) {
                isThisMonth = true
            }}
        return isThisMonth
    }
    
    ///어떤 유저가 TodoByMonth 데이터가 있다면 가장 최신 데이터인 todoList를 가지고 온다.
    func getTodoList(_ user: User) -> [Todo] {
        var result: [Todo] = []
        
        if let todoList = user.todoByMonthList.last?.todoList {
            result = todoList
        }
        
        return result
    }
    
    ///어떤 유저가 TodoByMonth 데이터가 있다면 가장 최신 데이터인 wantTodoList를 가지고 온다.
    func getWantTodoList(_ user: User) -> [WantTodo] {
        var result: [WantTodo] = []
        
        if let wantTodoList = user.todoByMonthList.last?.wantTodoList {
            result = wantTodoList
        }
        
        return result
    }
    
    func countDone(_ user: User) -> Int {
        var count = 0
        
        if isThisMonth(user) {
            let totalTodo = getTodoList(user)
            let totalWantTodo = getWantTodoList(user)
            
            for todo in totalTodo {
                if todo.status {
                    count += 1
                }
            }
            
            for wantTodo in totalWantTodo {
                if wantTodo.status {
                    count += 1
                }
            }
        }
        
        return count
    }
    
    func countTotal(_ user: User) -> Int {
        var totalCount = 0
        
        if isThisMonth(user) {
            totalCount = getTodoList(user).count + getWantTodoList(user).count
        }
        
        return totalCount
    }
}

struct SampleTodo {
    var toDoOne = Todo(date: Date.now, title: "일찍일어나기", image: "dumbbell", review: "했다", status: true)
    var toDoTwo = Todo(date: Date.now, title: "크리스마스 쿠키 만들기", image: "paperplane", review: "", status: false)
    var toDoThree = Todo(date: Date.now, title: "열심히 공부하기", image:"book.closed", review: "", status: false)
}

struct SampleWantTodo {
    var wantTodoOne = WantTodo(date: Date.now, title: "네트워크 공부", image: "paperplane", review: "", status: false)
    var wantTodoTow = WantTodo(date: Date.now, title: "수업 복습", image: "paperplane", review: "무진장 많았는데 결국 난 해냈다", status: true)
    var wantTodoThree = WantTodo(date: Date.now, title: "수영하기", image: "dumbbell", review: "드디어 신청", status: true)
}

struct SampleMedal {
    var medalOne = Medal(title: "일 년 달성", image: "star", status: false, count: 0)
    var medalTwo = Medal(title: "한 달 달성", image: "star.fill", status: true, count: 0)
    var medalThree = Medal(title: "하고 싶은 투두 10개 달성", image: "moon.stars.fill", status: true, count: 0)
    var medalFour = Medal(title: "해야 하는 투두 10개 달성", image: "moon.stars", status: false, count: 0)
}

struct SampleUsers {
    var userOne: User = User(
        name: "친구1",
        profileImage: "cat",
        todoByMonthList: [TodoByMonth(date: Date.now,
                                      todoList: [SampleTodo().toDoOne, SampleTodo().toDoThree],
                                      wantTodoList: [SampleWantTodo().wantTodoOne]
                                     )],
        friendList: nil,
        medalList: [SampleMedal().medalOne, SampleMedal().medalTwo]
    )
    
    var userTwo: User = User(
        name: "친구2",
        profileImage: "lizard",
        todoByMonthList: [TodoByMonth(date: Date.now,
                                      todoList: [SampleTodo().toDoOne, SampleTodo().toDoTwo],
                                      wantTodoList: [SampleWantTodo().wantTodoOne, SampleWantTodo().wantTodoThree]
                                     )],
        friendList: nil,
        medalList: [SampleMedal().medalOne, SampleMedal().medalFour]
    )
    
    var userThree: User = User(
        name: "친구3",
        profileImage: "tortoise",
        todoByMonthList: [TodoByMonth(date: Date.now,
                                      todoList: [SampleTodo().toDoOne, SampleTodo().toDoTwo, SampleTodo().toDoThree],
                                      wantTodoList: [SampleWantTodo().wantTodoThree, SampleWantTodo().wantTodoTow]
                                     )],
        friendList: nil,
        medalList: [SampleMedal().medalTwo, SampleMedal().medalFour, SampleMedal().medalThree]
    )
    
    var userFour: User = User(
        name: "친구4",
        profileImage: "teddybear",
        todoByMonthList: [TodoByMonth(date: Calendar.current.date(from: DateComponents(year: 2023, month: 08, day: 30))!,
                                      todoList: [SampleTodo().toDoOne, SampleTodo().toDoThree],
                                      wantTodoList: [SampleWantTodo().wantTodoOne]
                                     )],
        friendList: nil,
        medalList: [SampleMedal().medalOne, SampleMedal().medalTwo]
    )
}
