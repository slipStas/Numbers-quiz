//
//  AnimateConsole.swift
//  Numbers quiz
//
//  Created by Stanislav Slipchenko on 19.09.2020.
//  Copyright © 2020 Stanislav Slipchenko. All rights reserved.
//

import UIKit

class AnimateConsole: UIView {
    
    var animateLabel : UILabel = {
        let label = UILabel(frame: .zero)
        label.textAlignment = .center
        label.layer.backgroundColor = UIColor.systemBackground.cgColor
        label.alpha = 0
        
        return label
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
        
        addSubview(animateLabel)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()

        animateLabel.frame = bounds
        animateLabel.font = UIFont.systemFont(ofSize: bounds.height / 4)
    }
    
    func animateLabel(duration time: TimeInterval) {
        UIView.animate(withDuration: time) {
            self.animateLabel.transform = CGAffineTransform.init(scaleX: 2, y: 2)
            self.animateLabel.alpha = 0.4
        } completion: { (status) in
            self.animateLabel.transform = CGAffineTransform.init(scaleX: 1, y: 1)
            self.animateLabel.alpha = 0
        }

    }
    
}
