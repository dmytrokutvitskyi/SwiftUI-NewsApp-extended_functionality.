//
//  simpleApp.swift
//  simple
//
//

import SwiftUI

@main
struct simpleApp: App {
    var body: some Scene {
        WindowGroup {
            if UserDefaults.standard.firstShowWelcomeScreen && UserDefaults.standard.firstRegisterTapOnSave {
                MainTabBarView()
            } else {
                WelcomeScreen()
            }
        }
    }
}
