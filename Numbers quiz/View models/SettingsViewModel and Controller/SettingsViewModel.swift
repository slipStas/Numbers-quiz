//
//  SettingsViewModel.swift
//  Numbers quiz
//
//  Created by Stanislav Slipchenko on 10.09.2020.
//  Copyright © 2020 Stanislav Slipchenko. All rights reserved.
//

import Foundation

protocol SettingsViewModelInput {
    func saveDifficulty(index: Int)
}

protocol SettingsViewModelOutput {
    var selectedIndexOfDifficultyControl: ((Int) -> Void) {get set}
}

class SettingsViewModel: SettingsViewModelOutput, SettingsViewModelInput {
    
    var selectedIndexOfDifficultyControl: ((Int) -> Void)
    
    init(selectedIndex: @escaping ((Int) -> Void)) {
        selectedIndexOfDifficultyControl = selectedIndex
        selectedIndex(self.selectedIndex)
    }
    
    var selectedIndex = Session.shared.defaults.integer(forKey: "difficulty") {
        didSet {
            selectedIndexOfDifficultyControl(selectedIndex)
        }
    }
    
    func saveDifficulty(index: Int) {
        switch index {
        case 0...index:
            Session.shared.defaults.setValue(index, forKey: "difficulty")
        default:
            break
        }
    }
}
