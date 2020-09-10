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
    
    var mathCreationStrategy : MathCreationStrategy?
    var difficulty = Session.shared.defaults.integer(forKey: "difficulty")
    
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
        
        operation = mathCreationStrategy?.whatTheOperation()
    }
    
    private func generateFirstSecondNumbersNoDiv() {
        
        guard let generateNumbersNoDiv = mathCreationStrategy?.generateFirstSecondNumbersNoDiv() else {return}
        numbers = generateNumbersNoDiv
    }
    private func generateFirstSecondNumbersForDiv() {
        
        guard let generateNumbersNoDiv = mathCreationStrategy?.generateFirstSecondNumbersForDiv() else {return}
        numbers = generateNumbersNoDiv
    }
    private func generateFirstSecondNumbersForMult() {
        
        guard let generateNumbersNoDiv = mathCreationStrategy?.generateFirstSecondNumbersForMult() else {return}
        numbers = generateNumbersNoDiv
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
