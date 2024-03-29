//
//  Protocol.swift
//  SeSAC_MakeTableViewController
//
//  Created by Deokhun KIM on 1/10/24.
//

import Foundation

//protocol
//@objc사용한 프로토콜은 associatedtype 사용 못해서 분리

//Model 공통 채택
protocol Model { }

//뷰컨 공통 채택
protocol SetUI {
    func configureUI()
}

//cell 채택
protocol SetCell: SetUI {
    associatedtype T: Model
    
    static var identifier: String { get }
    
    func configureCellData(_ data: T)
}

extension SetUI {
    static var identifier: String {
        return String(describing: self)
    }
}
