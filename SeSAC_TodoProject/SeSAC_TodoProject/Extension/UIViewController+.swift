//
//  UIViewController+.swift
//  SeSAC_TodoProject
//
//  Created by Deokhun KIM on 2/18/24.
//

import UIKit

// MARK: - ActionSheet

extension UIViewController {
    func showActionSheet(title: String,
                         message: String,
                         primaryButtonTitle: String,
                         secondButtonTitle: String,
                         thirdButtonTitle: String,
                         okButtonTitle: String = "확인",
                         primaryAction: @escaping (UIAlertAction) -> Void,
                         secondAction: @escaping (UIAlertAction) -> Void,
                         thirdAction: @escaping (UIAlertAction) -> Void,
                         cancleAction: @escaping (UIAlertAction) -> Void) {
        
        let alert = UIAlertController(title: title,
                                      message: message,
                                      preferredStyle: .actionSheet)
        alert.view.tintColor = .white
        
        let primaryButton = UIAlertAction(title: primaryButtonTitle, style: .default, handler: primaryAction)
        let secondButton = UIAlertAction(title: secondButtonTitle, style: .default, handler: secondAction)
        let thirdButton = UIAlertAction(title: thirdButtonTitle, style: .default, handler: thirdAction)
        let okButton = UIAlertAction(title: okButtonTitle, style: .destructive, handler: cancleAction)
        
        alert.addAction(primaryButton)
        alert.addAction(secondButton)
        alert.addAction(thirdButton)
        alert.addAction(okButton)
        
        navigationController?.present(alert, animated: true)
    }
}



// MARK: - Notification

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
    
    @objc func receivedNotification(notification: NSNotification) { }
}

// MARK: - Predicate

extension UIViewController {
    
    func getTodayPredicate(date: Date) -> NSPredicate {
        let start = Calendar.current.startOfDay(for: date)
        let end = Calendar.current.date(byAdding: .day, value: 1, to: start) ?? Date()
        return NSPredicate(format: "endDate >= %@ && endDate < %@ ",
                           start as NSDate, end as NSDate)
    }
}

// MARK: - FileManager

extension UIResponder {
    //fileURL 가져오기
    func getFileURL(fileName: String) -> URL? {
        guard let documentDirectory = FileManager.default.urls(for: .documentDirectory,
                                                               in: .userDomainMask).first else { return nil }
        let photoDirectoryURL = documentDirectory.appendingPathComponent("images")
        do {
            try FileManager.default.createDirectory(at: photoDirectoryURL, withIntermediateDirectories: true)
        } catch {
            print("photoDirectory 생성 오류")
        }
        let fileURL = documentDirectory.appendingPathComponent("/images/\(fileName).jpg")
        return fileURL
    }
    
    //document이미지 로드하기
    func loadImageToDocument(fileName: String) -> UIImage? {
        guard let fileURL = getFileURL(fileName: fileName) else { return nil }
        
        if FileManager.default.fileExists(atPath: fileURL.path()) {
            return UIImage(contentsOfFile: fileURL.path())
        } else {
            return nil
        }
    }
    
    //document 폴더에 저장하기
    func saveImageToDocument(image: UIImage?, fileName: String) {
        guard let fileURL = getFileURL(fileName: fileName),
              let data = image?.jpegData(compressionQuality: 0.5)
        else { return }
        
        do {
            try data.write(to: fileURL)
        } catch {
            //파일 저장 실패시
            print("DEBUG: file save error", error)
        }
    }
}
