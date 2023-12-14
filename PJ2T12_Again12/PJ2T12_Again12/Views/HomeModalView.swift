//
//  HomeModalView.swift
//  PJ2T12_Again12
//
//  Created by Eunsu JEONG on 12/11/23.
//

import SwiftUI
import WidgetKit

struct HomeModalView: View {
    @Environment(\.managedObjectContext) var moc
    @ObservedObject var homeVM: HomeViewModel
    @FetchRequest(sortDescriptors: []) var selectedTodo: FetchedResults<Todo>
    
    var circleSize: CGFloat = 60
    var imageSize: CGFloat = 30
    
    init(todoId: UUID, homeVM: HomeViewModel) {
        print("Initalize")
        _selectedTodo = FetchRequest(sortDescriptors: [], predicate: NSPredicate(format: "id == %@", todoId as CVarArg))
        self.homeVM = homeVM
    }
    
    var body: some View {
        VStack {
            VStack {
                Text(homeVM.isTodo ? "해야하는 투두" : "하고싶은 투두")
                    .font(.system(size: 21, weight: .bold))
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
                    Text(homeVM.isTodo ? "어떤 투두를 해야 하나요?" : "어떤 투두를 하고 싶은가요?")
                        .font(.system(size: 15, weight: .medium))
                    
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
                        
                        WidgetCenter.shared.reloadAllTimelines()
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
