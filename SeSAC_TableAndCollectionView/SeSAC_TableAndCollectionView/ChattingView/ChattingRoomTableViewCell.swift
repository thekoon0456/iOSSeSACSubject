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
    
    static var identifier: String {
        return String(describing: self)
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        configureUI()
    }
}

extension ChattingRoomTableViewCell: setCell {
    
    typealias T = ChatRoom
    
    func configureCellData(_ data: ChatRoom) {
        profileView.image = UIImage(named: data.chatImage)
        userNameLabel.text = data.chatroomName
        messageLabel.text = data.lastMessage
        dateLabel.text = data.formattedDate
    }
    
    func configureUI () {
        //이미지 설정
        DispatchQueue.main.async { [self] in //너비 비율 1.5로
            setRoundedView(profileView,
                           cornerRadius: (UIScreen.main.bounds.width / 6.6 / 2))
        }
        
        profileView.contentMode = .scaleAspectFill
        
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
