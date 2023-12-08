//
//  HistoryView.swift
//  PJ2T12_Again12
//
//  Created by KHJ on 2023/12/07.
//

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
            }
        }
    }
}
#Preview {
    HistoryView()
}
