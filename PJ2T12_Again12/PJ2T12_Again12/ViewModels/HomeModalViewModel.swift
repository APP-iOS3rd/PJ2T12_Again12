//
//  HomeModalViewModel.swift
//  PJ2T12_Again12
//
//  Created by KHJ on 2023/12/18.
//

import Foundation
import UserNotifications

class HomeModalViewModel: ObservableObject {
    @Published var title = ""
    @Published var image = ""
    var dismiss: () -> Void = {}
    var isTodo = false
    var images: [String] = ["paperplane", "book.closed", "moon", "dumbbell"]
    var todo: Todo?
    
    init(todo: Todo?) {
        self.todo = todo
    }
    
    func updateModalView() {
        title = todo?.wrappedTitle ?? ""
        image = todo?.wrappedImage ?? "paperplane"
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
    
    func resetUserInput() {
        title = ""
        image = "paperplane"
    }

    func addTodo(title: String, image: String, isTodo: Bool) {
        CoreDataManager.shared.addTodo(title: title, image: image, isTodo: isTodo)
    }
    
    func updateTodo() {
        CoreDataManager.shared.saveContext()
    }
}
