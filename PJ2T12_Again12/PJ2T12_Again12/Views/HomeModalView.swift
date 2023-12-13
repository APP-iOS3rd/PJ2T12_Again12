//
//  HomeModalView.swift
//  PJ2T12_Again12
//
//  Created by Eunsu JEONG on 12/11/23.
//

import SwiftUI

struct HomeModalView: View {
    @Environment(\.managedObjectContext) var moc
    @ObservedObject var homeVM: HomeViewModel
    @FetchRequest(sortDescriptors: []) var selectedTodo: FetchedResults<Todo>
    
    //Sizes
    private let circleSize: CGFloat = 60
    private let imageSize: CGFloat = 30
    
    //Fonts
    private let titleFontSize: CGFloat = 21
    private let titleFontWeight: Font.Weight = .bold
    private let todoGuideFontSize: CGFloat = 15
    private let todoGuideFontWeight: Font.Weight = .medium
    
    //Colors
    private let selectedTodoImageColor: Color = .todoModalButton
    private let selectedWantTodoImageColor: Color = .wanttoModalButton
    private let defaultBlack: Color = .defaultBlack
    private let alertBackWhite: Color = .alertBackWhite
    
    init(todoId: UUID, homeVM: HomeViewModel) {
        print("Initalize")
        _selectedTodo = FetchRequest(sortDescriptors: [], predicate: NSPredicate(format: "id == %@", todoId as CVarArg))
        self.homeVM = homeVM
    }
    
    var body: some View {
        VStack {
            VStack {
                Text(homeVM.isTodo ? "해야하는 투두" : "하고싶은 투두")
                    .font(.system(size: titleFontSize, weight: titleFontWeight))
                    .padding(.top, 25)
                
                // 이모티콘
                HStack {
                    ForEach(homeVM.images, id: \.self) { image in
                        Button {
                            homeVM.selectedImage = image
                        } label: {
                            ZStack {
                                if homeVM.selectedImage == image {
                                    Circle()
                                        .frame(width: circleSize, height: circleSize)
                                        .foregroundStyle(homeVM.isTodo ? selectedTodoImageColor : selectedWantTodoImageColor)
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
                    Text(homeVM.isTodo ? "어떤 투두를 해야 하나요?" : "어떤 투두를 하고 싶은가요?")
                        .font(.system(size: todoGuideFontSize, weight: todoGuideFontWeight))
                    
                    Spacer()
                }
                .padding(.top)
                .padding(.horizontal)
                
                TextField("", text: $homeVM.title)
                    .background(.white)
                    .textFieldStyle(.roundedBorder)
                    .padding(.horizontal)
                    .shadow(radius: 1, x: 1, y: 1)
                Spacer()
                Divider()
                HStack {
                    Button {
                        resetUserInputAndDismiss()
                    } label: {
                        Text("취소")
                            .frame(width: UIScreen.main.bounds.width / 2 - 40)
                            .foregroundStyle(defaultBlack)
                    }
                    .padding(.bottom, 5)
                    
                    Divider()
                        .frame(height: 45)
                    
                    Button {
                        if selectedTodo.isEmpty {   
                            createNewTodo()
                        } else {
                            selectedTodo[0].title = homeVM.title
                            selectedTodo[0].image = homeVM.selectedImage
                        }
                        
                        saveChanges()
                        
                        resetUserInputAndDismiss()
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
        .onAppear {
            if let selectedTodo = selectedTodo.first {
                homeVM.title = selectedTodo.wrappedTitle
                homeVM.selectedImage = selectedTodo.wrappedImage
            }
        }
    }
    func saveChanges() {
        if moc.hasChanges {
            do {
                try moc.save()
            } catch {
                print("Failed to save core data")
            }
        } else {
            print("no chagnes")
        }
    }
    func resetUserInputAndDismiss() {
        homeVM.title = ""
        homeVM.selectedImage = homeVM.images.first ?? "paperplane"
        homeVM.showingModalAlert = false
    }
    func createNewTodo() {
        let todo = Todo(context: moc)
        todo.title = homeVM.title
        todo.date = Date.now // 제목 수정시 날짜 덮어씌워짐
        todo.isTodo = homeVM.isTodo
        todo.review = ""
        todo.status = false
        todo.image = homeVM.selectedImage
        todo.isSaved = false
        todo.id = UUID()
        todo.reviewImage = nil
    }
}

//#Preview {
//    HomeModalView()
//}
