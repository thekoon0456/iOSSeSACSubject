//
//  UIVIewController+.swift
//  SeSAC_MediaProject
//
//  Created by Deokhun KIM on 2/5/24.
//

import UIKit

extension UIViewController {
    func errorAlert(title: String, message: String, defaultAction: @escaping (() -> Void)) {
        let alert = UIAlertController(title: title, //.actionSheet사용시 nil
                                      message: message,           //.actionSheet사용시 nil
                                      preferredStyle: .alert)
        
        let defaultButton = UIAlertAction(title: "재시도", style: .default) { _ in
            defaultAction()
        }
        let cancleButton = UIAlertAction(title: "확인", style: .cancel)
        
        alert.addAction(defaultButton)
        alert.addAction(cancleButton)
        
        present(alert, animated: true)
    }
}
