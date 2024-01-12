//
//  CityConst.swift
//  SeSAC_MakeTableViewController
//
//  Created by Deokhun KIM on 1/9/24.
//

import UIKit

enum ConstFloat {
    case spacing
    case cellWidth
    case cellHeight
    case cellCornerRadious
    
    var value: CGFloat {
        switch self {
        case .spacing:
            return 20
        case .cellWidth:
            return (UIScreen.main.bounds.width - 20 * 3) / 2
        case .cellHeight:
            return ((UIScreen.main.bounds.width - 20 * 3) / 2) * 1.4
        case .cellCornerRadious:
            return (UIScreen.main.bounds.width - 20 * 3) / 4
        }
    }
    
}

enum ConstInt {
    static let starCount: Int = 5
}
