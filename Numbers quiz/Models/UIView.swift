//
//  UIView.swift
//  Numbers quiz
//
//  Created by Stanislav Slipchenko on 10.09.2020.
//  Copyright © 2020 Stanislav Slipchenko. All rights reserved.
//

import UIKit

extension UIView {
    func feedback() {
        let generator = UIImpactFeedbackGenerator(style: .light)
        generator.prepare()
        generator.impactOccurred()
    }
}
