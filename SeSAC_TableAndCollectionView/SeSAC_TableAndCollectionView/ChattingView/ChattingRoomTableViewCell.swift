//
//  ChattingRoomTableViewCell.swift
//  SeSAC_TableAndCollectionView
//
//  Created by Deokhun KIM on 1/12/24.
//

import UIKit

class ChattingRoomTableViewCell: UITableViewCell {
    
    @IBOutlet var profileView: UIImageView!
    @IBOutlet var userNameLabel: UILabel!
    @IBOutlet var messageLabel: UILabel!
    @IBOutlet var dateLabel: UILabel!
    
    static let identifier = "ChattingRoomTableViewCell"

    override func awakeFromNib() {
        super.awakeFromNib()
        
        configureUI()
    }
    
    func setCellData(_ data: ChatRoom) {
        profileView.image = UIImage(named: data.getImage)
        userNameLabel.text = data.chatroomName
        messageLabel.text = data.getMessage
        dateLabel.text = data.getDate
    }
    
    
    func configureUI () {
        //이미지 설정
        DispatchQueue.main.async { //너비 비율 1.5로
            self.profileView.layer.cornerRadius = UIScreen.main.bounds.width / 6.6 / 2
        }
        profileView.clipsToBounds = true
        profileView.contentMode = .scaleAspectFill
        
        //label 설정
        userNameLabel.font = .boldSystemFont(ofSize: 16)
        
        messageLabel.font = .systemFont(ofSize: 14)
        messageLabel.textColor = .darkGray
        
        dateLabel.font = .systemFont(ofSize: 12)
        dateLabel.textColor = .systemGray2
    }
    
}

