//
//  UIColor+.swift
//  SeSAC_TodoProject
//
//  Created by Deokhun KIM on 2/21/24.
//

import UIKit

extension String {
    
    func toUIColor() -> UIColor {
        switch self {
        case "systemRed":
            return .systemRed
        case "systemOrange":
            return .systemOrange
        case "systemYellow":
            return .systemYellow
        case "systemGreen":
            return .systemGreen
        case "systemCyan":
            return .systemCyan
        case "systemBlue":
            return .systemBlue
        default:
            return .systemGray
        }
    }
}
