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
    
    init(status: StartStopStatus, startStopStatus: ((StartStopStatus) -> Void)) {
        self.status = status
        startStopStatus(status)
    }
    
    var leftNumber: Int = 0
    var rightNumber: Int = 0
    var operation = ""
    var result: Int = 0
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
        readyMathProblem = "12 + 4 =" // for debbug
        status = .stop
    }
    
    func check() {
        print("check")
    }
    
    func stop() {
        readyMathProblem = "stopped" // for debbug
        status = .start
    }
    
    
}
