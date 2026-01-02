//
//  ContentView.swift
//  QuizVerse
//

import SwiftUI

struct ContentView: View {
    @AppStorage("hasCompletedOnboarding") private var hasCompletedOnboarding = false
    @State private var selectedTab = 0
    
    var body: some View {
        Group {
            if hasCompletedOnboarding {
                TabView(selection: $selectedTab) {
                    QuizListView()
                        .tabItem {
                            Label("Quizzes", systemImage: "brain.head.profile")
                        }
                        .tag(0)
                    
                    SettingsView()
                        .tabItem {
                            Label("Settings", systemImage: "gearshape.fill")
                        }
                        .tag(1)
                }
                .accentColor(Color(hex: "667eea"))
                .onAppear {
                    let appearance = UITabBarAppearance()
                    appearance.configureWithOpaqueBackground()
                    appearance.backgroundColor = UIColor(Color(hex: "1a1a2e"))
                    
                    UITabBar.appearance().standardAppearance = appearance
                    if #available(iOS 15.0, *) {
                        UITabBar.appearance().scrollEdgeAppearance = appearance
                    }
                }
            } else {
                OnboardingView()
            }
        }
        .preferredColorScheme(.dark)
    }
}

#Preview {
    ContentView()
}
