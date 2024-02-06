//
//  UIVIewController+.swift
//  SeSAC_MediaProject
//
//  Created by Deokhun KIM on 2/5/24.
//

import UIKit

extension UIViewController {
    func errorAlert(title: String, message: String, actionTitle: String = "재시도", defaultAction: @escaping (() -> Void)) {
        let alert = UIAlertController(title: title,
                                      message: message,
                                      preferredStyle: .alert)
        
        let defaultButton = UIAlertAction(title: actionTitle, style: .default) { _ in
            defaultAction()
        }
        defaultButton.setValue(UIColor.white, forKey: "titleTextColor")
        
        let cancleButton = UIAlertAction(title: "확인", style: .cancel)
        cancleButton.setValue(UIColor.white, forKey: "titleTextColor")
        
        alert.addAction(defaultButton)
        alert.addAction(cancleButton)
        
        present(alert, animated: true)
    }
}
