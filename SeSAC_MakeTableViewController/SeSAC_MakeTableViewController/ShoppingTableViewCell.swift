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
    
    @UserDefault
    var list: [Shopping]?
    
    var checkButtonSelected = false
    var starButtonSelected = false

    override func awakeFromNib() {
        configureUI()
    }
    
    func setValue(shopping: Shopping) {
        
        checkButtonSelected = shopping.isChecked
        starButtonSelected = shopping.isBookmarked
        contentLabel.text = shopping.title
    }
    
    func configureUI() {
        setInsetView()
        setButton(checkButton,
                  normalImage: "checkmark.square")
        setButton(starButton,
                  normalImage: "star")
        contentLabel.font = .systemFont(ofSize: 13)
    }
    
    func setInsetView() {
        insetView.backgroundColor = .systemGray6
        insetView.layer.cornerRadius = 10
        insetView.clipsToBounds = true
    }
    
    func setButton(_ button: UIButton,
                   normalImage: String) {
        let normalImage = UIImage(systemName: normalImage)
        
        button.setImage(normalImage, for: .normal)
        button.tintColor = .label
    }
    
    @IBAction func checkButtonTapped(_ sender: UIButton) {
        checkButtonSelected.toggle()
        if checkButtonSelected {
            sender.setImage(UIImage(systemName: "checkmark.square.fill"), for: .normal)
        } else {
            sender.setImage(UIImage(systemName: "checkmark.square"), for: .normal)
        }
        
    }
    
    @IBAction func starButtonTapped(_ sender: UIButton) {
        starButtonSelected.toggle()
        if starButtonSelected {
            sender.setImage(UIImage(systemName: "star.fill"), for: .normal)
        } else {
            sender.setImage(UIImage(systemName: "star"), for: .normal)
        }
    }
}
