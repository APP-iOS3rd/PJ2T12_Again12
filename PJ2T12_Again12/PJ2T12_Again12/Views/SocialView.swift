//
//  SocialView.swift
//  PJ2T12_Again12
//
//  Created by KHJ on 2023/12/07.
//

import SwiftUI

struct SocialView: View {
    @StateObject private var socialVM = SocialViewModel()
    
    var body: some View {
        if socialVM.isLogin {
            SocialViewIfLogin(socialVM: socialVM)
        } else {
            SocialViewIfNotLogin(socialVM: socialVM)
        }
    }
}

struct SocialViewIfNotLogin: View {
    @ObservedObject var socialVM: SocialViewModel
    @State private var alertIsPresented: Bool = false
    
    var body: some View {
        VStack {
            GeometryReader { geo in
                VStack {
                    HStack {
                        Text("친구")
                            .font(.system(size: 25, weight: .heavy))
                            .padding(.leading, 20)
                        
                        Spacer()
                    }
                    
                    Spacer()
                    
                    Text("로그인 해서\n친구들의 투두리를 살펴보세요")
                        .foregroundStyle(.gray)
                        .multilineTextAlignment(.center)
                        .padding(.bottom, 100)
                    
                    Button {
                        alertIsPresented = true
                    } label: {
                        Text("카카오 로그인하기")
                            .foregroundStyle(.white)
                            .font(.system(.body, weight: .bold))
                            .frame(width: 173, height: 52)
                            .background(.orange)
                            .clipShape(RoundedRectangle(cornerRadius: 10))
                    } //Button
                    .alert(isPresented: $alertIsPresented) {
                        let leftButton = Alert.Button.default(Text("로그인")) {
                            socialVM.isLogin = true
                        }
                        
                        let rightButton = Alert.Button.default(Text("취소")) {
                            socialVM.isLogin = false
                        }
                        
                        return Alert(title: Text("로그인 하시겠습니까?"), 
                                     primaryButton: rightButton,
                                     secondaryButton: leftButton)
                    } //alert
                    
                    Spacer()
                } //VStack
                .frame(width: geo.size.width, height: geo.size.height)
                .background(.yellow)
            }
        } //VStack
    }
}

struct SocialViewIfLogin: View {
    @ObservedObject var socialVM: SocialViewModel
    
    var body: some View {
        NavigationView {
            VStack {
                GeometryReader { geo in
                    VStack {
                        //뷰 제목과 친구 추가 버튼
                        HStack {
                            Text("친구")
                                .font(.system(size: 25, weight: .heavy))
                                .padding(.leading, 20)
                            
                            Spacer()
                            
                            Button {
                                //동작없음
                            } label: {
                                Image(systemName: "plus")
                                    .foregroundStyle(.black)
                                    .font(.system(size: 25, weight: .medium))
                                    .padding(.trailing, 20)
                            } //Button
                        } //HStack
                        
                        //친구 리스트
                        List {
                            ForEach(socialVM.myFriendsList) { friend in
                                myFriendCell(socialVM: socialVM, friend: friend)
                            }
                        } //List
                        .listStyle(.plain)
                        .scrollContentBackground(.hidden)
                        
                        Spacer()
                    } //VStack
                    .frame(width: geo.size.width, height: geo.size.height)
                    .background(.yellow)
                } //GeometryReader
            } //VStack
        } //NavigationView
    }
}

struct myFriendCell: View {
    @ObservedObject var socialVM: SocialViewModel
    @State var friend: User
    
    //Sizes
    let circleSize: CGFloat = 64
    let profileIconSize: CGFloat = 25
    let verticalStackWidth: CGFloat = 22
    let verticalStackHeight: CGFloat = 15
    
    //Colors
    let profileBorderColor: Color = .black
    let profileBackgroundColor: Color = .white
    let todoTotalColor: Color = .gray
    let todoDoneColor: Color = .orange
    
    var body: some View {
        NavigationLink(destination: SocialDetailView()) {
            HStack {
                //프로필이미지
                ZStack {
                    Circle()
                        .stroke(profileBorderColor, lineWidth: 1.0)
                        .frame(width: circleSize, height: circleSize)
                        .background(profileBackgroundColor)
                        .clipShape(Circle())
                    
                    Image(systemName: friend.profileImage ?? "person")
                        .font(.system(size: profileIconSize))
                } //ZStack
                .padding(.trailing, 10)
                
                //친구이름 + 가로그래프 + 투두 개수
                VStack(alignment: .leading) {
                    Text(friend.name ?? "Error")
                    //가로그래프 + 투두 개수
                    HStack {
                        let todoTotal = socialVM.countTotal(friend)
                        let todoDone = socialVM.countDone(friend)
                        
                        //가로그래프
                        HStack {
                            ZStack(alignment: .leading) {
                                Rectangle()
                                    .frame(width: verticalStackWidth * CGFloat(todoTotal), height: verticalStackHeight)
                                    .foregroundStyle(todoTotalColor)
                                Rectangle()
                                    .frame(width: verticalStackWidth * CGFloat(todoDone), height: verticalStackHeight)
                                    .foregroundStyle(todoDoneColor)
                            }//ZStack
                            
                            Spacer()
                        } //HStack
                        .frame(width: verticalStackWidth * 6)
                        
                        Text("\(todoDone) / \(todoTotal)")
                    }
                } //VStack
            } //HStack
        } //NavigationLink
        .listRowBackground(Color.yellow)
        .listRowSeparator(.hidden)
        
    }
}

#Preview {
    SocialView()
}
