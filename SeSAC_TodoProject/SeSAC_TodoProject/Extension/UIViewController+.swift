//
//  UIViewController+.swift
//  SeSAC_TodoProject
//
//  Created by Deokhun KIM on 2/18/24.
//

import UIKit

extension UIViewController {
    
    // MARK: - Notification
    
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
    
    @objc func receivedNotification(notification: NSNotification) { }
    
    // MARK: - Predicate
    
    func getTodayPredicate(date: Date) -> NSPredicate {
        let start = Calendar.current.startOfDay(for: date)
        let end = Calendar.current.date(byAdding: .day, value: 1, to: start) ?? Date()
        return NSPredicate(format: "endDate >= %@ && endDate < %@ ",
                           start as NSDate, end as NSDate)
    }
}
