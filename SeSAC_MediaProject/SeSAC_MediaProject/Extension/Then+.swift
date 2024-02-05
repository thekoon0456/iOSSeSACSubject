//
//  Then+.swift
//  SeSAC_MediaProject
//
//  Created by Deokhun KIM on 2/5/24.
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
