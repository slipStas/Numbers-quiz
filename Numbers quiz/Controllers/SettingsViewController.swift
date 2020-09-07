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
//        let stackView : UIStackView = {
//            let view = UIStackView()
//            return view
//        }()
//        self.view.addSubview(stackView)
//
//        stackView.translatesAutoresizingMaskIntoConstraints = false
//        stackView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor).isActive = true
//        stackView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor).isActive = true
//        stackView.topAnchor.constraint(equalTo: self.view.topAnchor).isActive = true
//        stackView.heightAnchor.constraint(equalToConstant: 150).isActive = true
        
        let difficultyLabel : UILabel = {
            let label = UILabel()
            label.text = "Choose the difficulty"

            return label
        }()
        self.view.addSubview(difficultyLabel)
        
        difficultyLabel.translatesAutoresizingMaskIntoConstraints = false
        difficultyLabel.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 8).isActive = true
        difficultyLabel.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: 8).isActive = true
        difficultyLabel.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 8).isActive = true
        difficultyLabel.heightAnchor.constraint(equalToConstant: 40).isActive = true
        
        let segmentControll : UISegmentedControl = {
            let control = UISegmentedControl()
            control.insertSegment(withTitle: "first", at: 0, animated: true)
            control.insertSegment(withTitle: "second", at: 1, animated: true)
            control.insertSegment(withTitle: "third", at: 2, animated: true)
            control.insertSegment(withTitle: "fourth", at: 3, animated: true)
            
            control.selectedSegmentIndex = 2

            control.backgroundColor = #colorLiteral(red: 0.9529411793, green: 0.6862745285, blue: 0.1333333403, alpha: 1)
            control.selectedSegmentTintColor = #colorLiteral(red: 0.6000000238, green: 0.6000000238, blue: 0.6000000238, alpha: 1)
            return control
        }()
        self.view.addSubview(segmentControll)

        segmentControll.translatesAutoresizingMaskIntoConstraints = false
        segmentControll.leadingAnchor.constraint(equalTo: self.view.leadingAnchor).isActive = true
        segmentControll.trailingAnchor.constraint(equalTo: self.view.trailingAnchor).isActive = true
        segmentControll.topAnchor.constraint(equalTo: difficultyLabel.bottomAnchor, constant: 8).isActive = true
        segmentControll.heightAnchor.constraint(equalToConstant: 50).isActive = true

    }
}
