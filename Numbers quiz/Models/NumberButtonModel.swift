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
        styleButton()
    }
    
    func styleButton() {
        shadow()
        setTitleColor(.green, for: .normal)
        backgroundColor = #colorLiteral(red: 0.7450980544, green: 0.1568627506, blue: 0.07450980693, alpha: 1)
        titleLabel?.font = UIFont(name: "System", size: 40)
        layer.cornerRadius = layer.frame.height / 8
        layer.borderWidth = 2
        layer.borderColor = #colorLiteral(red: 0.9546661973, green: 0.9680002332, blue: 0.3853910565, alpha: 1)
    }
    
    private func shadow() {
        layer.shadowColor = #colorLiteral(red: 0.501960814, green: 0.501960814, blue: 0.501960814, alpha: 1)
        layer.shadowOffset = CGSize(width: 0, height: 6)
        layer.shadowRadius = 6
        layer.shadowOpacity = 0.5
        clipsToBounds = true
        layer.masksToBounds = false
    }
}
