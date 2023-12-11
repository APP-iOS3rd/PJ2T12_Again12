//
//  HomeViewModel.swift
//  PJ2T12_Again12
//
//  Created by KHJ on 2023/12/08.
//

import Foundation

@MainActor
class HomeViewModel: ObservableObject {
    @Published var showingAlert = false
    @Published var showingModalAlert = false
}