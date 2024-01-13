//
//  UILabel.swift
//  SeSAC_TableAndCollectionView
//
//  Created by Deokhun KIM on 1/13/24.
//

import UIKit

extension UIView {
    func setLabel(
        _ label: UILabel,
        text: String = "",
        font: UIFont = .systemFont(ofSize: 16),
        fontSize: CGFloat = 16,
        lines: Int = 1,
        color: UIColor = .label,
        alignment: NSTextAlignment = .left
    ) {
        label.text = text
        label.font = .systemFont(ofSize: fontSize)
        label.numberOfLines = lines
        label.textColor = color
        label.textAlignment = alignment
    }
}
