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
    
    @IBOutlet weak var countTrueAnswersLabel: UILabel!
    @IBOutlet weak var countFalseAnswersLabel: UILabel!
    
    @IBOutlet weak var startStopButton: NumberButtonModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        viewModel = MainViewModel(status: .start, startStopStatus: { [weak self] (status) in
            
        guard let self = self else {return}
            
        self.startStopButton.setTitle(status.rawValue, for: .normal)
            }, trueAnswers: { [weak self] (trueAnswers) in
                self?.animateAnswerCounter(label: (self?.countTrueAnswersLabel)!, options: .transitionFlipFromBottom)
                self?.countTrueAnswersLabel.text = String(trueAnswers)
            }, falseAnswers: { [weak self] (falseAnswers) in
                self?.animateAnswerCounter(label: (self?.countFalseAnswersLabel)!, options: .transitionFlipFromBottom)
                self?.countFalseAnswersLabel.text = String(falseAnswers)
        })
        
        prepareLabels()
        
        viewModel?.mathProblem = { [weak self] string in
            guard let self = self else {return}
            
            self.taskLabel.text = string
        }
        
    }
    
    @IBAction func backspaseButton(_ sender: UIButton) {
        
        sender.feedback()
        if (answerLabel.text?.count)! > 0 && Session.shared.userAnswer.count > 0 {
            answerLabel.text!.removeLast()
            Session.shared.userAnswer.removeLast()
        }
    }
    
    @IBAction func startStop(_ sender: UIButton) {
        
        sender.feedback()
        switch viewModel?.statusStartStop {
        case .start:
            viewModel?.start()
            self.animateAnswerCounter(label: self.taskLabel, options: .transitionFlipFromBottom)
        case .stop:
            viewModel?.stop()
        case .none:
            break
        }
        
        self.viewModel?.startStopStatus = { [weak self] status in
            self?.startStopButton.setTitle(status.rawValue, for: .normal)
        }
        
    }
    
    @IBAction func check(_ sender: UIButton) {
        
        sender.feedback()
        viewModel?.check()
        self.answerLabel.text?.removeAll()
        self.animateAnswerCounter(label: self.taskLabel, options: .transitionFlipFromBottom)
    }
    
    @IBAction func pressedButton(_ sender: UIButton) {
        guard var answerText = self.answerLabel.text else {return}
        
        answerText += sender.titleLabel?.text ?? ""
        self.answerLabel.text = answerText
    }
    
    func prepareLabels() {
        self.taskLabel.text = "For start press <Start> button"
        self.answerLabel.text?.removeAll()
        self.taskLabel.font = UIFont.systemFont(ofSize: 20)
        self.answerLabel.font = UIFont.systemFont(ofSize: 20)
        self.countTrueAnswersLabel.textColor = #colorLiteral(red: 0.3411764801, green: 0.6235294342, blue: 0.1686274558, alpha: 1)
        self.countFalseAnswersLabel.textColor = #colorLiteral(red: 0.9254902005, green: 0.2352941185, blue: 0.1019607857, alpha: 1)
        self.countTrueAnswersLabel.font = UIFont.systemFont(ofSize: 35)
        self.countFalseAnswersLabel.font = UIFont.systemFont(ofSize: 35)
    }
    
    func animateAnswerCounter(label: UILabel, options: UIView.AnimationOptions) {
        UIView.transition(with: label, duration: 0.7, options: options, animations: {})
    }
}


