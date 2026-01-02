//
//  QuizModel.swift
//  QuizVerse
//

import Foundation

struct Quiz: Identifiable, Codable {
    let id: UUID
    let title: String
    let description: String
    let category: QuizCategory
    let difficulty: Difficulty
    var questions: [Question]
    let icon: String
    let estimatedTime: Int // in minutes
    
    var completionRate: Double {
        let answered = questions.filter { $0.userAnswer != nil }.count
        return Double(answered) / Double(questions.count)
    }
    
    var score: Int {
        questions.filter { $0.isCorrect }.reduce(0) { $0 + $1.points }
    }
    
    var maxScore: Int {
        questions.reduce(0) { $0 + $1.points }
    }
    
    init(id: UUID = UUID(), title: String, description: String, category: QuizCategory, difficulty: Difficulty, questions: [Question], icon: String, estimatedTime: Int) {
        self.id = id
        self.title = title
        self.description = description
        self.category = category
        self.difficulty = difficulty
        self.questions = questions
        self.icon = icon
        self.estimatedTime = estimatedTime
    }
}

enum QuizCategory: String, Codable, CaseIterable {
    case science = "Science"
    case technology = "Technology"
    case art = "Art"
    case history = "History"
    case nature = "Nature"
    case space = "Space"
    case mathematics = "Mathematics"
    case literature = "Literature"
    
    var gradient: [String] {
        switch self {
        case .science:
            return ["#667eea", "#764ba2"]
        case .technology:
            return ["#f093fb", "#f5576c"]
        case .art:
            return ["#4facfe", "#00f2fe"]
        case .history:
            return ["#43e97b", "#38f9d7"]
        case .nature:
            return ["#fa709a", "#fee140"]
        case .space:
            return ["#30cfd0", "#330867"]
        case .mathematics:
            return ["#a8edea", "#fed6e3"]
        case .literature:
            return ["#ff9a9e", "#fecfef"]
        }
    }
}

enum Difficulty: String, Codable {
    case easy = "Easy"
    case medium = "Medium"
    case hard = "Hard"
    case expert = "Expert"
    
    var color: String {
        switch self {
        case .easy:
            return "#4ade80"
        case .medium:
            return "#fbbf24"
        case .hard:
            return "#f97316"
        case .expert:
            return "#ef4444"
        }
    }
}

