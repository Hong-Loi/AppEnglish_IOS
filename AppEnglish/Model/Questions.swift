//
//  Questions.swift
//  AppEnglish
//
//  Created by CNTT on 6/5/21.
//  Copyright © 2021 fit.tdc.vn. All rights reserved.
//

import Foundation

struct Questions {
    let text: String
    
    //Multiple choice questions have multiple answers, an Array of Strings would work for our quiz data.
    let answers: [String]
    //Look at the data in the quiz array, there is a seperate string that is the correctAnswer.
    let rightAnswer: String
    
    //The initialiser needs to be updated to match the new multiple choice quiz data.
    init(q: String, a: [String], correctAnswer: String) {
        text = q
        answers = a
        rightAnswer = correctAnswer
    }
}
