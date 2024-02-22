//
//  UIView+.swift
//  SeSAC_MVVM
//
//  Created by Deokhun KIM on 2/22/24.
//

import UIKit

extension UIView {
    
    func addSubviews(_ subviews: UIView...) {
        for subview in subviews {
            addSubview(subview)
        }
    }
}
