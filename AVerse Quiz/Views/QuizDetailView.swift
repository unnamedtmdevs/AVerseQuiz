//
//  QuizDetailView.swift
//  QuizVerse
//

import SwiftUI

struct QuizDetailView: View {
    let quiz: Quiz
    @ObservedObject var viewModel: QuizViewModel
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
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
            
            VStack(spacing: 0) {
                // Header
                HStack {
                    Button(action: {
                        presentationMode.wrappedValue.dismiss()
                    }) {
                        Image(systemName: "xmark")
                            .font(.system(size: 18, weight: .semibold))
                            .foregroundColor(.white)
                            .frame(width: 40, height: 40)
                            .background(Color.white.opacity(0.1))
                            .cornerRadius(20)
                    }
                    
                    Spacer()
                    
                    Text(quiz.title)
                        .font(.system(size: 18, weight: .semibold))
                        .foregroundColor(.white)
                    
                    Spacer()
                    
                    Button(action: {
                        viewModel.resetQuiz()
                    }) {
                        Image(systemName: "arrow.clockwise")
                            .font(.system(size: 18, weight: .semibold))
                            .foregroundColor(.white)
                            .frame(width: 40, height: 40)
                            .background(Color.white.opacity(0.1))
                            .cornerRadius(20)
                    }
                }
                .padding()
                
                if viewModel.showResults {
                    ResultsView(quiz: quiz, viewModel: viewModel, onDismiss: {
                        presentationMode.wrappedValue.dismiss()
                    })
                } else {
                    QuestionView(quiz: quiz, viewModel: viewModel)
                }
            }
        }
        .onAppear {
            viewModel.startQuiz(quiz)
        }
    }
}

struct QuestionView: View {
    let quiz: Quiz
    @ObservedObject var viewModel: QuizViewModel
    
    var currentQuestion: Question {
        guard let currentQuiz = viewModel.currentQuiz,
              viewModel.currentQuestionIndex < currentQuiz.questions.count else {
            return quiz.questions[0]
        }
        return currentQuiz.questions[viewModel.currentQuestionIndex]
    }
    
    var body: some View {
        VStack(spacing: 0) {
            // Progress Bar
            ProgressView(value: Double(viewModel.currentQuestionIndex + 1), total: Double(quiz.questions.count))
                .tint(Color(hex: "667eea"))
                .padding(.horizontal)
                .padding(.bottom, 8)
            
            Text("Question \(viewModel.currentQuestionIndex + 1) of \(quiz.questions.count)")
                .font(.system(size: 14))
                .foregroundColor(.white.opacity(0.6))
                .padding(.bottom, 24)
            
            ScrollView {
                VStack(spacing: 24) {
                    // Question
                    Text(currentQuestion.text)
                        .font(.system(size: 24, weight: .bold))
                        .foregroundColor(.white)
                        .multilineTextAlignment(.center)
                        .padding(.horizontal)
                        .padding(.top, 20)
                    
                    // Points
                    HStack(spacing: 6) {
                        Image(systemName: "star.fill")
                            .font(.system(size: 14))
                        Text("\(currentQuestion.points) points")
                            .font(.system(size: 14, weight: .semibold))
                    }
                    .foregroundColor(Color(hex: "fbbf24"))
                    .padding(.horizontal, 16)
                    .padding(.vertical, 8)
                    .background(Color(hex: "fbbf24").opacity(0.2))
                    .cornerRadius(20)
                    
                    // Options
                    VStack(spacing: 12) {
                        ForEach(0..<currentQuestion.options.count, id: \.self) { index in
                            OptionButton(
                                text: currentQuestion.options[index],
                                index: index,
                                isSelected: viewModel.selectedAnswer == index,
                                isCorrect: currentQuestion.userAnswer != nil && index == currentQuestion.correctAnswerIndex,
                                isWrong: currentQuestion.userAnswer != nil && viewModel.selectedAnswer == index && index != currentQuestion.correctAnswerIndex,
                                showResult: currentQuestion.userAnswer != nil
                            ) {
                                if currentQuestion.userAnswer == nil {
                                    viewModel.selectAnswer(index)
                                }
                            }
                        }
                    }
                    .padding(.horizontal)
                    
                    // Explanation
                    if viewModel.showExplanation && currentQuestion.userAnswer != nil {
                        VStack(alignment: .leading, spacing: 12) {
                            HStack {
                                Image(systemName: "lightbulb.fill")
                                    .foregroundColor(Color(hex: "fbbf24"))
                                Text("Explanation")
                                    .font(.system(size: 16, weight: .semibold))
                                    .foregroundColor(.white)
                            }
                            
                            Text(currentQuestion.explanation)
                                .font(.system(size: 14))
                                .foregroundColor(.white.opacity(0.8))
                        }
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding()
                        .background(Color.white.opacity(0.05))
                        .cornerRadius(12)
                        .padding(.horizontal)
                        .transition(.opacity)
                    }
                }
                .padding(.bottom, 100)
            }
            
            // Bottom Actions
            VStack(spacing: 12) {
                if currentQuestion.userAnswer != nil {
                    Button(action: {
                        withAnimation {
                            viewModel.toggleExplanation()
                        }
                    }) {
                        HStack {
                            Image(systemName: viewModel.showExplanation ? "eye.slash.fill" : "lightbulb.fill")
                            Text(viewModel.showExplanation ? "Hide Explanation" : "Show Explanation")
                        }
                        .font(.system(size: 16, weight: .semibold))
                        .foregroundColor(Color(hex: "fbbf24"))
                        .frame(maxWidth: .infinity)
                        .frame(height: 50)
                        .background(Color(hex: "fbbf24").opacity(0.2))
                        .cornerRadius(12)
                    }
                    .padding(.horizontal)
                }
                
                HStack(spacing: 12) {
                    if viewModel.currentQuestionIndex > 0 {
                        Button(action: {
                            withAnimation {
                                viewModel.previousQuestion()
                            }
                        }) {
                            Image(systemName: "chevron.left")
                                .font(.system(size: 16, weight: .semibold))
                                .foregroundColor(.white)
                                .frame(width: 50, height: 50)
                                .background(Color.white.opacity(0.1))
                                .cornerRadius(12)
                        }
                    }
                    
                    Button(action: {
                        withAnimation {
                            viewModel.nextQuestion()
                        }
                    }) {
                        Text(viewModel.currentQuestionIndex == quiz.questions.count - 1 ? "Finish" : "Next")
                            .font(.system(size: 16, weight: .semibold))
                            .foregroundColor(.white)
                            .frame(maxWidth: .infinity)
                            .frame(height: 50)
                            .background(
                                LinearGradient(
                                    gradient: Gradient(colors: [
                                        Color(hex: "667eea"),
                                        Color(hex: "764ba2")
                                    ]),
                                    startPoint: .leading,
                                    endPoint: .trailing
                                )
                            )
                            .cornerRadius(12)
                    }
                    .disabled(currentQuestion.userAnswer == nil)
                    .opacity(currentQuestion.userAnswer == nil ? 0.5 : 1.0)
                }
                .padding(.horizontal)
                .padding(.bottom, 20)
            }
            .background(
                LinearGradient(
                    gradient: Gradient(colors: [
                        Color(hex: "1a1a2e").opacity(0),
                        Color(hex: "16213e")
                    ]),
                    startPoint: .top,
                    endPoint: .bottom
                )
            )
        }
    }
}

struct OptionButton: View {
    let text: String
    let index: Int
    let isSelected: Bool
    let isCorrect: Bool
    let isWrong: Bool
    let showResult: Bool
    let action: () -> Void
    
    var backgroundColor: Color {
        if showResult {
            if isCorrect {
                return Color(hex: "4ade80").opacity(0.2)
            } else if isWrong {
                return Color(hex: "ef4444").opacity(0.2)
            }
        }
        return isSelected ? Color.white.opacity(0.15) : Color.white.opacity(0.05)
    }
    
    var borderColor: Color {
        if showResult {
            if isCorrect {
                return Color(hex: "4ade80")
            } else if isWrong {
                return Color(hex: "ef4444")
            }
        }
        return isSelected ? Color.white.opacity(0.3) : Color.white.opacity(0.1)
    }
    
    var icon: String? {
        if showResult {
            if isCorrect {
                return "checkmark.circle.fill"
            } else if isWrong {
                return "xmark.circle.fill"
            }
        }
        return nil
    }
    
    var body: some View {
        Button(action: action) {
            HStack(spacing: 12) {
                Text(String(Character(UnicodeScalar(65 + index)!)))
                    .font(.system(size: 16, weight: .bold))
                    .foregroundColor(.white)
                    .frame(width: 32, height: 32)
                    .background(Color.white.opacity(0.2))
                    .cornerRadius(8)
                
                Text(text)
                    .font(.system(size: 16))
                    .foregroundColor(.white)
                    .multilineTextAlignment(.leading)
                
                Spacer()
                
                if let iconName = icon {
                    Image(systemName: iconName)
                        .foregroundColor(isCorrect ? Color(hex: "4ade80") : Color(hex: "ef4444"))
                }
            }
            .padding()
            .background(backgroundColor)
            .cornerRadius(12)
            .overlay(
                RoundedRectangle(cornerRadius: 12)
                    .stroke(borderColor, lineWidth: 2)
            )
        }
        .disabled(showResult)
    }
}

struct ResultsView: View {
    let quiz: Quiz
    @ObservedObject var viewModel: QuizViewModel
    let onDismiss: () -> Void
    
    var correctAnswers: Int {
        quiz.questions.filter { $0.isCorrect }.count
    }
    
    var scorePercentage: Double {
        Double(quiz.score) / Double(quiz.maxScore) * 100
    }
    
    var performanceMessage: String {
        switch scorePercentage {
        case 90...100:
            return "Outstanding! 🌟"
        case 70..<90:
            return "Great job! 🎉"
        case 50..<70:
            return "Good effort! 👍"
        default:
            return "Keep practicing! 💪"
        }
    }
    
    var body: some View {
        ScrollView {
            VStack(spacing: 24) {
                // Trophy Icon
                ZStack {
                    Circle()
                        .fill(Color(hex: "fbbf24").opacity(0.2))
                        .frame(width: 120, height: 120)
                    
                    Image(systemName: "trophy.fill")
                        .font(.system(size: 60))
                        .foregroundColor(Color(hex: "fbbf24"))
                }
                .padding(.top, 40)
                
                // Score
                VStack(spacing: 8) {
                    Text(performanceMessage)
                        .font(.system(size: 28, weight: .bold))
                        .foregroundColor(.white)
                    
                    Text("You scored")
                        .font(.system(size: 16))
                        .foregroundColor(.white.opacity(0.6))
                    
                    Text("\(quiz.score) / \(quiz.maxScore)")
                        .font(.system(size: 48, weight: .bold))
                        .foregroundColor(Color(hex: "667eea"))
                }
                
                // Stats
                HStack(spacing: 20) {
                    ResultStat(
                        icon: "checkmark.circle.fill",
                        value: "\(correctAnswers)",
                        label: "Correct",
                        color: Color(hex: "4ade80")
                    )
                    
                    ResultStat(
                        icon: "xmark.circle.fill",
                        value: "\(quiz.questions.count - correctAnswers)",
                        label: "Wrong",
                        color: Color(hex: "ef4444")
                    )
                    
                    ResultStat(
                        icon: "percent",
                        value: String(format: "%.0f", scorePercentage),
                        label: "Score",
                        color: Color(hex: "60a5fa")
                    )
                }
                .padding()
                .background(Color.white.opacity(0.05))
                .cornerRadius(16)
                .padding(.horizontal)
                
                // Actions
                VStack(spacing: 12) {
                    Button(action: {
                        viewModel.resetQuiz()
                    }) {
                        HStack {
                            Image(systemName: "arrow.clockwise")
                            Text("Try Again")
                        }
                        .font(.system(size: 16, weight: .semibold))
                        .foregroundColor(.white)
                        .frame(maxWidth: .infinity)
                        .frame(height: 56)
                        .background(
                            LinearGradient(
                                gradient: Gradient(colors: [
                                    Color(hex: "667eea"),
                                    Color(hex: "764ba2")
                                ]),
                                startPoint: .leading,
                                endPoint: .trailing
                            )
                        )
                        .cornerRadius(16)
                    }
                    
                    Button(action: onDismiss) {
                        Text("Back to Quizzes")
                            .font(.system(size: 16, weight: .semibold))
                            .foregroundColor(.white)
                            .frame(maxWidth: .infinity)
                            .frame(height: 56)
                            .background(Color.white.opacity(0.1))
                            .cornerRadius(16)
                    }
                }
                .padding(.horizontal)
                .padding(.bottom, 20)
            }
        }
    }
}

struct ResultStat: View {
    let icon: String
    let value: String
    let label: String
    let color: Color
    
    var body: some View {
        VStack(spacing: 8) {
            Image(systemName: icon)
                .font(.system(size: 24))
                .foregroundColor(color)
            
            Text(value)
                .font(.system(size: 24, weight: .bold))
                .foregroundColor(.white)
            
            Text(label)
                .font(.system(size: 12))
                .foregroundColor(.white.opacity(0.6))
        }
        .frame(maxWidth: .infinity)
    }
}

