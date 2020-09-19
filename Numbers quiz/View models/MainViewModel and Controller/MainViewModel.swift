//
//  MainViewModel.swift
//  Numbers quiz
//
//  Created by Stanislav Slipchenko on 26.07.2020.
//  Copyright © 2020 Stanislav Slipchenko. All rights reserved.
//

import Foundation
import UIKit

enum StartStopStatusEnum: String {
    case start = "Start"
    case stop = "Stop"
}

protocol MainViewModelInput {
    func start()
    func stop()
    func check(time: String)
    func finish()
}

protocol MainViewModelOutput {
    var mathProblem: ((String) -> Void)? {get set}
    var startStopStatus: ((StartStopStatusEnum) -> Void)? {get set}
    var correctAnswerStatus: ((Bool) -> Void)? {get set}
    var trueAnswers: ((Int) -> Void) {get set}
    var falseAnswers: ((Int) -> Void) {get set}
}

class MainViewModel: MainViewModelInput, MainViewModelOutput {
    
    public weak var gameDelegate: MainSceneDelegate?
    
    var trueAnswers: ((Int) -> Void)
    var falseAnswers: ((Int) -> Void)
    var correctAnswerStatus: ((Bool) -> Void)?
    var startStopStatus: ((StartStopStatusEnum) -> Void)?
    var mathProblem: ((String) -> Void)?
    
    init(status: StartStopStatusEnum, startStopStatus: @escaping (StartStopStatusEnum) -> Void, trueAnswers: @escaping ((Int) -> Void), falseAnswers: @escaping ((Int) -> Void)) {
        self.statusStartStop = status
        self.startStopStatus = startStopStatus
        self.trueAnswers = trueAnswers
        self.falseAnswers = falseAnswers
        startStopStatus(status)
        trueAnswers(countTrueAnswers)
        falseAnswers(countFalseAnswers)
    }
    
    private let difficultyStrategyFacade = DifficultyStrategyFacade()
    
    var math = MathProblemModel()
    var solutionsArray = GameResultModel(trueAnswers: 0, falseAnswers: 0, date: Date(), difficulty: "", mathSolutions: [])
    var countTrueAnswers = 0 {
        didSet {
            trueAnswers(countTrueAnswers)
        }
    }
    var countFalseAnswers = 0 {
        didSet {
            falseAnswers(countFalseAnswers)
        }
    }
    var statusStartStop: StartStopStatusEnum {
        didSet {
            startStopStatus?(statusStartStop)
        }
    }
    var readyMathProblem = "" {
        didSet {
            mathProblem?(readyMathProblem)
        }
    }
    var answerStatus = false {
        didSet {
            correctAnswerStatus?(answerStatus)
            switch answerStatus {
            case true:
                countTrueAnswers += 1
            case false:
                countFalseAnswers += 1
            }
        }
    }
    
    func start() {
        
        difficultyStrategyFacade.configuredFor(math: math)
        
        math.generateFullMathProblem()
        readyMathProblem = math.fullMathProblem ?? "error"
        statusStartStop = .stop
    }
    
    func check(time: String) {
        
        var userAnswer = Session.shared.userAnswer
        
        if Session.shared.userAnswer == math.stringResult {
            print("bingo!")
            Session.shared.userAnswer.removeAll()
            answerStatus = true
            solutionsArray.trueAnswers += 1
            userAnswer += " : " + time + " sec."
            
            let solutions = MathSolution()
            solutions.solution = (math.fullMathProblem ?? "no math") + " " + userAnswer
            solutions.isCorrect = true
            
            solutionsArray.mathSolutions.append(solutions)
            start()
        } else {
            Session.shared.userAnswer.removeAll()
            answerStatus = false
            solutionsArray.falseAnswers += 1
            userAnswer += "(" + math.stringResult + ") : " + time + " sec."
            
            let solutions = MathSolution()
            solutions.solution = (math.fullMathProblem ?? "no math") + " " + userAnswer
            solutions.isCorrect = false
            
            solutionsArray.mathSolutions.append(solutions)
            start()
        }
        
        solutionsArray.date = Date()
    }
    
    func stop() {
        readyMathProblem = math.fullMathProblem ?? "no math problem"
        statusStartStop = .start
        Session.shared.userAnswer.removeAll()
    }
    
    func finish() {
        try? self.gameDelegate?.didEndGame(gameResult: solutionsArray) 
    }
}
