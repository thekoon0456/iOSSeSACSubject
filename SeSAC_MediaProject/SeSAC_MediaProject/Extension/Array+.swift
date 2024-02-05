//
//  Array+.swift
//  SeSAC_MediaProject
//
//  Created by Deokhun KIM on 2/5/24.
//

import Foundation

extension Array {
    subscript(safe index: Int) -> Element? {
        return indices ~= index ? self[index] : nil
    }
}
