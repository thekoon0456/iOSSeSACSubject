//
//  UIViewController+.swift
//  SeSAC_MediaProject
//
//  Created by Deokhun KIM on 1/25/24.
//

import UIKit

extension UIView {
    
    func addSubviews(_ subviews: UIView...) {
        for subview in subviews {
            addSubview(subview)
        }
    }
    
    func setLabel(_ label: UILabel,
                  text: String = "",
                  fontSize: CGFloat = 16,
                  isBold: Bool = false,
                  lines: Int = 1,
                  color: UIColor = .label,
                  alignment: NSTextAlignment = .left) {
        label.text = text
        label.font = isBold
        ? .boldSystemFont(ofSize: fontSize)
        : .systemFont(ofSize: fontSize)
        label.numberOfLines = lines
        label.textColor = color
        label.textAlignment = alignment
    }
    
    func setButton(_ button: UIButton,
                   title: String = "",
                   titleBold: Bool = false,
                   titleSize: CGFloat = 17,
                   titleColor: UIColor = .label,
                   bgColor: UIColor = .black,
                   tintColor: UIColor = .label) {
        button.setTitle(title, for: .normal)
        button.titleLabel?.font = titleBold
        ? .systemFont(ofSize: titleSize, weight: .bold)
        : .systemFont(ofSize: titleSize)
        button.setTitleColor(titleColor, for: .normal)
        button.backgroundColor = bgColor
        button.tintColor = tintColor
    }
    
    func setRoundedView(_ view: UIView,
                        cornerRadius: CGFloat) {
        view.layer.cornerRadius = cornerRadius
        view.clipsToBounds = true
    }
}

extension UIViewController {
    
    func setLabel(_ label: UILabel,
                  text: String = "",
                  fontSize: CGFloat = 16,
                  isBold: Bool = false,
                  lines: Int = 1,
                  color: UIColor = .label,
                  alignment: NSTextAlignment = .left) {
        label.text = text
        label.font = isBold
        ? .boldSystemFont(ofSize: fontSize)
        : .systemFont(ofSize: fontSize)
        label.numberOfLines = lines
        label.textColor = color
        label.textAlignment = alignment
    }
    
    func setButton(_ button: UIButton,
                   title: String = "",
                   titleBold: Bool = false,
                   titleSize: CGFloat = 17,
                   titleColor: UIColor = .label,
                   bgColor: UIColor = .black,
                   tintColor: UIColor = .label) {
        button.setTitle(title, for: .normal)
        button.titleLabel?.font = titleBold
        ? .systemFont(ofSize: titleSize, weight: .bold)
        : .systemFont(ofSize: titleSize)
        button.setTitleColor(titleColor, for: .normal)
        button.backgroundColor = bgColor
        button.tintColor = tintColor
    }
    
    func setRoundedView(_ view: UIView,
                        cornerRadius: CGFloat) {
        view.layer.cornerRadius = cornerRadius
        view.clipsToBounds = true
    }
}
