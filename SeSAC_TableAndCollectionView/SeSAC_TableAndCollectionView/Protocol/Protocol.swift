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

//뷰 공통 채택
protocol setUI {
    func configureUI()
}

//cell 채택
protocol setCell {
    associatedtype T: Model
    
    static var cellID: String { get }
    func configureCellData(data: T)
}
