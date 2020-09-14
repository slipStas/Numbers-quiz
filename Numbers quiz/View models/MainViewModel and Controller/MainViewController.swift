//
//  MainViewController.swift
//  Numbers quiz
//
//  Created by Stanislav Slipchenko on 26.07.2020.
//  Copyright © 2020 Stanislav Slipchenko. All rights reserved.
//

import UIKit

class MainViewController: UIViewController {
    
    var viewModel: MainViewModel? {
        didSet {
            switch viewModel?.statusStartStop {
            case .start:
                viewModel?.start()
                self.animateAnswerCounter(label: self.taskLabel, options: .transitionFlipFromBottom)

                if timerModel.timerCounter < 10.0 {
                    timerModel.resumeAnimation()
                } else {
                    timerModel.startAllNeedsAnimations(duration: 10, color: UIColor.myRed.cgColor)
                }
                timerModel.startTimer()
                isNumberButtonsEnable = true
            case .stop:
                viewModel?.stop()

                if timerModel.timerCounter < 10.0 {
                    timerModel.pauseTimer()
                    timerModel.pauseAnimation()
                }

                isNumberButtonsEnable = false
            case .none:
                break
            }
        }
    }
    
    var isNumberButtonsEnable : Bool? {
        didSet {
            disableEnableButtons(sender: numberButtons, isEnable: isNumberButtonsEnable ?? false)
        }
    }
    var enableDisableButtonsNumbersView = UIView()
    
    @IBOutlet weak var taskLabel: UILabel!
    @IBOutlet weak var answerLabel: UILabel!
    
    @IBOutlet weak var countTrueAnswersLabel: UILabel!
    @IBOutlet weak var countFalseAnswersLabel: UILabel!
    
    @IBOutlet weak var numberButtons: UIStackView!
    @IBOutlet weak var startStopButton: NumberButtonModel!
        
    @IBOutlet weak var checkButton: NumberButtonModel!
    
    @IBOutlet weak var timerModel: TimerModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        viewModel = MainViewModel(status: .stop, startStopStatus: { [weak self] (status) in
        guard let self = self else {return}
        self.startStopButton.setTitle(status.rawValue, for: .normal)
            }, trueAnswers: { [weak self] (trueAnswers) in
                self?.animateAnswerCounter(label: (self?.countTrueAnswersLabel)!, options: .transitionFlipFromBottom)
                self?.countTrueAnswersLabel.text = String(trueAnswers)
            }, falseAnswers: { [weak self] (falseAnswers) in
                self?.animateAnswerCounter(label: (self?.countFalseAnswersLabel)!, options: .transitionFlipFromBottom)
                self?.countFalseAnswersLabel.text = String(falseAnswers)
        })
        
        viewModel?.gameDelegate = self
        isNumberButtonsEnable = false
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
        
        switch viewModel?.statusStartStop {
        case .start:
            viewModel?.start()
            self.animateAnswerCounter(label: self.taskLabel, options: .transitionFlipFromBottom)
            
            if timerModel.timerCounter < 10.0 {
                timerModel.resumeAnimation()
            } else {
                timerModel.startAllNeedsAnimations(duration: 10, color: UIColor.myRed.cgColor)
            }
            timerModel.startTimer()
            isNumberButtonsEnable = true
        case .stop:
            viewModel?.stop()

            timerModel.pauseTimer()
            timerModel.pauseAnimation()
            isNumberButtonsEnable = false
        case .none:
            break
        }
        
        sender.feedback()
        
        self.viewModel?.startStopStatus = { [weak self] status in
            self?.startStopButton.setTitle(status.rawValue, for: .normal)
        }
    }
    
    @IBAction func check(_ sender: UIButton) {
        
        sender.feedback()
        timerModel.pauseTimer()
        timerModel.pauseAnimation()
        
        viewModel?.check()
                
        self.answerLabel.text?.removeAll()
        self.animateAnswerCounter(label: self.taskLabel, options: .transitionFlipFromBottom)
    }
    
    @IBAction func pressedButton(_ sender: UIButton) {
        guard var answerText = self.answerLabel.text else {return}
        
        answerText += sender.titleLabel?.text ?? ""
        self.answerLabel.text = answerText
    }
    
    @IBAction func finishGame(_ sender: Any) {
        viewModel?.finish()
    }
    
    func prepareLabels() {
        self.taskLabel.text = "Press <Start> button"
        self.answerLabel.text?.removeAll()
        self.taskLabel.font = UIFont.systemFont(ofSize: 20)
        self.answerLabel.font = UIFont.systemFont(ofSize: 20)
        self.countTrueAnswersLabel.textColor = .myGreen
        self.countFalseAnswersLabel.textColor = .myRed
        self.countTrueAnswersLabel.font = UIFont.systemFont(ofSize: 35)
        self.countFalseAnswersLabel.font = UIFont.systemFont(ofSize: 35)
    }
    
    func disableEnableButtons(sender: UIView, isEnable: Bool?) {
        
        sender.addSubview(self.enableDisableButtonsNumbersView)
        guard let isEnable = isEnable else {return}
        switch isEnable {
        case true:
            self.enableDisableButtonsNumbersView.frame = .zero
            checkButton.isEnabled = true
        case false:
            self.enableDisableButtonsNumbersView.frame = sender.bounds
            checkButton.isEnabled = false
        }
    }
    
    func animateAnswerCounter(label: UILabel, options: UIView.AnimationOptions) {
        UIView.transition(with: label, duration: 0.2, options: options, animations: {})
    }
}

extension MainViewController: MainSceneDelegate {
    
    func didEndGame(trueAnswerCount: Int, falseAnswerCount: Int, averageTime: String) throws {
        var records = (try? GameRecordsCaretaker.shared.loadResult()) ?? []
        let newRecord = GameResultModel(trueAnswers: trueAnswerCount, falseAnswers: falseAnswerCount, date: Date())
        records.append(newRecord)
        try? GameRecordsCaretaker.shared.saveResult(result: records)
        
        self.dismiss(animated: true, completion: nil)
        print("game over")
        print("your result:")
        print("true answers count - \(trueAnswerCount), false answer count - \(falseAnswerCount), average time - \(averageTime)")
    }
}
