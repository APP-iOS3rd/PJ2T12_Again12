//
//  StatusView.swift
//  PJ2T12_Again12
//
//  Created by KHJ on 2023/12/07.
//

import SwiftUI
import Charts

struct StatusView: View {
    struct ToyShape: Identifiable {
        var month: [String] = ["1월", "2월", "3월", "4월", "5월", "6월", "7월", "8월", "9월", "10월", "11월", "12월"]
        var color: String
        var count: Double
        var id = UUID()
    }
    //목록을 1부터 1000까지 만듬
    let data = Array(1...1000).map { "목록 \($0)"}
    
    //화면을 그리드형식으로 꽉채워줌
    let columns = [
        GridItem(.adaptive(minimum: 100))
    ]
    
    var stackedBarData: [ToyShape] = [
        // count는 높이
        .init(color: "Grey", count: 2),
        .init(color: "Grey", count: 0),
        .init(color: "Grey", count: 1),
        .init(color: "Pink", count: 1),
        .init(color: "Pink", count: 1),
        .init(color: "Pink", count: 1),
        .init(color: "Green", count: 1),
        .init(color: "Green", count: 2),
        .init(color: "Green", count: 0),
        
    ]
    var body: some View {
        VStack {
            Chart {
                ForEach(stackedBarData) { shape in
                    BarMark(
                        x: .value("Shape Type", shape.month[0])
                        ,
                        y: .value("Total Count", shape.count)
                        
                    )
                    .foregroundStyle(by: .value("Shape Color", shape.color))
                }
            }
            .chartForegroundStyleScale([
                "Grey": .gray, "Pink": .pink, "Green": .green
            ])
            Spacer()
                ScrollView {
                    LazyVGrid(columns: columns, spacing: 20) {
                        ForEach(data, id: \.self) {i in
                            Text(i)
                        }
                    }
                    .padding(.horizontal)
                }
            }
        }
    }


#Preview {
    StatusView()
}
