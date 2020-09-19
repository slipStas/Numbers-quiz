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
    
    var isGameEnd = false
    
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
    @IBOutlet weak var animateConsole: AnimateConsole!
    
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
        
        self.viewModel?.startStopStatus = { [weak self] status in
            
            self?.startStopButton.setTitle(status.rawValue, for: .normal)
            self?.startStopButton.isEnabled = false
        }
                
        switch viewModel?.statusStartStop {
        case .start:
            viewModel?.start()
            isNumberButtonsEnable = true
        case .stop:
            viewModel?.stop()
            isNumberButtonsEnable = false
        case .none:
            break
        }
        
        
        if !isGameEnd {
            self.timerModel.startTimer()
            self.timerModel.startAllNeedsAnimations(duration: 1)
        }
        sender.feedback()
    }
    
    @IBAction func check(_ sender: UIButton) {
        
        animateConsole.animateLabel.text = viewModel?.math.result.description

        sender.feedback()
        viewModel?.check(time: String(timerModel.timerCounter))
                
        self.answerLabel.text?.removeAll()
        self.animateAnswerCounter(label: self.taskLabel, options: .transitionFlipFromBottom)
                
        animateConsole.animateLabel(duration: 0.5)
        
        timerModel.stopTimer()
        
        timerModel.startTimer()
        
    }
    
    @IBAction func pressedButton(_ sender: UIButton) {
        guard var answerText = self.answerLabel.text else {return}
        
        answerText += sender.titleLabel?.text ?? ""
        self.answerLabel.text = answerText
    }
    
    @IBAction func finishGame(_ sender: Any) {
        viewModel?.finish()
        timerModel.stopTimer()
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
    
    func didEndGame(gameResult: GameResultModel) throws {
        var records = (try? GameRecordsCaretaker.shared.loadResult()) ?? []
        guard let difficulty = viewModel?.math.difficulty else {return}
        
        var difficultyString = ""
        switch difficulty {
        case 0:
            difficultyString = Difficulty.easy.rawValue
        case 1:
            difficultyString = Difficulty.normal.rawValue
        case 2:
            difficultyString = Difficulty.hard.rawValue
        case 3:
            difficultyString = Difficulty.expert.rawValue
        default:
            break
        }
        
        let newRecord = GameResultModel(trueAnswers: gameResult.trueAnswers, falseAnswers: gameResult.falseAnswers, date: gameResult.date, difficulty: difficultyString, mathSolutions: gameResult.mathSolutions)
        records.append(newRecord)
        try? GameRecordsCaretaker.shared.saveResult(result: records)
        
        timerModel.stopTimer()
        isGameEnd = true
        self.dismiss(animated: true, completion: nil)
    }
}
