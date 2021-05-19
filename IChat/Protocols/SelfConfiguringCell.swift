//
//  SelfConfiguringCell.swift
//  IChat
//
//  Created by Михаил Красильник on 18.04.2021.
//

import Foundation

protocol SelfConfiguringCell {
    static var reuseId: String { get }
    func configure<U: Hashable>(with value: U)
}
