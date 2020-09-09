//
//  NumberButtonModel.swift
//  Numbers quiz
//
//  Created by Stanislav Slipchenko on 26.07.2020.
//  Copyright © 2020 Stanislav Slipchenko. All rights reserved.
//

import UIKit

class NumberButtonModel: UIButton {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupButton()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupButton()
    }
    
    func setupButton() {
        addTarget(self, action: #selector(touchDownNumberButton(sender:)), for: .touchDown)
        addTarget(self, action: #selector(touchUpNumberButton(sender:)), for: .touchUpInside)
        styleButton()
    }
    
    func styleButton() {
        shadow()
        setTitleColor(#colorLiteral(red: 0, green: 0, blue: 0, alpha: 1), for: .normal)
        backgroundColor = .myOrange
        titleLabel?.font = UIFont.systemFont(ofSize: 40)
        layer.cornerRadius = layer.frame.height / 8
        layer.borderWidth = 2
        layer.borderColor = UIColor.myOrangeBorder.cgColor
    }
    
    private func shadow() {
        layer.shadowColor = UIColor.myShadowGray.cgColor
        layer.shadowOffset = CGSize(width: -3, height: -3)
        layer.shadowRadius = 3
        layer.shadowOpacity = 0.5
        clipsToBounds = true
        layer.masksToBounds = false
    }
    
    @objc func touchDownNumberButton(sender: UIButton) {
        
        guard let titleTextButton = sender.titleLabel?.text else {return}
        
        switch titleTextButton {
        case "0", "1", "2", "3", "4", "5", "6", "7", "8", "9":
            Session.shared.userAnswer += titleTextButton
            sender.feedback()
        default:
            break
        }
        
        UIView.animate(withDuration: 0.05, animations: {
            sender.transform = CGAffineTransform.identity.scaledBy(x: 0.95, y: 0.95)
        })
    }
    
    @objc func touchUpNumberButton(sender: UIButton) {
        
        UIView.animate(withDuration: 0.05, animations: {
            sender.transform = CGAffineTransform.identity.scaledBy(x: 1, y: 1)
        })
    }
}

extension UIView {
    func feedback() {
        let generator = UIImpactFeedbackGenerator(style: .light)
        generator.prepare()
        generator.impactOccurred()
    }
}
