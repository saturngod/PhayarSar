//
//  UserPreferences.swift
//  PhayarSar
//
//  Created by Kyaw Zay Ya Lin Tun on 16/12/2023.
//

import SwiftUI

@MainActor
class UserPreferences: ObservableObject {
    @AppStorage(Defaults.isFirstLaunch.rawValue) var isFirstLaunch: Bool?
    @AppStorage(Defaults.hasAppLangChosen.rawValue) var hasAppLangChosen: Bool?
    @AppStorage(Defaults.appLang.rawValue) var appLang: AppLanguage = .Eng
    @AppStorage(Defaults.accentColor.rawValue) var accentColor: AppColor = .pineGreen
}
