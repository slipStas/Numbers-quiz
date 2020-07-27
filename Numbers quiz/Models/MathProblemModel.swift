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
    
    var leftNumber: Int?
    var rightNumber: Int?
    var operation: Operation?
    var result: Int?
    var fullMathProblem: String?
    
    private func whatTheOperation() {
        
        var rand : UInt32 = 0
        
        rand = arc4random_uniform(4)
        
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
        
        leftNumber = Int(arc4random_uniform(110))
        rightNumber = Int(arc4random_uniform(110))
    }
    private func generateFirstSecondNumbersForDiv() {
        leftNumber = noZero(number: (Int(arc4random_uniform(10))))
        
        guard let leftNumber = leftNumber else {return}
        
        rightNumber = leftNumber * noZero(number: (Int(arc4random_uniform(10))))
    }
    private func generateFirstSecondNumbersForMult() {
        
        leftNumber = noZero(number: Int(arc4random_uniform(10)))
        rightNumber = noZero(number: Int(arc4random_uniform(10)))
    }
    private func generateRandomNumbers() {
        
        guard let leftNumber = leftNumber else {return}
        guard let rightNumber = rightNumber else {return}
        
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
        guard let leftNumber = leftNumber else {return}
        guard let rightNumber = rightNumber else {return}
        
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
