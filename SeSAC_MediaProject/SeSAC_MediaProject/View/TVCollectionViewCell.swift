//
//  TVCollectionViewCell.swift
//  SeSAC_MediaProject
//
//  Created by Deokhun KIM on 1/30/24.
//

import UIKit

import Kingfisher
import SnapKit

final class TVCollectionViewCell: BaseCollectionViewCell {
    
    private let posterImageView = {
        let iv = UIImageView()
        iv.contentMode = .scaleAspectFill
        return iv
    }()
    
    private let titleLabel = UILabel()
    
    override func configureView() {
        contentView.addSubviews(posterImageView, titleLabel)
        
        posterImageView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        titleLabel.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(5)
            make.bottom.equalToSuperview().offset(-5)
            make.width.equalToSuperview().offset(-10)
        }
    }
}

extension TVCollectionViewCell: SetCell {
    
    func configureCellData(_ data: Model) {
        let url = URL(string: "https://image.tmdb.org/t/p/w500/\(data.posterPath ?? "")")
        posterImageView.kf.setImage(with: url)
        titleLabel.text = data.name
    }
    
    func configureUI() {
        configureView()
        posterImageView.contentMode = .scaleAspectFill
        posterImageView.clipsToBounds = true
        titleLabel.font = .boldSystemFont(ofSize: 14)
        titleLabel.textColor = .white
    }

}
