//
//  Protocol.swift
//  SeSAC_MediaProject
//
//  Created by Deokhun KIM on 1/25/24.
//

import Foundation

//Model 공통 채택
protocol Model {
    var posterPath: String? { get }
    var name: String { get }
}

//뷰컨 공통 채택
protocol SetUI {
    func configureUI()
}

//cell 채택
protocol SetCell: SetUI {
    static var identifier: String { get }
    
    func configureCellData(_ data: Model)
}

extension SetUI {
    static var identifier: String {
        return String(describing: self)
    }
}
