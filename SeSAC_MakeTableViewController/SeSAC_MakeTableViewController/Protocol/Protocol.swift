//
//  Protocol.swift
//  SeSAC_MakeTableViewController
//
//  Created by Deokhun KIM on 1/10/24.
//

import Foundation

//protocol
//@objc사용한 프로토콜은 associatedtype 사용 못하네..

protocol setUI: AnyObject {
    func configureUI()
}

protocol setCell {
    associatedtype T
    
    func configureCellData(data: T)
}
