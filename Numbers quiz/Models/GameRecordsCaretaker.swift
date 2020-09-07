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
    private let fileName = "records.data"
    
    var filePath: URL? {
        guard let filePath = FileManager.default.urls(for: .cachesDirectory, in: .userDomainMask).first else {return nil}
        
        return filePath.appendingPathComponent(fileName, isDirectory: false)
    }
    
    func saveResult(result: [GameResultModel]) throws{
        
        let data = try JSONEncoder().encode(result)
        try data.write(to: filePath!)
    }
    
    func loadResult() throws -> [GameResultModel] {
        
        let data = try Data(contentsOf: filePath!)
        
        return try JSONDecoder().decode([GameResultModel].self, from: data)
    }
}
