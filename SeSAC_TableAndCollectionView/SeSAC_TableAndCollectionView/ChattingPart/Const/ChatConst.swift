//
//  ChatConst.swift
//  SeSAC_TableAndCollectionView
//
//  Created by Deokhun KIM on 1/12/24.
//

import UIKit

enum ChatConst: String {
    //title
    case travelTalkTitle = "TREVEL TALK"

    //ment
    case searchPlaceHolder = "친구 이름을 검색해보세요"
    case inputMessagePlaceHolder = "메세지를 입력하세요"
    
    //button
    case sendButton = "paperplane"
}

enum ChatCornerRadius {
    static let oneProfileImage = (UIScreen.main.bounds.width / 6.6) / 2
    static let manyUserProfileImage = (UIScreen.main.bounds.width / 6.6) / 2 * 0.5
}
