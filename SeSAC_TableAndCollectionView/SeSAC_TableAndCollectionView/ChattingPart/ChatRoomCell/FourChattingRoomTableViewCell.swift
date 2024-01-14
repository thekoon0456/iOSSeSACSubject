//
//  FourChattingRoomTableViewCell.swift
//  SeSAC_TableAndCollectionView
//
//  Created by Deokhun KIM on 1/15/24.
//

import UIKit

class FourChattingRoomTableViewCell: UITableViewCell {
    
    @IBOutlet var firstProfileView: UIImageView!
    
    
    
    @IBOutlet var thirdProfileView: UIImageView!
    @IBOutlet var forthProfileView: UIImageView!
    @IBOutlet var secondProfileImage: UIImageView!
    @IBOutlet var userNameLabel: UILabel!
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

extension FourChattingRoomTableViewCell: setCell {
    
    typealias T = ChatRoom
    
    func configureCellData(_ data: ChatRoom) {
        firstProfileView.image = UIImage(named: data.chatroomImage[0])
        secondProfileImage.image = UIImage(named: data.chatroomImage[1])
        thirdProfileView.image = UIImage(named: data.chatroomImage[2])
        forthProfileView.image = UIImage(named: data.chatroomImage[3])
        userNameLabel.text = data.chatroomName
        messageLabel.text = data.lastMessage
        dateLabel.text = data.formattedDate
    }
    
    func configureUI () {
        //이미지 설정
        DispatchQueue.main.async { [self] in
            setRoundedView(firstProfileView,
                           cornerRadius: ChatCornerRadius.manyUserProfileImage)
            setRoundedView(secondProfileImage,
                           cornerRadius: ChatCornerRadius.manyUserProfileImage)
            setRoundedView(thirdProfileView,
                           cornerRadius: ChatCornerRadius.manyUserProfileImage)
            setRoundedView(forthProfileView,
                           cornerRadius: ChatCornerRadius.manyUserProfileImage)
        }
        
        firstProfileView.contentMode = .scaleAspectFill
        thirdProfileView.contentMode = .scaleAspectFill
        forthProfileView.contentMode = .scaleAspectFill
        
        //label 설정
        setLabel(userNameLabel,
                 font: .boldSystemFont(ofSize: 16))
        
        setLabel(messageLabel,
                 fontSize: 14,
                 color: .darkGray)
        
        setLabel(dateLabel,
                 fontSize: 14,
                 color: .systemGray2)
    }
}
