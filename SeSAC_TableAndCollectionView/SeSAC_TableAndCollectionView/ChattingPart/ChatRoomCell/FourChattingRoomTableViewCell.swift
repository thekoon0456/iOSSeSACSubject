//
//  FourChattingRoomTableViewCell.swift
//  SeSAC_TableAndCollectionView
//
//  Created by Deokhun KIM on 1/15/24.
//

import UIKit

class FourChattingRoomTableViewCell: UITableViewCell {
    
    @IBOutlet var firstProfileView: UIImageView!
    @IBOutlet var secondProfileImage: UIImageView!
    @IBOutlet var thirdProfileView: UIImageView!
    @IBOutlet var forthProfileView: UIImageView!

    @IBOutlet var userNameLabel: UILabel!
    @IBOutlet var messageLabel: UILabel!
    @IBOutlet var dateLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        configureUI()
    }
}

// MARK: - Logic

extension FourChattingRoomTableViewCell {
    
    func configureProfileImages(input: ChatRoom) {
        let profileImages: [UIImageView] = [firstProfileView, secondProfileImage, thirdProfileView, forthProfileView]
        profileImages.enumerated().forEach { index, imageView in
            imageView.image = UIImage(named: input.chatroomImage[safe: index] ?? input.chatImage)
        }
    }
}

// MARK: - UI

extension FourChattingRoomTableViewCell: SetCell {
    
    typealias T = ChatRoom
    
    func configureCellData(_ data: ChatRoom) {
        configureProfileImages(input: data)
        userNameLabel.text = data.chatroomName
        messageLabel.text = data.lastMessage
        dateLabel.text = DateService.shared.formattedDate(input: data.chatList.last?.date ?? "", outputFormat: .chatStyle)
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
