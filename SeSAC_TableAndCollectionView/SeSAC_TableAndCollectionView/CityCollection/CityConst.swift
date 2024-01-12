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

enum ConstString {
    static let loadingImage = "loadingImage"
    
    static let heartFillImage = "heart.fill"
    static let heartImage = "heart"
    static let starFillImage = "star.fill"
    static let starImage = "star"
    
    static let searchPlaceHolder = "도시를 검색해주세요"
    static let ad = "AD"
}

enum Title {
    static let popularCity = "인기 도시"
    static let cityDetailInfo = "도시 상세 정보"
    static let trevelScene = "관광지 화면"
    static let adScene = "광고 화면"
}
