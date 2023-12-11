//
//  Extention.swift
//  PJ2T12_Again12
//
//  Created by kwon ji won on 12/10/23.
//
import Foundation
import SwiftUI

extension View {
func hideKeyboard() {
UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
}
}
