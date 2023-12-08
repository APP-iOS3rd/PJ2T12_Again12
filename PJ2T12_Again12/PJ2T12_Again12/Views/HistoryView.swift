//
//  HistoryView.swift
//  PJ2T12_Again12
//
//  Created by GUK on 2023/12/07.
//

// >> 똥싼 코드

import SwiftUI

struct HistoryView: View {
@State private var searchTitle: String = ""
@State private var selectedSegment = 0
    
    struct Itemo: Identifiable {
            var id = UUID()
            var nameodd: String
        }
    
    struct Iteme: Identifiable {
            var id = UUID()
            var nameeven: String
        }
        
    let itemodd: [Itemo] = [
        Itemo(nameodd: "항목 1"),
        Itemo(nameodd: "항목 3"),
        Itemo(nameodd: "항목 5"),
        Itemo(nameodd: "항목 7"),
        Itemo(nameodd: "항목 9"),
        Itemo(nameodd: "항목 11")
    ]
    
    let itemeven: [Iteme] = [
        Iteme(nameeven: "항목 2"),
        Iteme(nameeven: "항목 4"),
        Iteme(nameeven: "항목 6"),
        Iteme(nameeven: "항목 8"),
        Iteme(nameeven: "항목 10"),
        Iteme(nameeven: "항목 12")
    ]
    
//    var toDoList: [Todo] = [
//            Todo(date: Date(), title: "일찍일어나기", image: "airplane", review: "했다", status: true),
//            Todo(date: Date(), title: "크리스마스 쿠키 만들기", review: "", status: false),
//            Todo(date: Date(), title: "열심히 공부하기", review: "", status: false)
//    ]
//
//    var haveToList: [WantTodo] = [
//        WantTodo(date: Date(), title: "네트워크 공부", review: "", status: false),
//        WantTodo(date: Date(), title: "수업 복습", image: "airplane", review: "무진장 많았는데 결국 난 해냈다", status: true),
//        WantTodo(date: Date(), title: "수영하기", image: "airplane", review: "드디어 신청", status: true)
//    ]
    
//    let todoList: [Todo]
//    let haveToList: [WantTodo]
    
    var body: some View {
        VStack {
            VStack {
                Text("전체 일정 보기")
                    .font(.title)
                    .bold()
                    .padding()
                
                Picker("Select Segment", selection: $selectedSegment) {
                    Text("해야 하는 일").tag(0)
                    Text("하고 싶은 일").tag(1)
                }
                .pickerStyle(SegmentedPickerStyle())
                .padding()
            }
            
            NavigationView {
                if selectedSegment == 0 {
                    List(itemodd) { item in
                        Text(item.nameodd)
                    }
                    .searchable(text: $searchTitle)
                } else {
                    List(itemeven) { item in
                        Text(item.nameeven)
                    }
                    .searchable(text: $searchTitle)
                }
//                ListContent(items: toDoList.map { $0 as ListItem } + haveToList.map { $0 as ListItem })
            }
        }
    }
}

//struct ListContent<T: ListItem> : View {
//    let items: [T]
//
//    var body: some View {
//        List(items) { item in
//            Text(item.title)
//        }
//    }
//}
//
//protocol ListItem: Identifiable {
//    var title: String { get }
//}
//
//extension Todo: ListItem {}
//extension WantTodo: ListItem {}

#Preview {
    HistoryView()
}
