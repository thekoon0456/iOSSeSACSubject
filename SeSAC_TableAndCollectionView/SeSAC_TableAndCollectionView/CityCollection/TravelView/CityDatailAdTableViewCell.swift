//
//  CityDatailAdTableViewCell.swift
//  SeSAC_TableAndCollectionView
//
//  Created by Deokhun KIM on 1/11/24.
//

import UIKit

class CityDatailAdTableViewCell: UITableViewCell {
    
    @IBOutlet var mentLabel: UILabel!
    @IBOutlet var adLabel: UILabel!
    
    static let cellID = "CityDatailAdTableViewCell"
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        configureUI()
    }
    
    func setCellData(_ data: Travel) {
         mentLabel.text = data.title
    }
    
    func configureUI() {
        let red = CGFloat.random(in: 0...1)
        let green = CGFloat.random(in: 0...1)
        let blue = CGFloat.random(in: 0...1)
        
        let color = UIColor(red: red,
                            green: green,
                            blue: blue,
                            alpha: 1)
        
        contentView.backgroundColor = color
        
        mentLabel.font = .boldSystemFont(ofSize: 18)
        mentLabel.textAlignment = .center
        mentLabel.numberOfLines = 0
        
        adLabel.text = "AD"
        adLabel.font = .systemFont(ofSize: 14)
        adLabel.textAlignment = .center
        adLabel.backgroundColor = .white
        adLabel.layer.cornerRadius = 5
        adLabel.clipsToBounds = true
    }
}