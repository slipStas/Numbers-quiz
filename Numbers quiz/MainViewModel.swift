//
//  MainViewModel.swift
//  Numbers quiz
//
//  Created by Stanislav Slipchenko on 26.07.2020.
//  Copyright © 2020 Stanislav Slipchenko. All rights reserved.
//

import Foundation

protocol MainViewModelInput {
    func start()
    func check()
    func stop()
}

protocol MainViewModelOutput {
    var mathProblem: ((String) -> Void)? {get set}
}

class MainViewModel: MainViewModelInput, MainViewModelOutput {
    
    var mathProblem: ((String) -> Void)?
    
    
    var leftNumber: Int = 0
    var rightNumber: Int = 0
    var operation = ""
    var result: Int = 0
    var readyMathProblem = "" {
        didSet {
            mathProblem?(readyMathProblem)
        }
    }
    
    func start() {
        print("start")
        readyMathProblem = "12 + 4 =" // for debbug
    }
    
    func check() {
        print("check")
    }
    
    func stop() {
        print("stop")
    }
    
    
}
