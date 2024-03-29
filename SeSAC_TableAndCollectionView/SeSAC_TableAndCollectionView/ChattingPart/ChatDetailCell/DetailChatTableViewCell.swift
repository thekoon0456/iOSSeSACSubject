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
    @IBOutlet var dateChangeLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        
        configureUI()
    }
}

// MARK: - UI

extension DetailChatTableViewCell: SetCell {
    
    typealias T = Chat
    
    func configureCellData(_ data: Chat) {
        profileImage.image = UIImage(named: data.user.profileImage)
        userNameLabel.text = data.user.rawValue
        messageLabel.text = data.message
        dateLabel.text = DateService.shared.formattedDate(input: data.date, outputFormat: .chatRoomStyle)
        dateChangeLabel.text = DateService.shared.formattedDate(input: data.date, outputFormat: .dateChangeStyle)
        setDateChangeLabel(changed: data.isChangedDate)
    }
    
    func configureUI() {
        setRoundedView(profileImage, cornerRadius: 15)
        profileImage.contentMode = .scaleAspectFill
        userNameLabel.font = .systemFont(ofSize: 14)
        
        chatBorderView.layer.borderWidth = 1
        chatBorderView.layer.borderColor = UIColor.systemGray.cgColor
        
        setRoundedView(chatBorderView, cornerRadius: 10)

        setLabel(messageLabel,
                 fontSize: 14,
                 lines: 0)
        
        setLabel(dateLabel,
                 fontSize: 10,
                 color: .systemGray,
                 alignment: .center)
        
        setLabel(dateChangeLabel,
                 fontSize: 10,
                 color: .darkGray,
                 alignment: .center)
        setRoundedView(dateChangeLabel, cornerRadius: 5)
        dateChangeLabel.backgroundColor = .systemGray5
    }
    
    func setDateChangeLabel(changed: Bool) {
        if changed {
            dateChangeLabel.isHidden = false
        } else {
            dateChangeLabel.isHidden = true
        }
    }
}
