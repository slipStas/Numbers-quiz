//
//  SegmentedControlModel.swift
//  Numbers quiz
//
//  Created by Stanislav Slipchenko on 10.09.2020.
//  Copyright © 2020 Stanislav Slipchenko. All rights reserved.
//

import UIKit

class SegmentedControlModel: UISegmentedControl {
    
    var fontSegmentedControl : CGFloat?
    private var font : [AnyHashable : Any]?
    
    init(frame: CGRect, font: CGFloat) {
        fontSegmentedControl = font
        super.init(frame: frame)
        setupControl()
    }
    
    required init?(coder aDecoder: NSCoder, font: CGFloat) {
        fontSegmentedControl = font
        super.init(coder: aDecoder)
        setupControl()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupControl() {
        font = [NSAttributedString.Key.font : UIFont.systemFont(ofSize: self.fontSegmentedControl ?? 10)]
        self.setTitleTextAttributes((font as! [NSAttributedString.Key : Any]), for: .normal)
        self.backgroundColor = .myOrange
        self.selectedSegmentTintColor = .myGray
    }
    
}
