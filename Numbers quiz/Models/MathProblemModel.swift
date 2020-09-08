//
//  MathProblemModel.swift
//  Numbers quiz
//
//  Created by Stanislav Slipchenko on 27.07.2020.
//  Copyright © 2020 Stanislav Slipchenko. All rights reserved.
//

import Foundation

enum Operation: String {
    case subt = "-"
    case add = "+"
    case mult = "*"
    case div = "/"
}

class MathProblemModel {
    
    var leftNumber: Int = 0
    var rightNumber: Int = 0
    var operation: Operation?
    var result: Int = 0 {
        didSet {
            stringResult = String(result)
        }
    }
    var stringResult: String = ""
    var fullMathProblem: String?
    
    private func whatTheOperation() {
        
        var rand = 0
        rand = Int.random(in: 0...3)
        
        switch rand {
        case 0:
            operation = Operation.subt
        case 1:
            operation = Operation.add
        case 2:
            operation = Operation.mult
        case 3:
            operation = Operation.div
        default:
            break
        }
    }
    
    private func noZero(number : Int) -> Int {
        
        if number == 0 {
            return 1
        } else {
            return number
        }
    }
    
    private func generateFirstSecondNumbersNoDiv() {
        
        leftNumber = Int.random(in: 0...110)
        rightNumber = Int.random(in: 0...110)
    }
    private func generateFirstSecondNumbersForDiv() {
        leftNumber = noZero(number: (Int.random(in: 0...10)))
        rightNumber = leftNumber * noZero(number: (Int.random(in: 0...10)))
    }
    private func generateFirstSecondNumbersForMult() {
        
        leftNumber = noZero(number: Int.random(in: 0...10))
        rightNumber = noZero(number: Int.random(in: 0...10))
    }
    private func generateRandomNumbers() {
        switch operation {
        case .subt:
            generateFirstSecondNumbersNoDiv()
            
            if leftNumber >= rightNumber {
                result = leftNumber - rightNumber
            } else {
                result = rightNumber - leftNumber
            }
        case .add:
            generateFirstSecondNumbersNoDiv()
            
            result = leftNumber + rightNumber
        case .mult:
            generateFirstSecondNumbersForMult()
            
            result = leftNumber * rightNumber
        case .div:
            generateFirstSecondNumbersForDiv()
            
            result = rightNumber / leftNumber
        default:
            break
        }
    }
    
    private func makeFullMathProblem() {
        
        guard let operation = self.operation else {return}
        
        if operation == Operation.subt && leftNumber < rightNumber || operation == Operation.div {
            fullMathProblem = String(rightNumber) + operation.rawValue + String(leftNumber) + "  ="
        } else {
            fullMathProblem = String(leftNumber) + operation.rawValue + String(rightNumber) + "  ="
        }
    }
    
    func generateFullMathProblem() {
        whatTheOperation()
        generateRandomNumbers()
        makeFullMathProblem()
    }
}
