//
//  EditView.swift
//  PJ2T12_Again12
//
//  Created by kwon ji won on 12/8/23.
//

import SwiftUI
import Foundation

struct EditView: View {
    @State private var openPhoto = false
    @State private var image = UIImage()
    @State private var userText: String = ""
    
    var body: some View {
        NavigationView {
            VStack {
                HStack(spacing: 20) {
                    Image(systemName: "airplane")
                        .font(.title2)
                    Text("아침 일찍 일어나기")
                        .font(.system(size: 25))
                        .bold()
                }
                .frame(width: 340, height: 60)
                HStack() {
                    //                    ZStack() {
                    Button(action: {
                        
                    }) {
                        ZStack() {
                            RoundedRectangle(cornerRadius: 12)
                                .frame(width: 90, height: 90)
                                .foregroundColor(Color(red: 0xD9 / 255.0, green: 0xD9 / 255.0, blue: 0xD9 / 255.0))
                            Image(systemName: "camera.circle")
                                .font(/*@START_MENU_TOKEN@*/.title/*@END_MENU_TOKEN@*/)
                                .foregroundColor(.white)
                        }
                        .padding()
                    }
                    Spacer()
                }
                
                TextEditor(text: $userText)
                    .frame(width: 320, height: 250)
                    .lineSpacing(8)
                    .keyboardType(.default)
                    .border(Color.gray)
                    .onTapGesture {
                        if userText == "할 일을 마치며 느낀점을 적어주세요" {
                            userText = ""
                        }
                    }
                    .overlay(
                        Text("할 일을 마치며 느낀점을 적어주세요")
                            .foregroundColor(.gray)
                            .padding(EdgeInsets(top: 8, leading: 4, bottom: 0, trailing: 4))
                            .opacity(userText.isEmpty ? 1 : 0)
                    )
                Spacer()
                Button(action: {
                    
                }) {
                    Text("달성 완료")
                        .font(.headline)
                        .foregroundColor(.white)
                        .padding()
                        .frame(width: 170, height: 50)
                        .background(Color.blue)
                        .cornerRadius(10)
                }
            }
            .padding()
            .onTapGesture {
            }
        }
    }
}


#Preview {
    EditView()
}


