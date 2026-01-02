//
//  QuizViewModel.swift
//  QuizVerse
//

import Foundation
import SwiftUI

class QuizViewModel: ObservableObject {
    @Published var quizzes: [Quiz] = []
    @Published var currentQuiz: Quiz?
    @Published var currentQuestionIndex: Int = 0
    @Published var showResults: Bool = false
    @Published var selectedAnswer: Int?
    @Published var showExplanation: Bool = false
    
    private let quizService = QuizService.shared
    private let userDefaultsKey = "savedQuizzes"
    
    init() {
        loadQuizzes()
    }
    
    func loadQuizzes() {
        if let savedData = UserDefaults.standard.data(forKey: userDefaultsKey),
           let decoded = try? JSONDecoder().decode([Quiz].self, from: savedData) {
            quizzes = decoded
        } else {
            quizzes = quizService.getAllQuizzes()
            saveQuizzes()
        }
    }
    
    func saveQuizzes() {
        if let encoded = try? JSONEncoder().encode(quizzes) {
            UserDefaults.standard.set(encoded, forKey: userDefaultsKey)
        }
    }
    
    func startQuiz(_ quiz: Quiz) {
        currentQuiz = quiz
        currentQuestionIndex = 0
        showResults = false
        selectedAnswer = nil
        showExplanation = false
    }
    
    func selectAnswer(_ index: Int) {
        guard var quiz = currentQuiz else { return }
        
        selectedAnswer = index
        quiz.questions[currentQuestionIndex].userAnswer = index
        
        if let quizIndex = quizzes.firstIndex(where: { $0.id == quiz.id }) {
            quizzes[quizIndex] = quiz
            saveQuizzes()
        }
        
        currentQuiz = quiz
    }
    
    func nextQuestion() {
        guard let quiz = currentQuiz else { return }
        
        if currentQuestionIndex < quiz.questions.count - 1 {
            currentQuestionIndex += 1
            selectedAnswer = quiz.questions[currentQuestionIndex].userAnswer
            showExplanation = false
        } else {
            showResults = true
        }
    }
    
    func previousQuestion() {
        guard let quiz = currentQuiz else { return }
        
        if currentQuestionIndex > 0 {
            currentQuestionIndex -= 1
            selectedAnswer = quiz.questions[currentQuestionIndex].userAnswer
            showExplanation = false
        }
    }
    
    func toggleExplanation() {
        showExplanation.toggle()
    }
    
    func resetQuiz() {
        guard var quiz = currentQuiz else { return }
        
        for i in 0..<quiz.questions.count {
            quiz.questions[i].userAnswer = nil
        }
        
        if let quizIndex = quizzes.firstIndex(where: { $0.id == quiz.id }) {
            quizzes[quizIndex] = quiz
            saveQuizzes()
        }
        
        currentQuiz = quiz
        currentQuestionIndex = 0
        selectedAnswer = nil
        showExplanation = false
        showResults = false
    }
    
    func resetAllProgress() {
        quizzes = quizService.getAllQuizzes()
        saveQuizzes()
    }
    
    func getQuizzesByCategory(_ category: QuizCategory) -> [Quiz] {
        return quizzes.filter { $0.category == category }
    }
    
    func getQuizzesByDifficulty(_ difficulty: Difficulty) -> [Quiz] {
        return quizzes.filter { $0.difficulty == difficulty }
    }
    
    var totalScore: Int {
        quizzes.reduce(0) { $0 + $1.score }
    }
    
    var completedQuizzes: Int {
        quizzes.filter { $0.completionRate == 1.0 }.count
    }
    
    var averageScore: Double {
        let totalPossible = quizzes.reduce(0) { $0 + $1.maxScore }
        guard totalPossible > 0 else { return 0 }
        return Double(totalScore) / Double(totalPossible) * 100
    }
}

