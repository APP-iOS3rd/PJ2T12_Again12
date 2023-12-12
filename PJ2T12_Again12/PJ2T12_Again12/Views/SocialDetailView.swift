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
    
    // Sizes
    let circleSize: CGFloat = 94
    let profileIconSize: CGFloat = 40
    let buttonWidth: CGFloat = 140
    let buttonHeight: CGFloat = 52
    let buttonSpace: CGFloat = 26
    
    //Fonts
    let titleFontSize: Font.TextStyle = .largeTitle
    let titleFontWeight: Font.Weight = .medium
    let noTodoriGuideTextSize: CGFloat = 15
    
    //Colors
    let viewbackgroundColor: Color = Color(hex: 0xFFFAE1)
    let todoriBlack: Color = Color(hex: 0x432D00)
    let profileBackgroundColor: Color = .white
    let cheerButtonColor: Color = Color(hex: 0xB79800)
    let hurryButtonColor: Color = Color(hex: 0xB76300)
    let noTodoriGuideTextColor: Color = .gray
    let todoListGroupBorderColor: Color = Color(hex: 0xA58B00)
    let medalBackgroundColor: Color = .white
    
    var body: some View {
        ZStack {
            viewbackgroundColor
                .ignoresSafeArea()
            ScrollView {
                //친구 프로필 이미지와 닉네임
                HStack {
                    ZStack {
                        Circle()
                            .stroke(todoriBlack, lineWidth: 1.0)
                            .frame(width: circleSize, height: circleSize)
                            .background(profileBackgroundColor)
                            .clipShape(Circle())
                        
                        Image(systemName: friend.profileImage ?? "person")
                            .font(.system(size: profileIconSize))
                    } //ZStack
                    .padding(.trailing, 30)
                    
                    Text(friend.name ?? "No Name")
                        .foregroundStyle(todoriBlack)
                        .font(.system(titleFontSize, weight: titleFontWeight))
                } //HStack
                .padding(.bottom, 20)
                
                //응원, 재촉 버튼
                HStack {
                    Button {
                        //기능구현안됨
                    } label: {
                        Text("🎉 응원하기")
                            .frame(width: buttonWidth, height: buttonHeight)
                            .foregroundStyle(todoriBlack)
                            .background(cheerButtonColor)
                            .clipShape(RoundedRectangle(cornerRadius: 10))
                    }
                    .padding(.trailing, buttonSpace)
                    
                    Button {
                        //기능구현안됨
                    } label: {
                        Text("🚨 재촉하기")
                            .frame(width: buttonWidth, height: buttonHeight)
                            .foregroundStyle(todoriBlack)
                            .background(hurryButtonColor)
                            .clipShape(RoundedRectangle(cornerRadius: 10))
                    }
                }
                .padding(.bottom, 20)
                
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
                                //이번달 투두리가 todo, wantTodo와 관계 없이 한 개라도 생성되어 있을 때
                                let todoList: [Todo] = socialVM.getTodoList(friend)
                                if todoList.count == 0 {
                                    Text("친구가 아직 투두리를 작성하지 않았어요.")
                                        .font(.system(size: noTodoriGuideTextSize))
                                        .foregroundStyle(noTodoriGuideTextColor)
                                } else {
                                    ForEach(todoList) { todo in
                                        Text(todo.title)
                                            .modifier(TodoCellModifier(status: todo.status, hexCode: 0xB79800))
                                    }
                                }
                            } else {
                                //이번달 투두리가 todo, wantTodo와 모두 한 개도 없을때
                                Text("친구가 아직 투두리를 작성하지 않았어요.")
                                    .font(.system(size: noTodoriGuideTextSize))
                                    .foregroundStyle(noTodoriGuideTextColor)
                            }
                        } //VStack
                        .frame(width: 330)
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
                                //이번달 투두리가 todo, wantTodo와 관계 없이 한 개라도 생성되어 있을 때
                                let wantTodoList: [WantTodo] = socialVM.getWantTodoList(friend)
                                if wantTodoList.count == 0 {
                                    Text("친구가 아직 투두리를 작성하지 않았어요.")
                                        .font(.system(size: noTodoriGuideTextSize))
                                        .foregroundStyle(noTodoriGuideTextColor)
                                } else {
                                    ForEach(wantTodoList) { wantTodo in
                                        Text(wantTodo.title)
                                            .modifier(TodoCellModifier(status: wantTodo.status, hexCode: 0xB76300))
                                    }
                                }
                            } else {
                                //이번달 투두리가 todo, wantTodo와 모두 한 개도 없을때
                                Text("친구가 아직 투두리를 작성하지 않았어요.")
                                    .font(.system(size: noTodoriGuideTextSize))
                                    .foregroundStyle(noTodoriGuideTextColor)
                            }
                        } //VStack
                        .frame(width: 330)
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
