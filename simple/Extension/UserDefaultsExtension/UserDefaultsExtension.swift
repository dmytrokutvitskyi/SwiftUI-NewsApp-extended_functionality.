//
//  UserDefaultsExtension.swift
//  simple
//
//

import SwiftUI

extension UserDefaults {
    
    var firstShowWelcomeScreen: Bool {
        get {
            return (UserDefaults.standard.value(forKey: "firstShowWelcomeScreen") as? Bool) ?? false
        }
        set {
            UserDefaults.standard.setValue(newValue, forKey: "firstShowWelcomeScreen")
        }
    }
    
    var firstRegisterTapOnSave: Bool {
        get {
            return (UserDefaults.standard.value(forKey: "registerFirstTap") as? Bool) ?? false
        }
        set {
            UserDefaults.standard.setValue(newValue, forKey: "registerFirstTap")
        }
    }
}
