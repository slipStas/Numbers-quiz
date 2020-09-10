//
//  MainSceneDelegate.swift
//  Numbers quiz
//
//  Created by Stanislav Slipchenko on 06.08.2020.
//  Copyright © 2020 Stanislav Slipchenko. All rights reserved.
//

import Foundation

protocol MainSceneDelegate : AnyObject {
    func didEndGame(trueAnswerCount: Int, falseAnswerCount: Int, averageTime: String) throws
}
