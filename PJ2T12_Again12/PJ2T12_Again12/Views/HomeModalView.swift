//
//  HomeModalView.swift
//  PJ2T12_Again12
//
//  Created by Eunsu JEONG on 12/11/23.
//

import SwiftUI
import WidgetKit
import UserNotifications


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
//                            createDummyTodo(month: 11)
//                            createDummyTodo(month: 10)
//                            createDummyTodo(month: 9)
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
}

// MARK: - Functions

extension HomeModalView {
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
        
        addNotification(todo: todo)
    }
    func createDummyTodo(month: Int) {
        for _ in 0...2 {
            var dateComponents = DateComponents()
            dateComponents.year = 2023
            dateComponents.month = month
            let todo = Todo(context: moc)
            todo.title = homeVM.title
            todo.date = Calendar.current.date(from: dateComponents)
            todo.isTodo = Bool.random()
            todo.review = ""
            todo.status = Bool.random()
            todo.image = homeVM.selectedImage
            todo.isSaved = false
            todo.id = UUID()
            todo.reviewImage = nil
        }

    }
    func addNotification(todo: Todo) {
        let center = UNUserNotificationCenter.current()
        let addRequest = {
            let content = UNMutableNotificationContent()
            content.title = todo.wrappedTitle
            content.subtitle = "12월이 얼마남지 않았어요!"
            content.sound = UNNotificationSound.defaultRingtone

            // 현재 날짜 +7일이 이번 달 이내이면 알림 설정.
//            let currentDate = Date()
//            let targetDate = Calendar.current.date(byAdding: .day, value: 30, to: currentDate)!
//            if Calendar.current.isDate(targetDate, equalTo: currentDate, toGranularity: .month) {
//                var dateComponents = DateComponents()
//                dateComponents = Calendar.current.dateComponents([.year, .month, .day, .hour, .minute, .second], from: targetDate)
//                dateComponents.hour = 9
//                dateComponents.minute = 0
//                dateComponents.second = 0
//                let trigger = UNCalendarNotificationTrigger(dateMatching: dateComponents, repeats: false)
//                let request = UNNotificationRequest(identifier: todo.wrappedId.uuidString, content: content, trigger: trigger)
//                center.add(request)
//                print("Successfully set notifications")
//            } else {
//                print("Failed to set notifications")
//            }
//            
            // 테스트시 아래 코드 사용 ( 5초뒤 알림 )
            let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 5, repeats: false)
            let request = UNNotificationRequest(identifier: todo.wrappedId.uuidString, content: content, trigger: trigger)
            center.add(request)
            
            
        }
        center.getNotificationSettings { settings in
            if settings.authorizationStatus == .authorized {
                addRequest()
            } else {
                center.requestAuthorization(options: [.alert, .badge, .sound]) { success , error in
                    if success {
                        addRequest()
                    } else {
                        print("Failed to request authorization: \(error?.localizedDescription ?? "")")
                    }
                }
            }
        }
    }
}

//#Preview {
//    HomeModalView()
//}
