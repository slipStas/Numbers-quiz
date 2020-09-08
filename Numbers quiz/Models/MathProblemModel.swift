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
class MathNumbers {
    var leftNumber: Int = 0
    var rightNumber: Int = 0
}

class MathProblemModel {
    
    var numbers = MathNumbers()
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
        
        numbers.leftNumber = Int.random(in: 0...110)
        numbers.rightNumber = Int.random(in: 0...110)
    }
    private func generateFirstSecondNumbersForDiv() {
        numbers.leftNumber = noZero(number: (Int.random(in: 0...10)))
        numbers.rightNumber = numbers.leftNumber * noZero(number: (Int.random(in: 0...10)))
    }
    private func generateFirstSecondNumbersForMult() {
        
        numbers.leftNumber = noZero(number: Int.random(in: 0...10))
        numbers.rightNumber = noZero(number: Int.random(in: 0...10))
    }
    private func generateRandomNumbers() {
        switch operation {
        case .subt:
            generateFirstSecondNumbersNoDiv()
            
            if numbers.leftNumber >= numbers.rightNumber {
                result = numbers.leftNumber - numbers.rightNumber
            } else {
                result = numbers.rightNumber - numbers.leftNumber
            }
        case .add:
            generateFirstSecondNumbersNoDiv()
            
            result = numbers.leftNumber + numbers.rightNumber
        case .mult:
            generateFirstSecondNumbersForMult()
            
            result = numbers.leftNumber * numbers.rightNumber
        case .div:
            generateFirstSecondNumbersForDiv()
            
            result = numbers.rightNumber / numbers.leftNumber
        default:
            break
        }
    }
    
    private func makeFullMathProblem() {
        
        guard let operation = self.operation else {return}
        
        if operation == Operation.subt && numbers.leftNumber < numbers.rightNumber || operation == Operation.div {
            fullMathProblem = String(numbers.rightNumber) + operation.rawValue + String(numbers.leftNumber) + "  ="
        } else {
            fullMathProblem = String(numbers.leftNumber) + operation.rawValue + String(numbers.rightNumber) + "  ="
        }
    }
    
    func generateFullMathProblem() {
        whatTheOperation()
        generateRandomNumbers()
        makeFullMathProblem()
    }
}
