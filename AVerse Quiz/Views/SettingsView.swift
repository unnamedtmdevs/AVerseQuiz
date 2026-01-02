//
//  SettingsView.swift
//  QuizVerse
//

import SwiftUI

struct SettingsView: View {
    @StateObject private var viewModel = SettingsViewModel()
    @StateObject private var quizViewModel = QuizViewModel()
    @AppStorage("hasCompletedOnboarding") private var hasCompletedOnboarding = true
    @State private var showResetAlert = false
    @State private var showDeleteAlert = false
    
    var body: some View {
        NavigationView {
            ZStack {
                LinearGradient(
                    gradient: Gradient(colors: [
                        Color(hex: "1a1a2e"),
                        Color(hex: "16213e")
                    ]),
                    startPoint: .top,
                    endPoint: .bottom
                )
                .ignoresSafeArea()
                
                ScrollView {
                    VStack(spacing: 24) {
                        // Profile Section
                        VStack(spacing: 16) {
                            Image(systemName: "person.circle.fill")
                                .font(.system(size: 80))
                                .foregroundColor(.white.opacity(0.9))
                            
                            if !viewModel.userName.isEmpty {
                                Text(viewModel.userName)
                                    .font(.system(size: 24, weight: .bold))
                                    .foregroundColor(.white)
                            }
                            
                            HStack(spacing: 20) {
                                VStack(spacing: 4) {
                                    Text("\(quizViewModel.totalScore)")
                                        .font(.system(size: 20, weight: .bold))
                                        .foregroundColor(Color(hex: "fbbf24"))
                                    
                                    Text("Total Score")
                                        .font(.system(size: 12))
                                        .foregroundColor(.white.opacity(0.6))
                                }
                                
                                Divider()
                                    .background(Color.white.opacity(0.2))
                                    .frame(height: 30)
                                
                                VStack(spacing: 4) {
                                    Text("\(quizViewModel.completedQuizzes)")
                                        .font(.system(size: 20, weight: .bold))
                                        .foregroundColor(Color(hex: "4ade80"))
                                    
                                    Text("Completed")
                                        .font(.system(size: 12))
                                        .foregroundColor(.white.opacity(0.6))
                                }
                            }
                            .padding()
                            .background(Color.white.opacity(0.05))
                            .cornerRadius(12)
                        }
                        .padding(.top, 20)
                        
                        // Preferences Section
                        VStack(alignment: .leading, spacing: 16) {
                            Text("Preferences")
                                .font(.system(size: 20, weight: .bold))
                                .foregroundColor(.white)
                                .padding(.horizontal)
                            
                            VStack(spacing: 0) {
                                SettingsToggle(
                                    icon: "moon.fill",
                                    title: "Dark Mode",
                                    description: "Use dark theme",
                                    isOn: $viewModel.isDarkMode,
                                    color: Color(hex: "667eea")
                                )
                                
                                Divider()
                                    .background(Color.white.opacity(0.1))
                                    .padding(.leading, 60)
                                
                                SettingsToggle(
                                    icon: "speaker.wave.2.fill",
                                    title: "Sound",
                                    description: "Enable sound effects",
                                    isOn: $viewModel.soundEnabled,
                                    color: Color(hex: "60a5fa")
                                )
                                
                                Divider()
                                    .background(Color.white.opacity(0.1))
                                    .padding(.leading, 60)
                                
                                SettingsToggle(
                                    icon: "hand.tap.fill",
                                    title: "Haptics",
                                    description: "Enable haptic feedback",
                                    isOn: $viewModel.hapticsEnabled,
                                    color: Color(hex: "4ade80")
                                )
                                
                                Divider()
                                    .background(Color.white.opacity(0.1))
                                    .padding(.leading, 60)
                                
                                SettingsToggle(
                                    icon: "lightbulb.fill",
                                    title: "Auto Explanations",
                                    description: "Show explanations automatically",
                                    isOn: $viewModel.showExplanationsAutomatically,
                                    color: Color(hex: "fbbf24")
                                )
                            }
                            .background(Color.white.opacity(0.05))
                            .cornerRadius(16)
                            .padding(.horizontal)
                        }
                        
                        // Actions Section
                        VStack(alignment: .leading, spacing: 16) {
                            Text("Actions")
                                .font(.system(size: 20, weight: .bold))
                                .foregroundColor(.white)
                                .padding(.horizontal)
                            
                            VStack(spacing: 12) {
                                SettingsButton(
                                    icon: "arrow.clockwise",
                                    title: "Reset All Progress",
                                    description: "Clear all quiz answers and scores",
                                    color: Color(hex: "f97316")
                                ) {
                                    showResetAlert = true
                                }
                                
                                SettingsButton(
                                    icon: "trash.fill",
                                    title: "Delete Account",
                                    description: "Reset app to onboarding state",
                                    color: Color(hex: "ef4444")
                                ) {
                                    showDeleteAlert = true
                                }
                            }
                            .padding(.horizontal)
                        }
                        
                        // App Info
                        VStack(spacing: 8) {
                            Text("QuizVerse")
                                .font(.system(size: 16, weight: .semibold))
                                .foregroundColor(.white.opacity(0.6))
                            
                            Text("Version 1.0.0")
                                .font(.system(size: 14))
                                .foregroundColor(.white.opacity(0.4))
                            
                            Text("© 2026 QuizVerse")
                                .font(.system(size: 12))
                                .foregroundColor(.white.opacity(0.3))
                        }
                        .padding(.vertical, 20)
                    }
                    .padding(.bottom, 20)
                }
            }
            .navigationBarTitle("Settings", displayMode: .large)
            .navigationBarTitleTextColor(.white)
            .alert(isPresented: $showResetAlert) {
                Alert(
                    title: Text("Reset All Progress"),
                    message: Text("Are you sure you want to reset all quiz progress? This action cannot be undone."),
                    primaryButton: .destructive(Text("Reset")) {
                        quizViewModel.resetAllProgress()
                    },
                    secondaryButton: .cancel()
                )
            }
        }
        .navigationViewStyle(StackNavigationViewStyle())
        .alert(isPresented: $showDeleteAlert) {
            Alert(
                title: Text("Delete Account"),
                message: Text("This will reset the app to its initial state. All your progress will be lost."),
                primaryButton: .destructive(Text("Delete")) {
                    viewModel.deleteAccount {
                        hasCompletedOnboarding = false
                    }
                },
                secondaryButton: .cancel()
            )
        }
    }
}

struct SettingsToggle: View {
    let icon: String
    let title: String
    let description: String
    @Binding var isOn: Bool
    let color: Color
    
    var body: some View {
        HStack(spacing: 16) {
            Image(systemName: icon)
                .font(.system(size: 20))
                .foregroundColor(color)
                .frame(width: 36, height: 36)
                .background(color.opacity(0.2))
                .cornerRadius(8)
            
            VStack(alignment: .leading, spacing: 2) {
                Text(title)
                    .font(.system(size: 16, weight: .semibold))
                    .foregroundColor(.white)
                
                Text(description)
                    .font(.system(size: 12))
                    .foregroundColor(.white.opacity(0.6))
            }
            
            Spacer()
            
            Toggle("", isOn: $isOn)
                .labelsHidden()
                .tint(color)
        }
        .padding()
    }
}

struct SettingsButton: View {
    let icon: String
    let title: String
    let description: String
    let color: Color
    let action: () -> Void
    
    var body: some View {
        Button(action: action) {
            HStack(spacing: 16) {
                Image(systemName: icon)
                    .font(.system(size: 20))
                    .foregroundColor(color)
                    .frame(width: 36, height: 36)
                    .background(color.opacity(0.2))
                    .cornerRadius(8)
                
                VStack(alignment: .leading, spacing: 2) {
                    Text(title)
                        .font(.system(size: 16, weight: .semibold))
                        .foregroundColor(.white)
                    
                    Text(description)
                        .font(.system(size: 12))
                        .foregroundColor(.white.opacity(0.6))
                }
                
                Spacer()
                
                Image(systemName: "chevron.right")
                    .foregroundColor(.white.opacity(0.4))
            }
            .padding()
            .background(Color.white.opacity(0.05))
            .cornerRadius(12)
        }
    }
}

// Extension to customize navigation bar title color
extension View {
    func navigationBarTitleTextColor(_ color: Color) -> some View {
        self.modifier(NavigationBarTitleColorModifier(color: color))
    }
}

struct NavigationBarTitleColorModifier: ViewModifier {
    let color: Color
    
    init(color: Color) {
        self.color = color
        let coloredAppearance = UINavigationBarAppearance()
        coloredAppearance.configureWithTransparentBackground()
        coloredAppearance.backgroundColor = .clear
        coloredAppearance.largeTitleTextAttributes = [.foregroundColor: UIColor(color)]
        coloredAppearance.titleTextAttributes = [.foregroundColor: UIColor(color)]
        
        UINavigationBar.appearance().standardAppearance = coloredAppearance
        UINavigationBar.appearance().compactAppearance = coloredAppearance
        UINavigationBar.appearance().scrollEdgeAppearance = coloredAppearance
    }
    
    func body(content: Content) -> some View {
        content
    }
}

