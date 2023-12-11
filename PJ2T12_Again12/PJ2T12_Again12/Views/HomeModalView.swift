//
//  HomeModalView.swift
//  PJ2T12_Again12
//
//  Created by Eunsu JEONG on 12/11/23.
//

import SwiftUI

struct HomeModalView: View {
    @StateObject private var homeVM = HomeViewModel()
    @State private var todoTemp: String = ""
    private var circleSize: CGFloat = 60
    private var imageSize: CGFloat = 30
    
    var body: some View {
        VStack {
            HStack {
                ForEach(homeVM.images, id: \.self) { image in
                    ZStack {
                        Circle()
                            .frame(width: circleSize, height: circleSize)
                            .foregroundStyle(.blue)
                        Image(systemName: image)
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: imageSize, height: imageSize)
                    }
                }
            }
            .padding(.top, 25)
            
            TextField("", text: $todoTemp)
                .background(.white)
                .textFieldStyle(.roundedBorder)
                .padding()
            
            Spacer()
            Divider()
            
            HStack {
                Button("취소", action: {
                    todoTemp = ""
                    homeVM.showingModalAlert = false
                })
                .frame(width: UIScreen.main.bounds.width / 2 - 40)
                
                Divider()
                    .frame(height: 40)
                
                Button("저장", action: {
                    homeVM.todo = todoTemp
                    todoTemp = ""
                    homeVM.showingModalAlert = false
                })
                .frame(width: UIScreen.main.bounds.width / 2 - 40)
            }
        }
        .frame(width: UIScreen.main.bounds.width - 50, height: 220)
        .background(.gray)
        .clipShape(RoundedRectangle(cornerRadius: 10))
    }
}

#Preview {
    HomeModalView()
}
