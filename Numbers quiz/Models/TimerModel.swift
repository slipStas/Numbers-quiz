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
        timerView.font = UIFont.systemFont(ofSize: bounds.height / 3)
        
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
    
    func animateColor(duration time: TimeInterval) {
        let animation = CABasicAnimation(keyPath: "strokeColor")
        
        animation.fromValue = self.circleLayer.strokeColor
        animation.toValue = UIColor.myRed.cgColor
        animation.duration = time
        
        
        animation.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.linear)
        
        circleLayer.add(animation, forKey: "animateColor")
    }
}
