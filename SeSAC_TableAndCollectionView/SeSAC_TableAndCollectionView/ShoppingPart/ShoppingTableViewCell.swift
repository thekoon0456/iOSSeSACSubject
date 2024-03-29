//
//  ShoppingTableViewCell.swift
//  SeSAC_MakeTableViewController
//
//  Created by Deokhun KIM on 1/5/24.
//

import UIKit

final class ShoppingTableViewCell: UITableViewCell {
    
    enum Const {
        case checkButtonSelected
        case checkButton
        case starButtonSelected
        case starButton
        
        var value: String {
            switch self {
            case .checkButtonSelected:
                "checkmark.square.fill"
            case .checkButton:
                "checkmark.square"
            case .starButtonSelected:
                "star.fill"
            case .starButton:
                "star"
            }
        }
    }
    
    @IBOutlet var insetView: UIView!
    @IBOutlet var checkButton: UIButton!
    @IBOutlet var starButton: UIButton!
    @IBOutlet var contentLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        configureUI()
    }
}

extension ShoppingTableViewCell: SetUI {
    
    func configureUI() {
        setInsetView()
        setButton(checkButton)
        setButton(starButton)
        contentLabel.font = .systemFont(ofSize: 13)
    }
    
    func setInsetView() {
        insetView.backgroundColor = .systemGray6
        setRoundedView(insetView, cornerRadius: 10)
    }
    
    func setButton(_ button: UIButton) {
        button.tintColor = .label
    }
}

extension ShoppingTableViewCell: SetCell {
    
    typealias T = Shopping
    
    func configureCellData(_ data: Shopping) {
        contentLabel.text = data.title
        
        //버튼 이미지 설정
        let checkImage = data.isChecked
        ? Const.checkButtonSelected.value
        : Const.checkButton.value
        
        let starImage = data.isBookmarked
        ? Const.starButtonSelected.value
        : Const.starButton.value
        
        checkButton.setImage(UIImage(systemName: checkImage), for: .normal)
        starButton.setImage(UIImage(systemName: starImage), for: .normal)
    }
}
