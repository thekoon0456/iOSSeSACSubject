//
//  UITextField+.swift
//  SeSAC_TodoProject
//
//  Created by Deokhun KIM on 2/14/24.
//

import UIKit

extension UITextField {
    
    func leftPadding(_ padding:  CGFloat) {
        let paddingView = UIView(frame: .init(x: 0, y: 0, width: padding, height: self.frame.height))
        self.leftView = paddingView
        self.leftViewMode = ViewMode.always
    }
}
