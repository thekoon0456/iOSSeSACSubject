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
    @IBOutlet var dateChangeLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        configureUI()
    }
}

// MARK: - UI

extension DetailOwnUserTableViewCell: SetCell {
    
    typealias T = Chat
    
    func configureCellData(_ data: Chat) {
        messageLabel.text = data.message
        dateLabel.text = DateService.shared.formattedDate(input: data.date, outputFormat: .chatRoomStyle)
        dateChangeLabel.text = DateService.shared.formattedDate(input: data.date, outputFormat: .dateChangeStyle)
        setDateChangeLabel(changed: data.isChangedDate)
    }
    
    func configureUI() {
        chatBorderView.layer.borderWidth = 1
        chatBorderView.layer.borderColor = UIColor.systemGray.cgColor
        chatBorderView.backgroundColor = .systemGray5
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
