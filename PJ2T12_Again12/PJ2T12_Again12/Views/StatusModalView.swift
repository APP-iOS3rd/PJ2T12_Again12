//
//  StatusModalView.swift
//  PJ2T12_Again12
//
//  Created by 양주원 on 12/13/23.
//

import SwiftUI

struct StatusModalView: View {
    
    @Binding var isShowing: Bool
    
    var body: some View {
        if isShowing {
            ZStack(alignment: .bottom){
                Color.black
                    .opacity(0.3)
                    .ignoresSafeArea()
                    .onTapGesture {
                        isShowing = false
                    }
                VStack{
                    Text("hello")
                }
                .frame(height: 300)
                .frame(maxWidth: .infinity)
                .background(Color.white)
                .transition(.move(edge: .bottom))
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .bottom)
            .ignoresSafeArea()
            .animation(.easeInOut)
        }
    }
}

struct StatusModalView_Previews: PreviewProvider {
    static var previews: some View {
        StatusView()
    }
}
