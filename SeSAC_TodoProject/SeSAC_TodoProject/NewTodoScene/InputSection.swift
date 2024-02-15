//
//  InputSection.swift
//  SeSAC_TodoProject
//
//  Created by Deokhun KIM on 2/15/24.
//

import Foundation

enum InputSection: Int, CaseIterable {
    case input
    case endDate
    case tag
    case priority
    case addImage
    
    static var valueList: [String?] = Array(repeating: "", count: InputSection.allCases.count)
    
    var title: String {
        switch self {
        case .input:
            ""
        case .endDate:
            "마감일"
        case .tag:
            "태그"
        case .priority:
            "우선 순위"
        case .addImage:
            "이미지 추가"
        }
    }
    
    var value: String? {
        switch self {
        case .input:
            return InputSection.valueList[0]
        case .endDate:
            return InputSection.valueList[1]
        case .tag:
            return InputSection.valueList[2]
        case .priority:
            return InputSection.valueList[3]
        case .addImage:
            return InputSection.valueList[4]
        }
    }
}
