//
//  ShoppingTableViewCell.swift
//  SeSAC_MakeTableViewController
//
//  Created by Deokhun KIM on 1/5/24.
//

import UIKit

class ShoppingTableViewCell: UITableViewCell {
    
    static let cellID = "ShoppingTableViewCell"
    
    @IBOutlet var insetView: UIView!
    @IBOutlet var checkButton: UIButton!
    @IBOutlet var starButton: UIButton!
    @IBOutlet var contentLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        
        configureUI()
    }
    
    func setValue(shopping: Shopping) {
        contentLabel.text = shopping.title
        
        //버튼 이미지 설정
        let checkImage = shopping.isChecked
        ? "checkmark.square.fill"
        : "checkmark.square"
        
        let starImage = shopping.isBookmarked
        ? "star.fill"
        : "star"
        
        checkButton.setImage(UIImage(systemName: checkImage), for: .normal)
        starButton.setImage(UIImage(systemName: starImage), for: .normal)
    }
    
    func configureUI() {
        setInsetView()
        setButton(checkButton)
        setButton(starButton)
        contentLabel.font = .systemFont(ofSize: 13)
    }
    
    func setInsetView() {
        insetView.backgroundColor = .systemGray6
        insetView.layer.cornerRadius = 10
        insetView.clipsToBounds = true
    }
    
    func setButton(_ button: UIButton) {
        button.tintColor = .label
    }
}
