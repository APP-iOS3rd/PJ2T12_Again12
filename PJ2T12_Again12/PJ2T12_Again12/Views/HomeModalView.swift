//
//  HomeModalView.swift
//  PJ2T12_Again12
//
//  Created by Eunsu JEONG on 12/11/23.
//

import SwiftUI
import WidgetKit

struct HomeModalView: View {
    @ObservedObject var homeModalVM: HomeModalViewModel
    
    //Sizes
    private let circleSize: CGFloat = 60
    private let imageSize: CGFloat = 30
    
    //Fonts
    private let titleFontSize: CGFloat = 21
    private let titleFontWeight: Font.Weight = .bold
    private let todoGuideFontSize: CGFloat = 15
    private let todoGuideFontWeight: Font.Weight = .medium
    
    //Colors: wanttoModalButton과 todoModalButton 색상이 반대로 Asset 설정 되어 있어 반대로 사용하고 있습니다.
    private let selectedTodoImageColor: Color = .wanttoModalButton
    private let selectedWantTodoImageColor: Color = .todoModalButton
    private let defaultBlack: Color = .defaultBlack
    private let alertBackWhite: Color = .alertBackWhite
    
    init(todo: Todo?, isTodo: Bool, dismiss: @escaping () -> Void) {
        self.homeModalVM = HomeModalViewModel(todo: todo)
        homeModalVM.isTodo = isTodo
        homeModalVM.dismiss = dismiss
        homeModalVM.updateModalView()
    }
    
    var body: some View {
        VStack {
            VStack {
                Text(homeModalVM.isTodo ? "해야하는 투두" : "하고싶은 투두")
                    .font(.Hel20Bold)
                    .padding(.top, 25)
                
                // 이모티콘
                HStack {
                    ForEach(homeModalVM.images, id: \.self) { image in
                        Button {
                            homeModalVM.image = image
                        } label: {
                            ZStack {
                                if homeModalVM.image == image {
                                    Circle()
                                        .frame(width: circleSize, height: circleSize)
                                        .foregroundStyle(homeModalVM.isTodo ? selectedTodoImageColor : selectedWantTodoImageColor)
                                        .shadow(radius: 8, x: 5, y: 5)
                                } else {
                                    Circle()
                                        .stroke(defaultBlack, lineWidth: 1.5)
                                        .frame(width: circleSize, height: circleSize)
                                        .foregroundStyle(alertBackWhite)
                                }
                                Image(systemName: image)
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                                    .foregroundStyle(defaultBlack)
                                    .frame(width: imageSize, height: imageSize)
                            }
                            .padding(.horizontal, 8)
                        }
                    }
                }
                HStack {
                    Text(homeModalVM.isTodo ? "어떤 투두를 해야 하나요?" : "어떤 투두를 하고 싶은가요?")
                        .font(.Hel15Bold)
                    Spacer()
                }
                .padding(.top)
                .padding(.horizontal)
                
                TextField("", text: $homeModalVM.title)
                    .font(.Hel15)
                    .background(.white)
                    .textFieldStyle(.roundedBorder)
                    .padding(.horizontal)
                    .shadow(radius: 1, x: 1, y: 1)
                Spacer()
                Divider()
                HStack {
                    Button {
                        homeModalVM.resetUserInput()
                        homeModalVM.dismiss()
                    } label: {
                        Text("취소")
                            .frame(width: UIScreen.main.bounds.width / 2 - 40)
                            .foregroundStyle(defaultBlack)
                    }
                    .padding(.bottom, 5)
                    
                    Divider()
                        .frame(height: 45)
                    
                    Button {
                        if let selectedTodo = homeModalVM.todo {
                            selectedTodo.title = homeModalVM.title
                            selectedTodo.image = homeModalVM.image
                            homeModalVM.updateTodo()
                        } else {
                            homeModalVM.addTodo(title: homeModalVM.title, image: homeModalVM.image, isTodo: homeModalVM.isTodo)
                        }
                        WidgetCenter.shared.reloadAllTimelines()
                        homeModalVM.resetUserInput()
                        homeModalVM.dismiss()
                    } label: {
                        Text("저장")
                            .frame(width: UIScreen.main.bounds.width / 2 - 40)
                            .foregroundStyle(defaultBlack)
                    }
                }
            }
            .frame(width: UIScreen.main.bounds.width - 50, height: 300)
            .background(alertBackWhite)
            .clipShape(RoundedRectangle(cornerRadius: 10))
        }
        .frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)
        .background(.ultraThinMaterial)
    }
}

//#Preview {
//    HomeModalView()
//}
