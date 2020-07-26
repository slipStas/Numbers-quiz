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
        addTarget(self, action: #selector(tapOnNumberButton(sender:)), for: .touchDown)
        styleButton()
    }
    
    func styleButton() {
        shadow()
        setTitleColor(#colorLiteral(red: 0, green: 0, blue: 0, alpha: 1), for: .normal)
        backgroundColor = #colorLiteral(red: 0.9529411793, green: 0.6862745285, blue: 0.1333333403, alpha: 1)
        titleLabel?.font = UIFont.systemFont(ofSize: 40)
        layer.cornerRadius = layer.frame.height / 8
        layer.borderWidth = 2
        layer.borderColor = #colorLiteral(red: 0.7254902124, green: 0.4784313738, blue: 0.09803921729, alpha: 1)
    }
    
    private func shadow() {
        layer.shadowColor = #colorLiteral(red: 0.501960814, green: 0.501960814, blue: 0.501960814, alpha: 1)
        layer.shadowOffset = CGSize(width: -3, height: -3)
        layer.shadowRadius = 3
        layer.shadowOpacity = 0.5
        clipsToBounds = true
        layer.masksToBounds = false
    }
    
    @objc func tapOnNumberButton(sender: UIButton) {
        guard let titleText = sender.titleLabel?.text else {return}
        print("tap the <\(titleText)> button")
        
        UIView.animate(withDuration: 0.1, delay: 0, options: [.autoreverse], animations: {
            sender.transform = CGAffineTransform.identity.scaledBy(x: 1.1, y: 1.1)
        }) { state in
            sender.transform = CGAffineTransform.identity.scaledBy(x: 1, y: 1)
        }
        
    }
}
