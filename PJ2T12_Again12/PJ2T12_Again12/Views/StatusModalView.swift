//
//  StatusModalView.swift
//  PJ2T12_Again12
//
//  Created by 양주원 on 12/13/23.
//

import SwiftUI

struct StatusModalView: View {
    
    let firstWantTodoIt = UserDefaults.standard.integer(forKey: "firstWantTodoIt")
    
    var body: some View {
        ZStack {
            Color.BackgroundYellow
                .ignoresSafeArea()
            VStack {
                Text("위대한 계획러")
                if(self.firstWantTodoIt != 0) {
                    Image(systemName: "hare.circle")
                        .frame(width: 90, height: 90)
                        .background(RoundedRectangle(cornerRadius: 10).fill(Color.gray.opacity(0.3)))
                } else {
                    Image(systemName: "hare.circle.fill")
                        .frame(width: 90, height: 90)
                        .background(RoundedRectangle(cornerRadius: 10).fill(Color.gray.opacity(0.3)))
                }
                Text("1년동안 모든 계획을 실행한 유저")
            }
        }
    }
}


struct StatusModalView_Previews: PreviewProvider {
    static var previews: some View {
        StatusView()
    }
}
