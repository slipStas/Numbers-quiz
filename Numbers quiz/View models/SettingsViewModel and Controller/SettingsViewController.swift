//
//  SettingsViewController.swift
//  Numbers quiz
//
//  Created by Stanislav Slipchenko on 07.09.2020.
//  Copyright © 2020 Stanislav Slipchenko. All rights reserved.
//

import UIKit

class SettingsViewController: UIViewController {
    
    private var difficultyArray: [Difficulty] = []
    
    var settingsViewModel : SettingsViewModel?
    
    let difficultyLabel = UILabel()
    let segmentedControl = SegmentedControlModel(frame: .zero, font: 20)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = .systemBackground
        
        addViews()
        
        settingsViewModel = SettingsViewModel(selectedIndex: { (index) in
            self.segmentedControl.selectedSegmentIndex = index
        })
        
        segmentedControl.addTarget(self, action: #selector(indexChanged(_:)), for: .valueChanged)
    }
    
    @objc func indexChanged(_ sender: UISegmentedControl) {
        sender.feedback()
        settingsViewModel?.saveDifficulty(index: self.segmentedControl.selectedSegmentIndex)
    }
    
    func addDifficultyLevels() {
        self.difficultyArray.append(contentsOf: [.easy, .normal, .hard, .expert])
    }
    
    func addViews() {
        addDifficultyLevels()
        
        difficultyLabel.font = UIFont.systemFont(ofSize: 20)
        difficultyLabel.text = "Choose the difficulty"
        self.view.addSubview(difficultyLabel)
        
        difficultyLabel.translatesAutoresizingMaskIntoConstraints = false
        difficultyLabel.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 8).isActive = true
        difficultyLabel.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -8).isActive = true
        difficultyLabel.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 8).isActive = true
        difficultyLabel.heightAnchor.constraint(equalToConstant: 44).isActive = true
        
        self.view.addSubview(self.segmentedControl)
        
        for (index, item) in self.difficultyArray.enumerated() {
            segmentedControl.insertSegment(withTitle: item.rawValue, at: index, animated: true)
        }
        segmentedControl.fontSegmentedControl = 20
        segmentedControl.translatesAutoresizingMaskIntoConstraints = false
        segmentedControl.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 8).isActive = true
        segmentedControl.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -8).isActive = true
        segmentedControl.topAnchor.constraint(equalTo: difficultyLabel.bottomAnchor, constant: 8).isActive = true
        segmentedControl.heightAnchor.constraint(equalToConstant: 44).isActive = true
    }
}
