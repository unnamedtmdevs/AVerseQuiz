//
//  SettingsViewModel.swift
//  QuizVerse
//

import Foundation
import SwiftUI

class SettingsViewModel: ObservableObject {
    @AppStorage("isDarkMode") var isDarkMode: Bool = false
    @AppStorage("soundEnabled") var soundEnabled: Bool = true
    @AppStorage("hapticsEnabled") var hapticsEnabled: Bool = true
    @AppStorage("showExplanationsAutomatically") var showExplanationsAutomatically: Bool = false
    @AppStorage("userName") var userName: String = ""
    
    func resetToDefaults() {
        isDarkMode = false
        soundEnabled = true
        hapticsEnabled = true
        showExplanationsAutomatically = false
    }
    
    func deleteAccount(completion: @escaping () -> Void) {
        // Reset all app data
        resetToDefaults()
        userName = ""
        
        // Clear quiz progress
        UserDefaults.standard.removeObject(forKey: "savedQuizzes")
        
        // Reset onboarding
        UserDefaults.standard.set(false, forKey: "hasCompletedOnboarding")
        
        completion()
    }
}

