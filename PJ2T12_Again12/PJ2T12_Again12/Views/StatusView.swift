//
//  StatusView.swift
//  PJ2T12_Again12
//
//  Created by KHJ on 2023/12/07.
//
import Foundation
import SwiftUI
import Charts

struct StatusView: View {
    let Data = [
        (doType: "todo", data: ViewMonth.todoMonth),
        (doType: "wantTodo", data: ViewMonth.wantTodoMonth),
    ]

    let columns = [
            GridItem(.flexible()),
            GridItem(.flexible()),
            GridItem(.flexible())
        ]
    
    var body: some View {
        VStack {
            Text("목표 달성도")
                .font(.largeTitle)
                .bold()
            
                    Chart {
                        ForEach(Data, id: \.doType) { element in
                            ForEach(element.data, id: \.date) {
                                
                                BarMark(x: .value("Month", $0.date),
                                        y: .value("Count", $0.count))
                                .foregroundStyle(.blue)
                                if element.doType == "todo" {
                                    BarMark(x: .value("Month", $0.date),
                                            y: .value("Count", $0.count - 2))
                                    .foregroundStyle(.gray)
                                }
                                
                            }
                        
                            .position(by: .value("doType", element.doType))
                            
                        }
                    }
//                    .chartForegroundStyleScale([
//                        "todo": .pink,
//                        "wantTodo": .blue,
//                        "notdo": .gray
//                    ])
                }
                
            
        
            
            LazyVGrid(columns: columns, spacing: 20) {
                ForEach(0..<6) { index in
                    Text("Cell \(index)")
                        .font(.system(size: 20))
                        .frame(width: 100, height: 100)
                        .background(Color.gray)
                }
            }
            .padding()
        }
    }


#Preview {
    StatusView()
}

//.chartForegroundStyleScale([
//    "todo": .pink,
//    "wantTodo": .blue
//    "notdo": .gray
//])
