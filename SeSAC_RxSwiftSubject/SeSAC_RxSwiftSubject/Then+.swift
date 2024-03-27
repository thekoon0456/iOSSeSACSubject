//
//  Then+.swift
//  SeSAC_RxSwiftSubject
//
//  Created by Deokhun KIM on 3/28/24.
//

import Foundation

import Foundation
import UIKit

protocol Then {}

extension Then where Self: AnyObject {
    func then(_ block: (Self) -> Void) -> Self {
        block(self)
        return self
    }
}

extension Then where Self: Any {
    func then(_ block: (inout Self) -> Void) -> Self {
        var copy = self
        block(&copy)
        return copy
    }
}

extension NSObject: Then {}

extension Array: Then {}
extension Dictionary: Then {}
extension Set: Then {}
extension UIButton.Configuration: Then {}
extension UIListContentConfiguration: Then {}
extension UICollectionLayoutListConfiguration: Then {}
extension UIBackgroundConfiguration: Then {}
extension NSDiffableDataSourceSnapshot: Then {}
