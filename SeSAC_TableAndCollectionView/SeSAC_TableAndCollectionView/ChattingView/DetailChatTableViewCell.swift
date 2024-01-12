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
    
    
    static let cellID = "DetailChatTableViewCell"

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        configureUI()
    }
    
    func configureUI() {
        DispatchQueue.main.async { //너비 비율 1.5로
            self.profileImage.layer.cornerRadius = UIScreen.main.bounds.width / 6.6 / 2
        }
        profileImage.clipsToBounds = true
        profileImage.contentMode = .scaleAspectFill
        
        userNameLabel.font = .boldSystemFont(ofSize: 16)
        
        chatBorderView.layer.borderWidth = 1
        chatBorderView.layer.borderColor = UIColor.systemGray.cgColor
        chatBorderView.layer.cornerRadius = 10
        chatBorderView.clipsToBounds = true
        
        messageLabel.font = .systemFont(ofSize: 14)
        messageLabel.numberOfLines = 0

        dateLabel.font = .systemFont(ofSize: 12)
        dateLabel.textColor = .systemGray2
        dateLabel.textAlignment = .center
    }
    
    func setCellData(_ data: Chat) {
        profileImage.image = UIImage(named: data.user.profileImage)
        userNameLabel.text = data.user.rawValue
        messageLabel.text = data.message
        dateLabel.text = "08:16 오후"
    }
    
}
