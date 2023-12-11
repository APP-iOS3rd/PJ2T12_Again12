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
                                if selectedImageTemp == image {
                                    Circle()
                                        .frame(width: circleSize, height: circleSize)
                                        .foregroundStyle(.yellow)
                                        .shadow(radius: 8, x: 5, y: 5)
                                } else {
                                    Circle()
                                        .stroke(.black, lineWidth: 1.5)
                                        .frame(width: circleSize, height: circleSize)
                                        .foregroundStyle(.white)
                                }
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
                HStack {
                    Text("어떤 투두를 하고 싶은가요?")
                        .font(.system(size: 15, weight: .medium))
                    
                    Spacer()
                }
                .padding(.top)
                .padding(.horizontal)
                
                TextField("", text: $todoTemp)
                    .background(.white)
                    .textFieldStyle(.roundedBorder)
                    .padding(.horizontal)
                
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
