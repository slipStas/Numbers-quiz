//
//  TimerModel.swift
//  Numbers quiz
//
//  Created by Stanislav Slipchenko on 13.09.2020.
//  Copyright © 2020 Stanislav Slipchenko. All rights reserved.
//

import UIKit

class TimerModel: UIView {
    
    let timerView: UILabel = {
        let label = UILabel(frame: .zero)
        label.text = "10.0"
        label.textAlignment = .center
        
        label.layer.masksToBounds = false
        label.clipsToBounds = false
        
        label.layer.shadowColor = UIColor.myGray.cgColor
        label.layer.shadowRadius = 10
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
        
        print(self.timerView.frame.height)
        
        timerView.frame.size.height = self.timerView.frame.height * 0.8
        timerView.frame.size.width = self.timerView.frame.width * 0.8
        timerView.center = CGPoint(x: bounds.midX, y: bounds.midY)

        
        timerView.font = UIFont.systemFont(ofSize: bounds.height / 4)
        timerView.layer.cornerRadius = self.timerView.frame.height / 2
        print(self.timerView.frame.height)
    }
    
    func allNeedsAnimations(duration time: TimeInterval, color: CGColor) {
        animateCircle(duration: time)
        animateColor(duration: time, color: color)
        animateLabel(duration: time, color: color)
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
}
