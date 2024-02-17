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
}
