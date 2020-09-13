//
//  TimerModel.swift
//  Numbers quiz
//
//  Created by Stanislav Slipchenko on 13.09.2020.
//  Copyright © 2020 Stanislav Slipchenko. All rights reserved.
//

import UIKit

class TimerModel: UIView {
    
    var timer : Timer? = Timer()
    
    var timerCounter = 10.0 {
//        willSet {
//            if newValue <= 0.01 {
//                stopTimer()
//            }
//        }
        didSet {
            if oldValue <= 0.02 {
                stopTimer()
            }
            self.timerView.text = String(format: "%.02f", timerCounter)
        }
    }
    
    let timerView: UILabel = {
        let label = UILabel(frame: .zero)
        label.text = "10.0"
        label.textAlignment = .center
        
        label.layer.backgroundColor = UIColor.systemBackground.cgColor
        label.layer.shadowColor = UIColor.black.cgColor
        label.layer.shadowRadius = 20
        label.layer.shadowOffset = .zero
        label.layer.shadowOpacity = 1
        label.layer.borderWidth = 3
        label.layer.borderColor = UIColor.myOrange.cgColor
        
       
        return label
    }()
    
    let circleLayer: CAShapeLayer = {
        let circle = CAShapeLayer()
        circle.fillColor = UIColor.clear.cgColor
        circle.strokeColor = UIColor.myGreen.cgColor
        circle.lineWidth = 7.0

        circle.strokeEnd = 0.0
        return circle
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setup()
    }

    func setup(){
        backgroundColor = UIColor.clear
        
        layer.addSublayer(circleLayer)
        addSubview(timerView)

    }

    override func layoutSubviews() {
        super.layoutSubviews()
        let circlePath = UIBezierPath(arcCenter: CGPoint(x: frame.size.width / 2.0, y: frame.size.height / 2.0), radius: (frame.size.width) / 2, startAngle: 0.0, endAngle: CGFloat(Double.pi * 2.0), clockwise: true)

        circleLayer.path = circlePath.cgPath
        
        timerView.frame = bounds
                
        timerView.frame.size.height = self.timerView.frame.height * 0.8
        timerView.frame.size.width = self.timerView.frame.width * 0.8
        timerView.center = CGPoint(x: bounds.midX, y: bounds.midY)
        timerView.text = String(self.timerCounter)
        
        timerView.font = UIFont.systemFont(ofSize: bounds.height / 4)
        timerView.layer.cornerRadius = self.timerView.frame.height / 2
    }
    
    @objc func timerCountering() {
        timerCounter -= 0.01
    }
    
    func startTimer() {
        print("start timer")
        self.timer = Timer.scheduledTimer(timeInterval: 0.01, target: self, selector: #selector(timerCountering), userInfo: nil, repeats: true)
    }
    
    func pauseTimer() {
        print("pause timer")
        self.timer?.invalidate()
    }
    
    func stopTimer() {
        print("stop timer")
        self.timer?.invalidate()
        self.timer = nil
    }
    
    func pauseAnimation() {
        let pausedTime = layer.convertTime(CACurrentMediaTime(), from: nil)
        layer.speed = 0
        layer.timeOffset = pausedTime
    }
    
    func startAllNeedsAnimations(duration time: TimeInterval, color: CGColor) {
        animateCircle(duration: time)
        animateColor(duration: time, color: color)
        animateLabel(duration: time, color: color)
        animateShadowColor(duration: time, color: color)
    }
    
    func animateLabel(duration time: TimeInterval, color: CGColor) {
        let animation = CABasicAnimation(keyPath: #keyPath(CALayer.borderColor))
        
        animation.duration = time
        animation.fromValue = self.timerView.layer.borderColor
        animation.toValue = color
        animation.isRemovedOnCompletion = false
        animation.fillMode = CAMediaTimingFillMode.both
        
        self.timerView.layer.borderColor = UIColor.red.cgColor
        
        animation.isRemovedOnCompletion = true
        
        self.timerView.layer.add(animation, forKey: "animateLabel")
        
    }

    func animateCircle(duration time: TimeInterval) {
        let animation = CABasicAnimation(keyPath: "strokeEnd")

        animation.duration = time

        animation.fromValue = 0
        animation.toValue = 1

        animation.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.linear)

        circleLayer.strokeEnd = 1.0

        circleLayer.add(animation, forKey: "animateCircle")
    }
    
    func animateColor(duration time: TimeInterval, color: CGColor) {
        let animation = CABasicAnimation(keyPath: "strokeColor")
        
        animation.fromValue = self.circleLayer.strokeColor
        animation.toValue = color
        animation.duration = time
        animation.isRemovedOnCompletion = false
        animation.fillMode = CAMediaTimingFillMode.both
        
        self.circleLayer.strokeColor = color
        
        animation.isRemovedOnCompletion = true
        
        animation.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.linear)
        
        circleLayer.add(animation, forKey: "animateColor")
    }
    
    func animateShadowColor(duration time: TimeInterval, color: CGColor) {
        let animation = CABasicAnimation(keyPath: #keyPath(CALayer.shadowColor))
        
        animation.fromValue = self.timerView.layer.shadowColor
        animation.toValue = color
        animation.duration = time
        animation.isRemovedOnCompletion = false
        animation.fillMode = CAMediaTimingFillMode.both
        
        self.timerView.layer.shadowColor = color
        
        animation.isRemovedOnCompletion = true
        
        animation.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.linear)
        
        self.timerView.layer.add(animation, forKey: "animateShadowColor")
    }
}
