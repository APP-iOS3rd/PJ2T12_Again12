//
//  PJ2T12_Again12App.swift
//  PJ2T12_Again12
//
//  Created by KHJ on 2023/12/07.
//

import SwiftUI
import KakaoSDKCommon
import KakaoSDKAuth

@main
 struct PJ2T12_Again12App: App {
     
    @UIApplicationDelegateAdaptor var appDelegate : MyAppDelegate
//    @StateObject private var dataController = DataController()
     private let viewcontext = CoreDataManager.shared.viewContext
    var body: some Scene {
        WindowGroup {
            TodoriTapView()
                .environment(\.managedObjectContext, viewcontext)
//                .environment(\.managedObjectContext, dataController.container.viewContext)
        }
    }
}
