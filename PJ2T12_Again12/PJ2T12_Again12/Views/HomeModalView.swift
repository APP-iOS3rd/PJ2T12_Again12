//
//  HomeModalView.swift
//  PJ2T12_Again12
//
//  Created by Eunsu JEONG on 12/11/23.
//

import SwiftUI

struct HomeModalView: View {
    @ObservedObject var homeVM: HomeViewModel
    @Binding var shown: Bool //for real usage
    @Binding var title: String //for real usage
//    @State var shown: Bool = true //for test
//    @State var title: String = "해야 하는 투두" //for test
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
                            homeVM.selectedImage = image
                        } label: {
                            ZStack {
                                if homeVM.selectedImage == image {
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
                
                TextField("", text: $homeVM.todo)
                    .background(.white)
                    .textFieldStyle(.roundedBorder)
                    .padding(.horizontal)
                    .shadow(radius: 1, x: 1, y: 1)
                
                Spacer()
                
                Divider()
                
                HStack {
                    Button {
                        homeVM.todo = ""
                        homeVM.selectedImage = ""
                        shown = false
                    } label: {
                        Text("취소")
                            .frame(width: UIScreen.main.bounds.width / 2 - 40)
                    }
                    .padding(.bottom, 5)
                    
                    Divider()
                        .frame(height: 45)
                    
                    Button {
                        shown = false
                    } label: {
                        Text("저장")
                            .frame(width: UIScreen.main.bounds.width / 2 - 40)
                    }
                }
            }
            .frame(width: UIScreen.main.bounds.width - 50, height: 300)
            .background(.white)
            .clipShape(RoundedRectangle(cornerRadius: 10))
        }
        .frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)
        .background(.ultraThinMaterial)
    }
}

//#Preview {
//    HomeModalView()
//}
