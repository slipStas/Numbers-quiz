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
    
    let difficultyLabel = UILabel()
    let segmentedControl = UISegmentedControl()
    
    let defaults = UserDefaults.standard
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = .systemBackground
        
        addViews()
        
        segmentedControl.selectedSegmentIndex = defaults.integer(forKey: "difficulty")
        segmentedControl.addTarget(self, action: #selector(indexChanged(_:)), for: .valueChanged)
    }
    
    @objc func indexChanged(_ sender: UISegmentedControl) {
        switch segmentedControl.selectedSegmentIndex {
        case 0:
            defaults.setValue(0, forKey: "difficulty")
        case 1:
            defaults.setValue(1, forKey: "difficulty")
        case 2:
            defaults.setValue(2, forKey: "difficulty")
        case 3:
            defaults.setValue(3, forKey: "difficulty")
        default:
            break
        }
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
        
        let font : [AnyHashable : Any] = [NSAttributedString.Key.font : UIFont.systemFont(ofSize: 20)]
        
        segmentedControl.setTitleTextAttributes((font as! [NSAttributedString.Key : Any]), for: .normal)
        segmentedControl.backgroundColor = .myOrange
        segmentedControl.selectedSegmentTintColor = .myGray
        self.view.addSubview(self.segmentedControl)
        
        for (index, item) in self.difficultyArray.enumerated() {
            segmentedControl.insertSegment(withTitle: item.rawValue, at: index, animated: true)
        }
        
        segmentedControl.translatesAutoresizingMaskIntoConstraints = false
        segmentedControl.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 8).isActive = true
        segmentedControl.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -8).isActive = true
        segmentedControl.topAnchor.constraint(equalTo: difficultyLabel.bottomAnchor, constant: 8).isActive = true
        segmentedControl.heightAnchor.constraint(equalToConstant: 44).isActive = true
        
    }
}
