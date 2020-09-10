//
//  Session.swift
//  Numbers quiz
//
//  Created by Stanislav Slipchenko on 27.07.2020.
//  Copyright © 2020 Stanislav Slipchenko. All rights reserved.
//

import Foundation

class Session {
    static let shared = Session()
    private init() {}
    
    var userAnswer = String()
    
    let defaults = UserDefaults.standard
}
