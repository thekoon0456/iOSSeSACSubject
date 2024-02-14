//
//  Then+.swift
//  SeSAC_TodoProject
//
//  Created by Deokhun KIM on 2/14/24.
//

import Foundation

extension NSObject: Then {}
protocol Then {}

extension Then where Self: AnyObject {
    func then(_ action: (Self) -> Void) -> Self {
        action(self)
        return self
    }
}
