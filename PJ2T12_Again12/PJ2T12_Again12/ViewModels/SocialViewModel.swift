//
//  SocialViewModel.swift
//  PJ2T12_Again12
//
//  Created by Eunsu JEONG on 12/12/23.
//

import SwiftUI

@MainActor
class SocialViewModel: ObservableObject {
    @Published var isLogin = true
    @Published var myFriendsList: [User] = [SampleUsers().userOne, SampleUsers().userTwo, SampleUsers().userThree]
    
    func setDateFormat(_ date: Date) -> String {
        let year = date.formatted(Date.FormatStyle().year(.defaultDigits))
        let month = date.formatted(Date.FormatStyle().month(.twoDigits))
        
        return "\(year)-\(month)"
    }
    
    func countDone(_ user: User) -> Int {
        let totalTodo = user.todoByMonthList.last?.todoList ?? user.todoByMonthList[0].todoList
        let totalWantTodo = user.todoByMonthList.last?.wantTodoList ?? user.todoByMonthList[0].wantTodoList
        var count = 0
        
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
        
        return count
    }
    
    func countTotal(_ user: User) -> Int {
        var totalCount = 0
        
        if let recentTodoDate = user.todoByMonthList.last?.date {
            if setDateFormat(recentTodoDate) == setDateFormat(Date.now) {
                totalCount = (user.todoByMonthList.last?.todoList.count ?? 0) + (user.todoByMonthList.last?.wantTodoList.count ?? 0)
            }
        }
        
        return totalCount
    }
}

struct SampleTodo {
    var toDoOne = Todo(date: Date.now, title: "일찍일어나기", image: "airplane", review: "했다", status: true)
    var toDoTwo = Todo(date: Date.now, title: "크리스마스 쿠키 만들기", review: "", status: false)
    var toDoThree = Todo(date: Date.now, title: "열심히 공부하기", review: "", status: false)
}

struct SampleWantTodo {
    var wantTodoOne = WantTodo(date: Date.now, title: "네트워크 공부", review: "", status: false)
    var wantTodoTow = WantTodo(date: Date.now, title: "수업 복습", image: "airplane", review: "무진장 많았는데 결국 난 해냈다", status: true)
    var wantTodoThree = WantTodo(date: Date.now, title: "수영하기", image: "airplane", review: "드디어 신청", status: true)
}

struct SampleMedal {
    var medalOne = Medal(title: "일 년 달성", image: "star", status: false, count: 0)
    var medalTwo = Medal(title: "한 달 달성", image: "star.fill", status: true, count: 0)
    var medalThree = Medal(title: "하고 싶은 투두 10개 달성", image: "moon.fill", status: true, count: 0)
    var medalFour = Medal(title: "해야 하는 투두 10개 달성", image: "moon", status: false, count: 0)
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
}
