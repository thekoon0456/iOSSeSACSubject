//
//  SearchResultCell.swift
//  SeSAC_MediaProject
//
//  Created by Deokhun KIM on 2/5/24.
//

import UIKit

import Kingfisher
import SnapKit

final class SearchResultCell: BaseTableViewCell {
    
    private let posterImageView = UIImageView()
    private let titleLabel = UILabel()
    private let overViewLabel = UILabel()
    
    override func configureHierarchy() {
        contentView.addSubviews(posterImageView, titleLabel, overViewLabel)
    }
    
    override func configureLayout() {
        posterImageView.snp.makeConstraints { make in
            make.top.leading.equalToSuperview().offset(8)
            make.bottom.equalToSuperview().offset(-8)
            make.width.equalToSuperview().multipliedBy(0.3)
        }
        
        titleLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(8)
            make.leading.equalTo(posterImageView.snp.trailing).offset(8)
            make.trailing.equalToSuperview().offset(-8)
            make.height.equalTo(20)
        }
        
        overViewLabel.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(4)
            make.leading.equalTo(posterImageView.snp.trailing).offset(8)
            make.trailing.equalToSuperview().offset(-8)
            make.bottom.equalToSuperview().offset(-8)
        }
    }
    
    override func configureView() {
        contentView.backgroundColor = .black
        posterImageView.contentMode = .scaleAspectFill
        posterImageView.layer.cornerRadius = 8
        posterImageView.clipsToBounds = true
        titleLabel.font = .boldSystemFont(ofSize: 14)
        titleLabel.textColor = .white
        overViewLabel.font = .systemFont(ofSize: 13)
        overViewLabel.textColor = .white
        overViewLabel.numberOfLines = 0
    }
}

extension SearchResultCell {
    
    func configureCellData(_ data: TVModel) {
        let url = URL(string: "https://image.tmdb.org/t/p/w500/\(data.posterPath ?? "")")
        posterImageView.kf.setImage(with: url)
        titleLabel.text = data.name
        overViewLabel.text = data.overview
    }
}

