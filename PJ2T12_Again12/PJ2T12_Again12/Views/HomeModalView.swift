//
//  HomeModalView.swift
//  PJ2T12_Again12
//
//  Created by Eunsu JEONG on 12/11/23.
//

import SwiftUI

struct HomeModalView: View {
    @Binding var todo: String
    
    var body: some View {
        TextField(todo, text: $todo)
        Button("OK", action: {})
    }
}

//#Preview {
//    HomeModalView()
//}
