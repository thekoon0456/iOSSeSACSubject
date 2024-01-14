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
    
    static var identifier: String {
        return String(describing: self)
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        configureUI()
    }
}

// MARK: - UI

extension DetailOwnUserTableViewCell: setCell {
    
    typealias T = Chat
    
    func configureCellData(_ data: Chat) {
        messageLabel.text = data.message
        dateLabel.text = data.formattedDate
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
    }
}
