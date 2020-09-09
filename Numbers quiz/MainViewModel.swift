//
//  MainViewModel.swift
//  Numbers quiz
//
//  Created by Stanislav Slipchenko on 26.07.2020.
//  Copyright © 2020 Stanislav Slipchenko. All rights reserved.
//

import Foundation

enum StartStopStatus: String {
    case start = "Start"
    case stop = "Stop"
}

protocol MainViewModelInput {
    func start()
    func stop()
    func check()
    func finish()
}

protocol MainViewModelOutput {
    var mathProblem: ((String) -> Void)? {get set}
    var startStopStatus: ((StartStopStatus) -> Void)? {get set}
    var correctAnswerStatus: ((Bool) -> Void)? {get set}
    var trueAnswers: ((Int) -> Void) {get set}
    var falseAnswers: ((Int) -> Void) {get set}

}

class MainViewModel: MainViewModelInput, MainViewModelOutput {
    
    public weak var gameDelegate: MainSceneDelegate?
    
    var trueAnswers: ((Int) -> Void)
    var falseAnswers: ((Int) -> Void)
    var correctAnswerStatus: ((Bool) -> Void)?
    var startStopStatus: ((StartStopStatus) -> Void)?
    var mathProblem: ((String) -> Void)?
    
    init(status: StartStopStatus, startStopStatus: @escaping (StartStopStatus) -> Void, trueAnswers: @escaping ((Int) -> Void), falseAnswers: @escaping ((Int) -> Void)) {
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
    var statusStartStop: StartStopStatus {
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
    
    func check() {
        
        if Session.shared.userAnswer == math.stringResult {
            print("bingo!")
            Session.shared.userAnswer.removeAll()
            answerStatus = true
            start()
        } else {
            answerStatus = false
            stop()
        }
    }
    
    func stop() {
        readyMathProblem = "stopped" 
        statusStartStop = .start
        Session.shared.userAnswer.removeAll()
    }
    
    func finish() {
        try? self.gameDelegate?.didEndGame(trueAnswerCount: countTrueAnswers, falseAnswerCount: countFalseAnswers, averageTime: "0:00:00")
    }
}
