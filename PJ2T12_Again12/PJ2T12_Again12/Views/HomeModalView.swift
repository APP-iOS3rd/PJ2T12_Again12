//
//  HomeModalView.swift
//  PJ2T12_Again12
//
//  Created by Eunsu JEONG on 12/11/23.
//

import SwiftUI

struct HomeModalView: View {
    @State private var todoTemp: String = ""
    @State private var todo: String = ""
    
    var body: some View {
        VStack {
            HStack {
                
            }
            TextField("", text: $todoTemp)
            HStack {
                Button("취소", action: {
                    todoTemp = ""
//                    print("todo: \(todo), todoTemp:\(todoTemp)")
                })
                Button("저장", action: {
                    todo = todoTemp
                    todoTemp = ""
//                    print("todo: \(todo), todoTemp:\(todoTemp)")
                })
            }
        }
    }
}

//#Preview {
//    HomeModalView()
//}
