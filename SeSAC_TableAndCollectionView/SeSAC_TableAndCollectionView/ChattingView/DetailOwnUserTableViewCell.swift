//
//  DetailOwnUserTableViewCell.swift
//  SeSAC_TableAndCollectionView
//
//  Created by Deokhun KIM on 1/12/24.
//

import UIKit

class DetailOwnUserTableViewCell: UITableViewCell {
    
    @IBOutlet var chatBorderView: UIView!
    @IBOutlet var messageLabel: UILabel!
    @IBOutlet var dateLabel: UILabel!
    
    static let identifier = "DetailOwnUserTableViewCell"

    override func awakeFromNib() {
        super.awakeFromNib()

        configureUI()
    }
    
    func setCellData(_ data: Chat) {
        messageLabel.text = data.message
        dateLabel.text = "08:16 오후"
    }
    
    func configureUI() {
        chatBorderView.layer.borderWidth = 1
        chatBorderView.layer.borderColor = UIColor.systemGray.cgColor
        chatBorderView.layer.cornerRadius = 10
        chatBorderView.clipsToBounds = true
        chatBorderView.backgroundColor = .systemGray5
        
        messageLabel.font = .systemFont(ofSize: 14)
        messageLabel.numberOfLines = 0

        dateLabel.font = .systemFont(ofSize: 10)
        dateLabel.textColor = .systemGray
        dateLabel.textAlignment = .center
    }
}
