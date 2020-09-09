//
//  DifficultyStrategyFacade.swift
//  Numbers quiz
//
//  Created by Stanislav Slipchenko on 09.09.2020.
//  Copyright © 2020 Stanislav Slipchenko. All rights reserved.
//

import Foundation

class DifficultyStrategyFacade {
    
    func configuredFor(math: MathProblemModel) {
        
        switch math.difficulty {
        case 0:
            math.mathCreationStrategy = EasyMathCreationStrategy()
        case 1:
            math.mathCreationStrategy = NormalMathCreationStrategy()
        case 2:
            math.mathCreationStrategy = HardMathCreationStrategy()
        case 3:
            math.mathCreationStrategy = ExpertMathCreationStrategy()
        default:
            break
        }
    }
}
