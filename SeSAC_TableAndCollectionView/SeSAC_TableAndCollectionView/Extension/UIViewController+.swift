//
//  UIViewController+.swift
//  SeSAC_TableAndCollectionView
//
//  Created by Deokhun KIM on 1/13/24.
//

import UIKit

extension UIViewController {
    func setRoundedView(_ view: UIView,
                         cornerRadius: CGFloat) {
        view.layer.cornerRadius = cornerRadius
        view.clipsToBounds = true
    }
}
