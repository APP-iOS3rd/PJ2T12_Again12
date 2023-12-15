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
    @Binding var begdeSelect: Int
    
    var body: some View {
        ZStack {
            Color.BackgroundYellow
                .ignoresSafeArea()
            VStack {
                Text(bedgeTextArray[begdeSelect][0])
                    .font(.Hel17Bold)
                    .foregroundStyle(.defaultBlack)
                    .padding(.top, 24)
                Image(selectedBadge)
                    .resizable()
                    .scaledToFit()
                Text(bedgeTextArray[begdeSelect][1])
                    .font(.Hel15)
                    .foregroundStyle(.defaultBlack)
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
