//
//  TodoSection.swift
//  SeSAC_TodoProject
//
//  Created by Deokhun KIM on 2/15/24.
//

import UIKit

enum TodoSection: Int, CaseIterable {
    case today
    case plan
    case whole
    case flag
    case complete
    
    var title: String {
        switch self {
        case .today:
            "오늘"
        case .plan:
            "예정"
        case .whole:
            "전체"
        case .flag:
            "깃발 표시"
        case .complete:
            "완료됨"
        }
    }
    
    var imageName: String {
        switch self {
        case .today:
            "calendar"
        case .plan:
            "calendar"
        case .whole:
            "tray"
        case .flag:
            "flag.fill"
        case .complete:
            "checkmark"
        }
    }
    
    var bgColor: UIColor? {
        switch self {
        case .today:
                .systemBlue
        case .plan:
                .systemRed
        case .whole:
                .systemGray
        case .flag:
                .systemYellow
        case .complete:
                .systemGray
        }
    }
}
