//
//  UIView+.swift
//  SeSAC_TodoProject
//
//  Created by Deokhun KIM on 2/14/24.
//

import UIKit

extension UIView {
    
    func addSubviews(_ subviews: UIView...) {
        for subview in subviews {
            addSubview(subview)
        }
    }
}
