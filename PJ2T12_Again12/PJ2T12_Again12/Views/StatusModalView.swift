//
//  StatusModalView.swift
//  PJ2T12_Again12
//
//  Created by 양주원 on 12/13/23.
//

import SwiftUI

struct StatusModalView: View {
    
    let firstWantTodoIt = UserDefaults.standard.integer(forKey: "firstWantTodoIt")
    @Binding var selectedBadge: String
    var body: some View {
        ZStack {
            Color.BackgroundYellow
                .ignoresSafeArea()
            VStack {
                Text("천 리 길도 한 걸음부터")
                    .font(.title3.bold())
                    .padding(.top, 24)
                Image(selectedBadge)
                    .resizable()
                    .scaledToFit()
                Text("첫 번째 해야 하면 투두를 달성하여 뱃지를 획득해 보세요!")
                    .multilineTextAlignment(.center)
                    .padding(.top, 8)
            }
            .padding(8)
        }
    }
}

struct StatusModalView_Previews: PreviewProvider {
    static var previews: some View {
        StatusView()
    }
}
