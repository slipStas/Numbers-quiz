//
//  GameResultModel.swift
//  Numbers quiz
//
//  Created by Stanislav Slipchenko on 08.08.2020.
//  Copyright © 2020 Stanislav Slipchenko. All rights reserved.
//

import Foundation

class MathSolution: Codable {
    var solution: String?
    var isCorrect: Bool?
}

struct GameResultModel: Codable {
    var trueAnswers: Int
    var falseAnswers: Int
    var date: Date
    var difficulty: String
    var mathSolutions: [MathSolution]
}
