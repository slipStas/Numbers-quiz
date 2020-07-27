//
//  MainViewController.swift
//  Numbers quiz
//
//  Created by Stanislav Slipchenko on 26.07.2020.
//  Copyright © 2020 Stanislav Slipchenko. All rights reserved.
//

import UIKit

class MainViewController: UIViewController {
    
    var viewModel: MainViewModel?
 
    @IBOutlet weak var taskLabel: UILabel!
    @IBOutlet weak var answerLabel: UILabel!
    
    @IBOutlet weak var startStopButton: NumberButtonModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        viewModel = MainViewModel(status: .start, startStopStatus: { [weak self] (status) in
            guard let self = self else {return}
            self.startStopButton.setTitle(status.rawValue, for: .normal)
        })
        
        prepareLabels()
        
        viewModel?.mathProblem = { [weak self] string in
            guard let self = self else {return}
            
            self.taskLabel.text = string
        }
        
    }
    
    @IBAction func startStop(_ sender: Any) {
        
        switch viewModel?.status {
        case .start:
            viewModel?.start()
        case .stop:
            viewModel?.stop()
        case .none:
            break
        }
        
        self.viewModel?.startStopStatus = { [weak self] status in
            self?.startStopButton.setTitle(status.rawValue, for: .normal)
        }
        
    }
    @IBAction func check(_ sender: Any) {
        viewModel?.check()
    }
    
    @IBAction func pressedButton(_ sender: UIButton) {
        guard var answerText = self.answerLabel.text else {return}
        
        answerText += sender.titleLabel?.text ?? ""
        self.answerLabel.text = answerText
    }
    
    func prepareLabels() {
        self.taskLabel.text = "For start press <Start> button"
        self.answerLabel.text?.removeAll()
    }
    
    
    

}
