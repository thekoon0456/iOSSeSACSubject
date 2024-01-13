//
//  DetailChatTableViewCell.swift
//  SeSAC_TableAndCollectionView
//
//  Created by Deokhun KIM on 1/12/24.
//

import UIKit

class DetailChatTableViewCell: UITableViewCell {
    
    @IBOutlet var profileImage: UIImageView!
    @IBOutlet var userNameLabel: UILabel!
    @IBOutlet var chatBorderView: UIView!
    @IBOutlet var messageLabel: UILabel!
    @IBOutlet var dateLabel: UILabel!
    
    static var identifier: String {
        return String(describing: self)
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        
        configureUI()
    }
}

extension DetailChatTableViewCell: setCell {
    
    typealias T = Chat
    
    func configureCellData(_ data: Chat) {
        profileImage.image = UIImage(named: data.user.profileImage)
        userNameLabel.text = data.user.rawValue
        messageLabel.text = data.message
        dateLabel.text = data.formattedDate
    }
    
    func configureUI() {
        self.profileImage.layer.cornerRadius = 15
        profileImage.clipsToBounds = true
        profileImage.contentMode = .scaleAspectFill
        userNameLabel.font = .systemFont(ofSize: 14)
        
        chatBorderView.layer.borderWidth = 1
        chatBorderView.layer.borderColor = UIColor.systemGray.cgColor
        chatBorderView.layer.cornerRadius = 10
        chatBorderView.clipsToBounds = true
        
        messageLabel.font = .systemFont(ofSize: 14)
        messageLabel.numberOfLines = 0

        dateLabel.font = .systemFont(ofSize: 10)
        dateLabel.textColor = .systemGray
        dateLabel.textAlignment = .center
    }
}
