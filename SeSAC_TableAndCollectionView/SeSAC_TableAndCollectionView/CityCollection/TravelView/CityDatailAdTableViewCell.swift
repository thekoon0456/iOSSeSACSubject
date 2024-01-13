//
//  CityDatailAdTableViewCell.swift
//  SeSAC_TableAndCollectionView
//
//  Created by Deokhun KIM on 1/11/24.
//

import UIKit

final class CityDatailAdTableViewCell: UITableViewCell {
    
    @IBOutlet var mentLabel: UILabel!
    @IBOutlet var adLabel: UILabel!
    
    static var identifier: String {
        return String(describing: self)
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        configureUI()
    }
    
    func setCellData(_ data: Travel) {
         mentLabel.text = data.title
    }
    
    func setBGColor() {
        let red = CGFloat.random(in: 0...1)
        let green = CGFloat.random(in: 0...1)
        let blue = CGFloat.random(in: 0...1)
        
        let color = UIColor(red: red,
                            green: green,
                            blue: blue,
                            alpha: 1)
        
        contentView.backgroundColor = color
    }
}

//UI
extension CityDatailAdTableViewCell {
    func configureUI() {
        setBGColor()
        
        mentLabel.font = .boldSystemFont(ofSize: 18)
        mentLabel.textAlignment = .center
        mentLabel.numberOfLines = 0
        
        adLabel.text = ConstString.ad
        adLabel.font = .systemFont(ofSize: 14)
        adLabel.textAlignment = .center
        adLabel.backgroundColor = .white
        setRoundedView(adLabel, cornerRadius: 5)
    }
}
