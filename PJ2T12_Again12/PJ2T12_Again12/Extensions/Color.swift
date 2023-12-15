//
//  Color.swift
//  PJ2T12_Again12
//
//  Created by KHJ on 2023/12/11.
//

import Foundation
import SwiftUI

extension Color {
    init(hex: UInt, alpha: Double = 1) {
        self.init(
            .sRGB,
            red: Double((hex >> 16) & 0xff) / 255,
            green: Double((hex >> 08) & 0xff) / 255,
            blue: Double((hex >> 00) & 0xff) / 255,
            opacity: alpha
        )
    }
    
    static let AlertBackWhite = Color("AlertBackWhite")
    static let BackgroundYellow = Color("BackgroundYellow")
    static let BorderBrown = Color("BorderBrown")
    static let BracketsGray = Color("BracketsGray")
    static let CameraBackGray = Color("CameraBackGray")
    static let CameraGray = Color("CameraGray")
    static let DefaultBlack = Color("DefaultBlack")
    static let LoginButtonBrown = Color("LoginButtonBrown")
    static let NewTodoButtonBrown = Color("NewTodoButtonBrown")
    static let PhotoBrown = Color("PhotoBrown")
    static let PopUpwhite = Color("PopUpwhite")
    static let SettingTextGray = Color("SettingTextGray")
    static let SocialBackGray = Color("SocialBackGray")
    static let SocialChartBrown = Color("SocialChartBrown")
    static let SocialChartGray = Color("SocialChartGray")
    static let TextDefaultGray = Color("TextDefaultGray")
    static let TodoButtonBrown = Color("TodoButtonBrown")
    static let TodoModalButton = Color("TodoModalButton")
    static let TodoNoTextBrown = Color("TodoNoTextBrown")
    static let ToggleOrange = Color("ToggleOrange")
    static let WanttoModalButton = Color("WanttoModalButton")
    static let WanttoNoTextBrown = Color("WanttoNoTextBrown")
    static let WanttoYesButtonBrown = Color("WanttoYesButtonBrown")
    static let WanttoYesTextBrown = Color("WanttoYesTextBrown")
    
}
