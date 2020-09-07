//
//  SettingsViewController.swift
//  Numbers quiz
//
//  Created by Stanislav Slipchenko on 07.09.2020.
//  Copyright © 2020 Stanislav Slipchenko. All rights reserved.
//

import UIKit

class SettingsViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = .systemBackground
        
        addViews()
    }

    func addViews() {
        
        let difficultyLabel : UILabel = {
            let label = UILabel()
            label.font = UIFont.systemFont(ofSize: 20)
            label.text = "Choose the difficulty"

            return label
        }()
        self.view.addSubview(difficultyLabel)
        
        difficultyLabel.translatesAutoresizingMaskIntoConstraints = false
        difficultyLabel.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 8).isActive = true
        difficultyLabel.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -8).isActive = true
        difficultyLabel.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 8).isActive = true
        difficultyLabel.heightAnchor.constraint(equalToConstant: 44).isActive = true
        
        let segmentControll : UISegmentedControl = {
            let control = UISegmentedControl()
            let font : [AnyHashable : Any] = [NSAttributedString.Key.font : UIFont.systemFont(ofSize: 20)]
            
            control.setTitleTextAttributes((font as! [NSAttributedString.Key : Any]), for: .normal)
            control.insertSegment(withTitle: "first", at: 0, animated: true)
            control.insertSegment(withTitle: "second", at: 1, animated: true)
            control.insertSegment(withTitle: "third", at: 2, animated: true)
            control.insertSegment(withTitle: "fourth", at: 3, animated: true)
            
            control.selectedSegmentIndex = 2

            control.backgroundColor = .myOrange
            control.selectedSegmentTintColor = .myGray
            return control
        }()
        self.view.addSubview(segmentControll)

        segmentControll.translatesAutoresizingMaskIntoConstraints = false
        segmentControll.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 8).isActive = true
        segmentControll.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -8).isActive = true
        segmentControll.topAnchor.constraint(equalTo: difficultyLabel.bottomAnchor, constant: 8).isActive = true
        segmentControll.heightAnchor.constraint(equalToConstant: 44).isActive = true

    }
}
