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
}

protocol MainViewModelOutput {
    var mathProblem: ((String) -> Void)? {get set}
    var startStopStatus: ((StartStopStatus) -> Void)? {get set}
}

class MainViewModel: MainViewModelInput, MainViewModelOutput {
    var startStopStatus: ((StartStopStatus) -> Void)?
    var mathProblem: ((String) -> Void)?
    
    init(status: StartStopStatus, startStopStatus: @escaping (StartStopStatus) -> Void) {
        self.status = status
        self.startStopStatus = startStopStatus
        startStopStatus(status)
    }
    
    var math = MathProblemModel()
    
    var status: StartStopStatus {
        didSet {
            print(status.rawValue)
            startStopStatus?(status)
        }
    }
    var readyMathProblem = "" {
        didSet {
            mathProblem?(readyMathProblem)
        }
    }
    
    func start() {
        math.generateFullMathProblem()
        readyMathProblem = math.fullMathProblem ?? "error"
        status = .stop
    }
    
    func check() {
        print("check")
        
        if Session.shared.userAnswer == math.stringResult {
            print("bingo!")
        }
    }
    
    func stop() {
        readyMathProblem = "stopped" 
        status = .start
    }
    
}
