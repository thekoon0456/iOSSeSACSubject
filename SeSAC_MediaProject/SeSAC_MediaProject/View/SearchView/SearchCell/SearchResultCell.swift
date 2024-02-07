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
    
    // MARK: - Properties
    
    private let posterImageView = UIImageView().then {
        $0.contentMode = .scaleAspectFill
        $0.layer.cornerRadius = 8
        $0.clipsToBounds = true
    }
    
    private let titleLabel = UILabel().then {
        $0.font = .boldSystemFont(ofSize: 14)
        $0.textColor = .white
    }
    
    private let overViewLabel = UILabel().then {
        $0.font = .systemFont(ofSize: 13)
        $0.textColor = .white
        $0.numberOfLines = 0
    }
    
    // MARK: - Helpers
    
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
    }
}

extension SearchResultCell {
    
    func configureCellData(_ data: TVModel) {
        let url = URL(string: "https://image.tmdb.org/t/p/w500/\(data.posterPath ?? "")")
        let placeHolder = UIImage(systemName: "movieclapper")?.withTintColor(.white, renderingMode: .alwaysOriginal)
        posterImageView.kf.setImage(with: url, placeholder: placeHolder)
        titleLabel.text = data.name
        overViewLabel.text = data.overview
    }
}

