//
//  HomeViewModel.swift
//  PJ2T12_Again12
//
//  Created by KHJ on 2023/12/08.
//

import Foundation
import SwiftUI

@MainActor
class HomeViewModel: ObservableObject {
    @Published var showingAlert = false
    @Published var showingWantTodoAlert = false
    @Published var showingModalAlert = false
    @Published var title = ""
    @Published var images: [String] = ["paperplane", "book.closed", "moon", "dumbbell"]
    @Published var selectedImage = "paperplane"
    @Published var isTodo = false
    @Published var selectedTodoId: UUID = UUID()
}
