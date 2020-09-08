//
//  MathCreationStrategy.swift
//  Numbers quiz
//
//  Created by Stanislav Slipchenko on 08.09.2020.
//  Copyright © 2020 Stanislav Slipchenko. All rights reserved.
//

import Foundation

protocol MathCreationStrategy {
    func noZero(number : Int) -> Int
    func whatTheOperation() -> Operation
    func generateFirstSecondNumbersNoDiv() -> MathNumbers
    func generateFirstSecondNumbersForMult() -> MathNumbers
    func generateFirstSecondNumbersForDiv() -> MathNumbers
}

struct EasyMathCreationStrategy: MathCreationStrategy {
    func noZero(number: Int) -> Int {
        if number == 0 {
            return 1
        } else {
            return number
        }
    }
    
    func whatTheOperation() -> Operation {
        
        var operation: Operation?
        var rand = 0
        rand = Int.random(in: 0...1)
        
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
        
        guard let returningOperation = operation else {return Operation.subt}
        
        return returningOperation
    }
    
    func generateFirstSecondNumbersNoDiv() -> MathNumbers {
        
        let numbers = MathNumbers()
        numbers.leftNumber = Int.random(in: 0...20)
        numbers.rightNumber = Int.random(in: 0...20)
        
        return numbers
    }
    func generateFirstSecondNumbersForMult() -> MathNumbers {
        let numbers = MathNumbers()
        return numbers
    }
    func generateFirstSecondNumbersForDiv() -> MathNumbers {
        let numbers = MathNumbers()
        return numbers
    }
}

struct NormalMathCreationStrategy: MathCreationStrategy {
    func noZero(number: Int) -> Int {
        if number == 0 {
            return 1
        } else {
            return number
        }
    }
    
    func whatTheOperation() -> Operation {
        
        var operation: Operation?
        var rand = 0
        rand = Int.random(in: 0...2)
        
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
        
        guard let returningOperation = operation else {return Operation.subt}
        
        return returningOperation
    }
    func generateFirstSecondNumbersNoDiv() -> MathNumbers {
        
        let numbers = MathNumbers()
        numbers.leftNumber = Int.random(in: 0...50)
        numbers.rightNumber = Int.random(in: 0...50)
        
        return numbers
    }
    func generateFirstSecondNumbersForMult() -> MathNumbers {
        
        let numbers = MathNumbers()

        numbers.leftNumber = noZero(number: Int.random(in: 0...5))
        numbers.rightNumber = noZero(number: Int.random(in: 0...5))
        
        return numbers
    }
    func generateFirstSecondNumbersForDiv() -> MathNumbers {
        let numbers = MathNumbers()
        return numbers
    }
}

struct HardMathCreationStrategy: MathCreationStrategy {
    func noZero(number: Int) -> Int {
        if number == 0 {
            return 1
        } else {
            return number
        }
    }
    
    func whatTheOperation() -> Operation {
        
        var operation: Operation?
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
        
        guard let returningOperation = operation else {return Operation.subt}
        
        return returningOperation
    }
    func generateFirstSecondNumbersNoDiv() -> MathNumbers {
        
        let numbers = MathNumbers()
        numbers.leftNumber = Int.random(in: 0...100)
        numbers.rightNumber = Int.random(in: 0...100)
        
        return numbers
    }
    func generateFirstSecondNumbersForMult() -> MathNumbers {
        
        let numbers = MathNumbers()

        numbers.leftNumber = noZero(number: Int.random(in: 0...10))
        numbers.rightNumber = noZero(number: Int.random(in: 0...10))
        
        return numbers
    }
    func generateFirstSecondNumbersForDiv() -> MathNumbers {
        
        let numbers = MathNumbers()

        numbers.leftNumber = noZero(number: (Int.random(in: 0...10)))
        numbers.rightNumber = numbers.leftNumber * noZero(number: (Int.random(in: 0...10)))
        
        return numbers
    }
}

struct ExpertMathCreationStrategy: MathCreationStrategy {
    func noZero(number: Int) -> Int {
        if number == 0 {
            return 1
        } else {
            return number
        }
    }
    
    func whatTheOperation() -> Operation {
        
        var operation: Operation?
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
        
        guard let returningOperation = operation else {return Operation.subt}
        
        return returningOperation
    }
    func generateFirstSecondNumbersNoDiv() -> MathNumbers {
        
        let numbers = MathNumbers()
        numbers.leftNumber = Int.random(in: 0...200)
        numbers.rightNumber = Int.random(in: 0...200)
        
        return numbers
    }
    func generateFirstSecondNumbersForMult() -> MathNumbers {
        let numbers = MathNumbers()

        numbers.leftNumber = noZero(number: Int.random(in: 0...15))
        numbers.rightNumber = noZero(number: Int.random(in: 0...15))
        
        return numbers
    }
    func generateFirstSecondNumbersForDiv() -> MathNumbers {
        
        let numbers = MathNumbers()

        numbers.leftNumber = noZero(number: (Int.random(in: 0...15)))
        numbers.rightNumber = numbers.leftNumber * noZero(number: (Int.random(in: 0...15)))
        
        return numbers
    }
}

