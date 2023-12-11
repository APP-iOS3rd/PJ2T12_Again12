//
//  HomeModalView.swift
//  PJ2T12_Again12
//
//  Created by Eunsu JEONG on 12/11/23.
//

import SwiftUI

struct HomeModalView: View {
    @StateObject private var homeVM = HomeViewModel()
    @Binding var shown: Bool //for real usage
//    @State var shown: Bool = true //for test
    @Binding var title: String
    @State private var todoTemp: String = ""
    @State private var selectedImageTemp = ""
    var circleSize: CGFloat = 60
    var imageSize: CGFloat = 30
    
    var body: some View {
        VStack {
            VStack {
                Text(title)
                    .font(.system(size: 21, weight: .bold))
                    .padding(.top, 25)
                
                HStack {
                    ForEach(homeVM.images, id: \.self) { image in
                        Button {
                            selectedImageTemp = image
                        } label: {
                            ZStack {
                                Circle()
                                    .frame(width: circleSize, height: circleSize)
                                    .foregroundStyle(selectedImageTemp == image ? .yellow : .white)
                                Image(systemName: image)
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                                    .foregroundStyle(.black)
                                    .frame(width: imageSize, height: imageSize)
                            }
                            .padding(.horizontal, 8)
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
                    Button {
                        todoTemp = ""
                        selectedImageTemp = ""
                        shown = false
                    } label: {
                        Text("취소")
                            .frame(width: UIScreen.main.bounds.width / 2 - 40)
                    }
                    
                    Divider()
                        .frame(height: 40)
                    
                    Button {
                        homeVM.todo = todoTemp
                        homeVM.selectedImage = selectedImageTemp
                        todoTemp = ""
                        selectedImageTemp = ""
                        shown = false
                    } label: {
                        Text("저장")
                            .frame(width: UIScreen.main.bounds.width / 2 - 40)
                    }
                }
            }
            .frame(width: UIScreen.main.bounds.width - 50, height: 220)
            .background(.gray)
            .clipShape(RoundedRectangle(cornerRadius: 10))
        }
        .frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)
        .background(.ultraThinMaterial)
    }
}

//#Preview {
//    HomeModalView()
//}
