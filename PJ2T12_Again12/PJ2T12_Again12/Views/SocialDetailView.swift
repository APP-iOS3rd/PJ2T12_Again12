//
//  SocialDetailView.swift
//  PJ2T12_Again12
//
//  Created by Eunsu JEONG on 12/12/23.
//

import SwiftUI

struct SocialDetailView: View {
    @ObservedObject var socialVM: SocialViewModel
    @State var friend: User
    
    //Font
    let titleFontSize: Font.TextStyle = .largeTitle
    let titleFontWeight: Font.Weight = .medium
    
    //Color
    let viewbackgroundColor: Color = Color(hex: 0xFFFAE1)
    let todoriBlack: Color = Color(hex: 0x432D00)
    let todoListGroupBorderColor: Color = Color(hex: 0xA58B00)
    let medalBackgroundColor: Color = .white
    
    var body: some View {
        ZStack {
            viewbackgroundColor
                .ignoresSafeArea()
            ScrollView {
                //Title: 이번 달
                HStack {
                    Text("\(socialVM.setDateFormat(Date.now))")
                        .foregroundStyle(todoriBlack)
                        .font(.system(titleFontSize, weight: titleFontWeight))

                    Spacer()
                } //HStack
                .padding(.bottom, 4)
                
                // 하고싶은일 + 해야하는일 + 뱃지
                VStack(spacing: 16) {
                    // 하고 싶은 일
                    VStack {
                        HStack {
                            Text("하고 싶으면")
                                .bold()
                            
                            Spacer()
                        } //HStack
                        
                        VStack {
                            if socialVM.isThisMonth(friend) {
                                let todoList: [Todo] = socialVM.getTodoList(friend)
                                ForEach(todoList) { todo in
                                    Text(todo.title)
                                        .modifier(TodoCellModifier(status: todo.status, hexCode: 0xB79800))
                                }
                            }
                        } //VStack
                        .padding()
                        .overlay(
                            RoundedRectangle(cornerRadius: 10)
                                .stroke(todoListGroupBorderColor.opacity(0.32), 
                                        lineWidth: 2)
                        )
                    } //VStack
                    
                    // 해야 하는 일
                    VStack {
                        HStack {
                            Text("해야 하면")
                                .bold()
                            Spacer()
                        } //HStack
                        
                        VStack {
                            if socialVM.isThisMonth(friend) {
                                let wantTodoList: [WantTodo] = socialVM.getWantTodoList(friend)
                                ForEach(wantTodoList) { wantTodo in
                                    Text(wantTodo.title)
                                        .modifier(TodoCellModifier(status: wantTodo.status, hexCode: 0xB76300))
                                }
                            }
                        } //VStack
                        .padding()
                        .overlay(
                            RoundedRectangle(cornerRadius: 10)
                                .stroke(todoListGroupBorderColor.opacity(0.32), 
                                        lineWidth: 2)
                        )
                    } //VStack
                    
                    //뱃지: Model의 Medal이 Hashable해야지만 작동
                    VStack {
                        HStack {
                            Text("뱃지")
                                .bold()
                            
                            Spacer()
                        } //HStack
                        
                        VStack {
                            LazyVGrid(columns: Array(repeating: GridItem(.adaptive(minimum: 90)), count: 3)) {
                                let medalsList: [Medal] = friend.medalList
                                
                                ForEach(medalsList, id: \.self) { medal in
                                    ZStack {
                                        RoundedRectangle(cornerRadius: 10)
                                            .frame(width: 90, height: 100)
                                            .foregroundStyle(medalBackgroundColor)
                                        
                                        Image(systemName: medal.image)
                                            .font(.system(size: 40))
                                    }
                                }
                            } //LazyVGrid
                        } //VStack
                        .frame(width: 330)
                        .padding()
                        .overlay(
                            RoundedRectangle(cornerRadius: 10)
                                .stroke(todoListGroupBorderColor.opacity(0.32),
                                        lineWidth: 2)
                        )
                    } //VStack
                } //VStack
            } //ScrollView
            .padding()
        } //ZStack
    }
}

#Preview {
    SocialDetailView(socialVM: SocialViewModel(), friend: SocialViewModel().myFriendsList[2])
}
