//
//  GameRecordsCaretaker.swift
//  Numbers quiz
//
//  Created by Stanislav Slipchenko on 08.08.2020.
//  Copyright © 2020 Stanislav Slipchenko. All rights reserved.
//

import Foundation

class GameRecordsCaretaker {
    
    static let shared = GameRecordsCaretaker()
    
    func saveResult(result: GameResultModel) {
        
    }
    
    func loadResult() -> [GameResultModel] {
        
        let result = GameResultModel(value: 11, date: Date())
        var resultsArray: [GameResultModel] = []
        resultsArray.append(result)
        return resultsArray
    }
}
