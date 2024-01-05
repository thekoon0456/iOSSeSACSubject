//
//  ShoppingTableViewCell.swift
//  SeSAC_MakeTableViewController
//
//  Created by Deokhun KIM on 1/5/24.
//

import UIKit

class ShoppingTableViewCell: UITableViewCell {
    
    static let cellID = "ShoppingTableViewCell"
    
    @IBOutlet var checkButton: UIButton!
    @IBOutlet var starButton: UIButton!
    @IBOutlet var contentLabel: UILabel!
    
    override func awakeFromNib() {
//        super.awakeFromNib()

        configureUI()
    }
    
    func setValue(content: String) {
        contentLabel.text = content
    }
    
    func configureUI() {
        contentView.backgroundColor = .systemGray6
        contentView.layer.cornerRadius = 10
        contentView.clipsToBounds = true
        
        setButton(checkButton,
                  normalImage: "checkmark.square")
        setButton(starButton,
                  normalImage: "star")
    }
    
    func setButton(_ button: UIButton,
                   normalImage: String) {
        let normalImage = UIImage(systemName: normalImage)
        
        button.setImage(normalImage, for: .normal)
        button.tintColor = .label
    }
    
    @IBAction func checkButtonTapped(_ sender: UIButton) {
        sender.setImage(UIImage(systemName: "checkmark.square.fill"), for: .normal)
        print("눌림")
    }
    
    @IBAction func starButtonTapped(_ sender: UIButton) {
        sender.setImage(UIImage(systemName: "star.fill"), for: .normal)
        print("눌림")
    }
}
