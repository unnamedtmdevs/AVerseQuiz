//
//  QuizListView.swift
//  QuizVerse
//

import SwiftUI

struct QuizListView: View {
    @StateObject private var viewModel = QuizViewModel()
    @AppStorage("userName") private var userName = ""
    @State private var selectedQuiz: Quiz?
    @State private var searchText = ""
    @State private var selectedCategory: QuizCategory?
    
    var filteredQuizzes: [Quiz] {
        var quizzes = viewModel.quizzes
        
        if let category = selectedCategory {
            quizzes = quizzes.filter { $0.category == category }
        }
        
        if !searchText.isEmpty {
            quizzes = quizzes.filter { quiz in
                quiz.title.localizedCaseInsensitiveContains(searchText) ||
                quiz.description.localizedCaseInsensitiveContains(searchText)
            }
        }
        
        return quizzes
    }
    
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
                        // Header
                        VStack(alignment: .leading, spacing: 8) {
                            Text("Hello, \(userName)! 👋")
                                .font(.system(size: 28, weight: .bold))
                                .foregroundColor(.white)
                            
                            Text("Ready to expand your knowledge?")
                                .font(.system(size: 16))
                                .foregroundColor(.white.opacity(0.7))
                        }
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding(.horizontal)
                        .padding(.top, 20)
                        
                        // Stats Card
                        StatsCard(viewModel: viewModel)
                            .padding(.horizontal)
                        
                        // Search Bar
                        HStack {
                            Image(systemName: "magnifyingglass")
                                .foregroundColor(.white.opacity(0.6))
                            
                            TextField("Search quizzes...", text: $searchText)
                                .foregroundColor(.white)
                        }
                        .padding()
                        .background(Color.white.opacity(0.1))
                        .cornerRadius(12)
                        .padding(.horizontal)
                        
                        // Category Filter
                        ScrollView(.horizontal, showsIndicators: false) {
                            HStack(spacing: 12) {
                                CategoryButton(
                                    title: "All",
                                    isSelected: selectedCategory == nil
                                ) {
                                    selectedCategory = nil
                                }
                                
                                ForEach(QuizCategory.allCases, id: \.self) { category in
                                    CategoryButton(
                                        title: category.rawValue,
                                        isSelected: selectedCategory == category
                                    ) {
                                        selectedCategory = category
                                    }
                                }
                            }
                            .padding(.horizontal)
                        }
                        
                        // Quiz Cards
                        LazyVStack(spacing: 16) {
                            ForEach(filteredQuizzes) { quiz in
                                QuizCard(quiz: quiz)
                                    .onTapGesture {
                                        selectedQuiz = quiz
                                    }
                            }
                        }
                        .padding(.horizontal)
                        .padding(.bottom, 20)
                    }
                }
            }
            .navigationBarHidden(true)
            .sheet(item: $selectedQuiz) { quiz in
                QuizDetailView(quiz: quiz, viewModel: viewModel)
            }
        }
        .navigationViewStyle(StackNavigationViewStyle())
    }
}

struct StatsCard: View {
    @ObservedObject var viewModel: QuizViewModel
    
    var body: some View {
        HStack(spacing: 20) {
            StatItem(
                icon: "trophy.fill",
                value: "\(viewModel.totalScore)",
                label: "Total Score",
                color: Color(hex: "fbbf24")
            )
            
            Divider()
                .background(Color.white.opacity(0.2))
                .frame(height: 40)
            
            StatItem(
                icon: "checkmark.circle.fill",
                value: "\(viewModel.completedQuizzes)",
                label: "Completed",
                color: Color(hex: "4ade80")
            )
            
            Divider()
                .background(Color.white.opacity(0.2))
                .frame(height: 40)
            
            StatItem(
                icon: "chart.bar.fill",
                value: String(format: "%.0f%%", viewModel.averageScore),
                label: "Average",
                color: Color(hex: "60a5fa")
            )
        }
        .padding()
        .background(Color.white.opacity(0.05))
        .cornerRadius(16)
        .overlay(
            RoundedRectangle(cornerRadius: 16)
                .stroke(Color.white.opacity(0.1), lineWidth: 1)
        )
    }
}

struct StatItem: View {
    let icon: String
    let value: String
    let label: String
    let color: Color
    
    var body: some View {
        VStack(spacing: 8) {
            Image(systemName: icon)
                .font(.system(size: 20))
                .foregroundColor(color)
            
            Text(value)
                .font(.system(size: 20, weight: .bold))
                .foregroundColor(.white)
            
            Text(label)
                .font(.system(size: 12))
                .foregroundColor(.white.opacity(0.6))
        }
        .frame(maxWidth: .infinity)
    }
}

struct CategoryButton: View {
    let title: String
    let isSelected: Bool
    let action: () -> Void
    
    var body: some View {
        Button(action: action) {
            Text(title)
                .font(.system(size: 14, weight: .semibold))
                .foregroundColor(isSelected ? .white : .white.opacity(0.6))
                .padding(.horizontal, 16)
                .padding(.vertical, 8)
                .background(
                    isSelected ?
                    LinearGradient(
                        gradient: Gradient(colors: [
                            Color(hex: "667eea"),
                            Color(hex: "764ba2")
                        ]),
                        startPoint: .leading,
                        endPoint: .trailing
                    ) :
                    LinearGradient(
                        gradient: Gradient(colors: [
                            Color.white.opacity(0.1),
                            Color.white.opacity(0.1)
                        ]),
                        startPoint: .leading,
                        endPoint: .trailing
                    )
                )
                .cornerRadius(20)
        }
    }
}

struct QuizCard: View {
    let quiz: Quiz
    
    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            HStack {
                Image(systemName: quiz.icon)
                    .font(.system(size: 24))
                    .foregroundColor(.white)
                    .frame(width: 50, height: 50)
                    .background(
                        LinearGradient(
                            gradient: Gradient(colors: quiz.category.gradient.map { Color(hex: $0) }),
                            startPoint: .topLeading,
                            endPoint: .bottomTrailing
                        )
                    )
                    .cornerRadius(12)
                
                VStack(alignment: .leading, spacing: 4) {
                    Text(quiz.title)
                        .font(.system(size: 18, weight: .semibold))
                        .foregroundColor(.white)
                    
                    HStack(spacing: 8) {
                        Text(quiz.category.rawValue)
                            .font(.system(size: 12))
                            .foregroundColor(.white.opacity(0.6))
                        
                        Circle()
                            .fill(Color.white.opacity(0.6))
                            .frame(width: 3, height: 3)
                        
                        Text(quiz.difficulty.rawValue)
                            .font(.system(size: 12))
                            .foregroundColor(Color(hex: quiz.difficulty.color))
                    }
                }
                
                Spacer()
                
                Image(systemName: "chevron.right")
                    .foregroundColor(.white.opacity(0.4))
            }
            
            Text(quiz.description)
                .font(.system(size: 14))
                .foregroundColor(.white.opacity(0.7))
                .lineLimit(2)
            
            HStack {
                Label("\(quiz.questions.count) questions", systemImage: "questionmark.circle")
                    .font(.system(size: 12))
                    .foregroundColor(.white.opacity(0.6))
                
                Spacer()
                
                Label("\(quiz.estimatedTime) min", systemImage: "clock")
                    .font(.system(size: 12))
                    .foregroundColor(.white.opacity(0.6))
                
                if quiz.completionRate > 0 {
                    Spacer()
                    
                    Text("\(Int(quiz.completionRate * 100))% complete")
                        .font(.system(size: 12))
                        .foregroundColor(Color(hex: "4ade80"))
                }
            }
        }
        .padding()
        .background(Color.white.opacity(0.05))
        .cornerRadius(16)
        .overlay(
            RoundedRectangle(cornerRadius: 16)
                .stroke(Color.white.opacity(0.1), lineWidth: 1)
        )
    }
}

