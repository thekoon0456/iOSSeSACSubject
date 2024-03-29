//
//  CityDetailTableViewCell.swift
//  SeSAC_TableAndCollectionView
//
//  Created by Deokhun KIM on 1/11/24.
//

import UIKit

import Kingfisher

final class CityDetailTableViewCell: UITableViewCell {
    
    @IBOutlet var titleLabel: UILabel!
    @IBOutlet var descriptionLabel: UILabel!
    @IBOutlet var mainImage: UIImageView!
    @IBOutlet var heartButton: UIButton!
    @IBOutlet var starStackView: UIStackView!
    @IBOutlet var etcLabel: UILabel!
    
    //버튼 클릭
    var isHeartButtonSelected = false
    
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
    
    func makeStarView(isSelected: Bool) -> UIImageView {
        if isSelected {
            let yellowStar = UIImage(systemName: ConstString.starFillImage)?
                .withRenderingMode(.alwaysOriginal).withTintColor(.customYellow)
            let yellowStarView = UIImageView(image: yellowStar)
            return yellowStarView
        } else {
            let emptyStar = UIImage(systemName: ConstString.starFillImage)?
                .withRenderingMode(.alwaysOriginal).withTintColor(.systemGray3)
            let emptyStarView = UIImageView(image: emptyStar)
            return emptyStarView
        }
    }
    
    //별 stackView추가
    func setStarStackView(count: Int) {
        for _ in 0..<count {
            starStackView.addArrangedSubview(makeStarView(isSelected: true))
        }
        
        for _ in 0..<(ConstInt.starCount - count) {
            starStackView.addArrangedSubview(makeStarView(isSelected: false))
        }
    }
}

//UI
extension CityDetailTableViewCell: SetCell {
    typealias T = Travel
    
    func configureCellData(_ data: Travel) {
        titleLabel.text = data.title
        descriptionLabel.text = data.description
        etcLabel.text = data.cellDetailLabel
        //하트 버튼 세팅
        setButtonImage(isSelected: data.like ?? true)
        
        //이미지 세팅
        mainImage.kf.setImage(with: URL(string: data.travel_image ?? ""),
                              placeholder: UIImage(named: ConstString.loadingImage))
        
        //별 갯수 세팅(반올림)
        let starCount = Int(trunc(data.grade ?? 0))
        setStarStackView(count: starCount)
    }
    
    func configureUI() {
        mainImage.contentMode = .scaleAspectFill
        setRoundedView(mainImage, cornerRadius: 10)
        
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
    
    func setButtonImage(isSelected: Bool) {
        if isSelected {
            heartButton.setImage(UIImage(systemName: ConstString.heartFillImage)?
                .withRenderingMode(.alwaysOriginal)
                .withTintColor(.customYellow), for: .normal)
        } else {
            heartButton.setImage(UIImage(systemName: ConstString.heartImage), for: .normal)
        }
    }
    
    func setButtons() {
        heartButton.tintColor = .white
        heartButton.addTarget(self,
                              action: #selector(heartButtonTapped),
                              for: .touchUpInside)
    }
}
