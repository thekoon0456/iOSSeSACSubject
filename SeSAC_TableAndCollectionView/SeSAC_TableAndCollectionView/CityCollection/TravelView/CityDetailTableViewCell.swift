//
//  CityDetailTableViewCell.swift
//  SeSAC_TableAndCollectionView
//
//  Created by Deokhun KIM on 1/11/24.
//

import UIKit

import Kingfisher

class CityDetailTableViewCell: UITableViewCell {
    
    @IBOutlet var titleLabel: UILabel!
    @IBOutlet var descriptionLabel: UILabel!
    @IBOutlet var mainImage: UIImageView!
    @IBOutlet var heartButton: UIButton!
    @IBOutlet var starStackView: UIStackView!
    @IBOutlet var etcLabel: UILabel!
    
    var isHeartButtonSelected = false
    
    static let cellID = "CityDetailTableViewCell"
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        configureUI()
        setButtons()
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        starStackView = UIStackView()
    }
    
    @objc func heartButtonTapped() {
        isHeartButtonSelected.toggle()
        
        setButtonImage(isSelected: isHeartButtonSelected)
    }
    
    func setCellData(_ data: Travel) {
        titleLabel.text = data.title
        descriptionLabel.text = data.description
        
        let placeHolderImage = UIImage(named: "loadingImage")
        mainImage.kf.setImage(with: URL(string: data.travel_image ?? ""),
                              placeholder: placeHolderImage)
        
        let starCount = Int(data.grade?.rounded() ?? 0)
        setStarStackView(count: starCount)
        
        etcLabel.text = "(3) • 저장 \(String(data.save ?? 0))"
        
        setButtonImage(isSelected: data.like ?? true)
    }
    
    func setStarStackView(count: Int) {
        for _ in 0..<count {
            let yellowStar = UIImage(systemName: "star.fill")?
                .withRenderingMode(.alwaysOriginal).withTintColor(.yellow)
            let yellowStarView = UIImageView(image: yellowStar)
//            yellowStarView.frame.size = .init(width: 10, height: 10)

            starStackView.addArrangedSubview(yellowStarView)
        }
        
        for _ in 0..<(5 - count) {
            let emptyStar = UIImage(systemName: "star.fill")?
                .withRenderingMode(.alwaysOriginal).withTintColor(.systemGray3)
            let emptyStarView = UIImageView(image: emptyStar)
//            emptyStarView.frame.size = .init(width: 10, height: 10)
            
            starStackView.addArrangedSubview(emptyStarView)
        }
    }
    
    func setButtonImage(isSelected: Bool) {
        if isSelected {
            heartButton.setImage(UIImage(systemName: "heart.fill")?
                .withRenderingMode(.alwaysOriginal)
                .withTintColor(.yellow), for: .normal)
        } else {
            heartButton.setImage(UIImage(systemName: "heart"), for: .normal)
        }
    }
    
    func setButtons() {
        heartButton.tintColor = .white
        heartButton.addTarget(self, action: #selector(heartButtonTapped), for: .touchUpInside)
    }
    
    func configureUI() {
        mainImage.contentMode = .scaleAspectFill
        mainImage.layer.cornerRadius = 10
        mainImage.clipsToBounds = true
        
        titleLabel.font = .boldSystemFont(ofSize: 18)
        
        descriptionLabel.font = .systemFont(ofSize: 14)
        descriptionLabel.textColor = .darkGray
        descriptionLabel.numberOfLines = 0
        
        starStackView.spacing = 3
        starStackView.axis = .horizontal
        starStackView.distribution = .fillEqually
        
        etcLabel.font = .systemFont(ofSize: 12)
        etcLabel.textColor = .systemGray2
    }
}
