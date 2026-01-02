//
//  OnboardingView.swift
//  QuizVerse
//

import SwiftUI

struct OnboardingView: View {
    @AppStorage("hasCompletedOnboarding") private var hasCompletedOnboarding = false
    @AppStorage("userName") private var userName = ""
    
    @State private var currentPage = 0
    @State private var nameInput = ""
    @State private var animateContent = false
    
    var body: some View {
        ZStack {
            LinearGradient(
                gradient: Gradient(colors: [
                    Color(hex: "667eea"),
                    Color(hex: "764ba2")
                ]),
                startPoint: .topLeading,
                endPoint: .bottomTrailing
            )
            .ignoresSafeArea()
            
            VStack {
                if currentPage < 3 {
                    TabView(selection: $currentPage) {
                        WelcomePage()
                            .tag(0)
                        
                        FeaturesPage()
                            .tag(1)
                        
                        NameInputPage(nameInput: $nameInput)
                            .tag(2)
                    }
                    .tabViewStyle(PageTabViewStyle(indexDisplayMode: .always))
                    
                    Button(action: {
                        withAnimation(.spring()) {
                            if currentPage < 2 {
                                currentPage += 1
                            } else if !nameInput.isEmpty {
                                userName = nameInput
                                hasCompletedOnboarding = true
                            }
                        }
                    }) {
                        Text(currentPage == 2 ? "Get Started" : "Next")
                            .font(.system(size: 18, weight: .semibold))
                            .foregroundColor(.white)
                            .frame(maxWidth: .infinity)
                            .frame(height: 56)
                            .background(
                                LinearGradient(
                                    gradient: Gradient(colors: [
                                        Color.white.opacity(0.3),
                                        Color.white.opacity(0.1)
                                    ]),
                                    startPoint: .leading,
                                    endPoint: .trailing
                                )
                            )
                            .cornerRadius(16)
                            .overlay(
                                RoundedRectangle(cornerRadius: 16)
                                    .stroke(Color.white.opacity(0.3), lineWidth: 1)
                            )
                    }
                    .disabled(currentPage == 2 && nameInput.isEmpty)
                    .opacity(currentPage == 2 && nameInput.isEmpty ? 0.5 : 1)
                    .padding(.horizontal, 32)
                    .padding(.bottom, 40)
                }
            }
        }
        .preferredColorScheme(.dark)
    }
}

struct WelcomePage: View {
    @State private var animate = false
    
    var body: some View {
        VStack(spacing: 30) {
            Spacer()
            
            ZStack {
                Circle()
                    .fill(Color.white.opacity(0.1))
                    .frame(width: 200, height: 200)
                    .scaleEffect(animate ? 1.2 : 1.0)
                
                Circle()
                    .fill(Color.white.opacity(0.05))
                    .frame(width: 160, height: 160)
                    .scaleEffect(animate ? 1.0 : 1.2)
                
                Image(systemName: "brain.head.profile")
                    .font(.system(size: 80))
                    .foregroundColor(.white)
            }
            .onAppear {
                withAnimation(.easeInOut(duration: 2).repeatForever(autoreverses: true)) {
                    animate = true
                }
            }
            
            Text("Welcome to QuizVerse")
                .font(.system(size: 36, weight: .bold))
                .foregroundColor(.white)
                .multilineTextAlignment(.center)
            
            Text("Embark on an epic journey through knowledge and discovery")
                .font(.system(size: 18, weight: .regular))
                .foregroundColor(.white.opacity(0.8))
                .multilineTextAlignment(.center)
                .padding(.horizontal, 40)
            
            Spacer()
        }
        .padding()
    }
}

struct FeaturesPage: View {
    var body: some View {
        VStack(spacing: 40) {
            Spacer()
            
            Text("Explore & Learn")
                .font(.system(size: 32, weight: .bold))
                .foregroundColor(.white)
            
            VStack(spacing: 25) {
                FeatureRow(
                    icon: "star.fill",
                    title: "Diverse Topics",
                    description: "From Space to Art, Science to Literature"
                )
                
                FeatureRow(
                    icon: "chart.line.uptrend.xyaxis",
                    title: "Track Progress",
                    description: "Monitor your learning journey and achievements"
                )
                
                FeatureRow(
                    icon: "trophy.fill",
                    title: "Compete & Score",
                    description: "Challenge yourself with scoring system"
                )
            }
            .padding(.horizontal, 32)
            
            Spacer()
        }
        .padding()
    }
}

struct FeatureRow: View {
    let icon: String
    let title: String
    let description: String
    
    var body: some View {
        HStack(spacing: 20) {
            Image(systemName: icon)
                .font(.system(size: 28))
                .foregroundColor(.white)
                .frame(width: 50, height: 50)
                .background(Color.white.opacity(0.2))
                .cornerRadius(12)
            
            VStack(alignment: .leading, spacing: 4) {
                Text(title)
                    .font(.system(size: 18, weight: .semibold))
                    .foregroundColor(.white)
                
                Text(description)
                    .font(.system(size: 14))
                    .foregroundColor(.white.opacity(0.7))
            }
            
            Spacer()
        }
    }
}

struct NameInputPage: View {
    @Binding var nameInput: String
    
    var body: some View {
        VStack(spacing: 30) {
            Spacer()
            
            Image(systemName: "person.circle.fill")
                .font(.system(size: 100))
                .foregroundColor(.white.opacity(0.9))
            
            Text("What's your name?")
                .font(.system(size: 32, weight: .bold))
                .foregroundColor(.white)
            
            Text("Let's personalize your experience")
                .font(.system(size: 16))
                .foregroundColor(.white.opacity(0.7))
            
            TextField("Enter your name", text: $nameInput)
                .font(.system(size: 18))
                .foregroundColor(.white)
                .padding()
                .background(Color.white.opacity(0.2))
                .cornerRadius(12)
                .overlay(
                    RoundedRectangle(cornerRadius: 12)
                        .stroke(Color.white.opacity(0.3), lineWidth: 1)
                )
                .padding(.horizontal, 40)
                .autocapitalization(.words)
                .disableAutocorrection(true)
            
            Spacer()
        }
        .padding()
    }
}

extension Color {
    init(hex: String) {
        let hex = hex.trimmingCharacters(in: CharacterSet.alphanumerics.inverted)
        var int: UInt64 = 0
        Scanner(string: hex).scanHexInt64(&int)
        let a, r, g, b: UInt64
        switch hex.count {
        case 3: // RGB (12-bit)
            (a, r, g, b) = (255, (int >> 8) * 17, (int >> 4 & 0xF) * 17, (int & 0xF) * 17)
        case 6: // RGB (24-bit)
            (a, r, g, b) = (255, int >> 16, int >> 8 & 0xFF, int & 0xFF)
        case 8: // ARGB (32-bit)
            (a, r, g, b) = (int >> 24, int >> 16 & 0xFF, int >> 8 & 0xFF, int & 0xFF)
        default:
            (a, r, g, b) = (255, 0, 0, 0)
        }

        self.init(
            .sRGB,
            red: Double(r) / 255,
            green: Double(g) / 255,
            blue:  Double(b) / 255,
            opacity: Double(a) / 255
        )
    }
}

