//
//  UIViewController+.swift
//  SeSAC_TodoProject
//
//  Created by Deokhun KIM on 2/18/24.
//

import UIKit

extension UIViewController {
    
    func postNotification(name: String, userInfo: [String: Any]?) {
        NotificationCenter.default.post(name: NSNotification.Name(name),
                                        object: nil,
                                        userInfo: userInfo)
    }
    
    func notiAddObserver(name: String) {
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(receivedNotification(notification:)),
                                               name: NSNotification.Name(name),
                                               object: nil)
    }
    
    @objc func receivedNotification(notification: NSNotification) {
        
    }
}
