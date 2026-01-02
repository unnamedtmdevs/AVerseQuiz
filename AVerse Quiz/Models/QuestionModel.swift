//
//  QuestionModel.swift
//  QuizVerse
//

import Foundation

struct Question: Identifiable, Codable {
    let id: UUID
    let text: String
    let options: [String]
    let correctAnswerIndex: Int
    let explanation: String
    let points: Int
    var userAnswer: Int?
    
    var isCorrect: Bool {
        guard let answer = userAnswer else { return false }
        return answer == correctAnswerIndex
    }
    
    init(id: UUID = UUID(), text: String, options: [String], correctAnswerIndex: Int, explanation: String, points: Int = 10, userAnswer: Int? = nil) {
        self.id = id
        self.text = text
        self.options = options
        self.correctAnswerIndex = correctAnswerIndex
        self.explanation = explanation
        self.points = points
        self.userAnswer = userAnswer
    }
}

