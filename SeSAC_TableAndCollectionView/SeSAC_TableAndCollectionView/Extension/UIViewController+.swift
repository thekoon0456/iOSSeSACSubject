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
    
    func scrollToBottom(_ tableView: UITableView, row: Int, section: Int = 0) {
        let lastIndexPath = IndexPath(row: row,
                                      section: section)
        
        tableView.scrollToRow(at: lastIndexPath, at: .bottom, animated: true)
    }
}
