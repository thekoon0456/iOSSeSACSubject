//
//  CityCollectionViewCell.swift
//  SeSAC_MakeTableViewController
//
//  Created by Deokhun KIM on 1/9/24.
//

import UIKit

import Kingfisher

class CityCollectionViewCell: UICollectionViewCell {
    
    static let cellID = "CityCollectionViewCell"
    
    @IBOutlet var cityImageView: UIImageView!
    @IBOutlet var titleLabel: UILabel!
    @IBOutlet var descriptionLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        configureUI()
    }
}

extension CityCollectionViewCell: setUI {
    
    func configureUI() {
        cityImageView.contentMode = .scaleAspectFill
        cityImageView.layer.cornerRadius = ConstFloat.cellCornerRadious.value
        cityImageView.clipsToBounds = true
        
        titleLabel.textAlignment = .center
        titleLabel.font = .boldSystemFont(ofSize: 15)
        
        descriptionLabel.textAlignment = .center
        descriptionLabel.textColor = .lightGray
        descriptionLabel.font = .systemFont(ofSize: 12)
        descriptionLabel.numberOfLines = 0
    }
}
    
extension CityCollectionViewCell: setCell {
    typealias T = City
    
    func configureCellData(data: City) {
        cityImageView.kf.setImage(with: URL(string: data.city_image),
                                  placeholder: UIImage(named: ConstString.loadingImage))
        titleLabel.text = data.cellTitleLabel
        descriptionLabel.text = data.city_explain
    }
}
