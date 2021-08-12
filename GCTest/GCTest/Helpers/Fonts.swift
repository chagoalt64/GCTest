//
//  Fonts.swift
//  GCTest
//
//  Created by Santiago Borjon on 12/08/21.
//

import Foundation
import UIKit

enum Menlo {
    case menloRegularSmall(UIColor)
    case menloRegularMedium(UIColor)
    case menloRegularLarge(UIColor)
    case menloBoldSmall(UIColor)
    case menloBoldMedium(UIColor)
    case menloBoldLarge(UIColor)
}

extension Menlo {
    var attributes: [NSAttributedString.Key : Any]? {
        switch self {
        case .menloRegularSmall(let color):
            return [NSAttributedString.Key.foregroundColor: color,
                    NSAttributedString.Key.font: UIFont(name: "Menlo-Regular", size: 16)!]
        case .menloRegularMedium(let color):
            return [NSAttributedString.Key.foregroundColor: color,
                    NSAttributedString.Key.font: UIFont(name: "Menlo-Regular", size: 19)!]
        case .menloRegularLarge(let color):
            return [NSAttributedString.Key.foregroundColor: color,
                    NSAttributedString.Key.font: UIFont(name: "Menlo-Regular", size: 21)!]
        case .menloBoldSmall(let color):
            return [NSAttributedString.Key.foregroundColor: color,
                    NSAttributedString.Key.font: UIFont(name: "Menlo-Bold", size: 16)!]
        case .menloBoldMedium(let color):
            return [NSAttributedString.Key.foregroundColor: color,
                    NSAttributedString.Key.font: UIFont(name: "Menlo-Bold", size: 19)!]
        case .menloBoldLarge(let color):
            return [NSAttributedString.Key.foregroundColor: color,
                    NSAttributedString.Key.font: UIFont(name: "Menlo-Bold", size: 21)!]
        }
    }
}
