//
//  QuizBrain.swift
//  AppEnglish
//
//  Created by CNTT on 6/5/21.
//  Copyright © 2021 fit.tdc.vn. All rights reserved.
//

import Foundation

struct QuizBrain {
    var questionNumber = 0
    var score = 0
    let quiz = [
        Questions(q: "Đâu là 'nước'?", a: ["Heart", "Skin", "Water", "Food"], correctAnswer: "Water"),
        Questions(q: "Hello", a: ["Xin chào", "Xin lỗi", "Cảm ơn", "Github"], correctAnswer: "Xin chào"),
        Questions(q: "What do the letters in the GMT time zone stand for?", a: ["Global Meridian Time", "Greenwich Mean Time", "General Median Time", "HongLoi"], correctAnswer: "Greenwich Mean Time"),
        Questions(q: "What is the French word for 'hat'?", a: ["Chapeau", "Écharpe", "Bonnet", "ThanhLam"], correctAnswer: "Chapeau"),
        Questions(q: "In past times, what would a gentleman keep in his fob pocket?", a: ["Notebook", "Handkerchief", "Watch","TrungNghia"], correctAnswer: "Watch"),
        Questions(q: "How would one say goodbye in Spanish?", a: ["Au Revoir", "Adiós", "Salir","TruongSinh"], correctAnswer: "Adiós"),
        Questions(q: "Which of these colours is NOT featured in the logo for Google?", a: ["Green", "Orange", "Blue", "ThanhDuy"], correctAnswer: "Orange"),
        Questions(q: "What alcoholic drink is made from molasses?", a: ["Rum", "Whisky", "Gin","abc"], correctAnswer: "Rum"),
        Questions(q: "What type of animal was Harambe?", a: ["Panda", "Gorilla", "Crocodile","songoku"], correctAnswer: "Gorilla"),
        Questions(q: "Where is Tasmania located?", a: ["Indonesia", "Australia", "Scotland","naruto"], correctAnswer: "Australia"),
        Questions(q: "Where is question11?", a: ["Indonesia", "Australia", "Scotland","naruto"], correctAnswer: "Australia")
    ]

    func getQuestionText() -> String {
        return quiz[questionNumber].text
    }
    
    //Need a way of fetching the answer choices.
    func getAnswers() -> [String] {
        return quiz[questionNumber].answers
    }
    
    func getProgress() -> Float {
        return Float(questionNumber) / Float(quiz.count)
    }
    
    mutating func getScore() -> Int {
        return score
    }
    
    mutating func nextQuestion() {
        
        if questionNumber + 1 < quiz.count {
            questionNumber += 1
        } else {
            questionNumber = 0
        }
    }
    
    mutating func checkAnswer(userAnswer: String) -> Bool {
        //Need to change answer to rightAnswer here.
        if userAnswer == quiz[questionNumber].rightAnswer {
            score += 1
            return true
        } else {
            return false
        }
    }
}
