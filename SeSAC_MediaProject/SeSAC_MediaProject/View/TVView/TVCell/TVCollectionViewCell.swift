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
    
    private let posterImageView = UIImageView()
    private let titleLabel = UILabel()
    
    override func configureHierarchy() {
        contentView.addSubviews(posterImageView, titleLabel)
    }
    
    override func configureLayout() {
        posterImageView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        titleLabel.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(5)
            make.bottom.equalToSuperview().offset(-5)
            make.width.equalToSuperview().offset(-10)
        }
    }
    
    override func configureView() {
        titleLabel.textColor = .white
        posterImageView.contentMode = .scaleAspectFill
        posterImageView.clipsToBounds = true
        titleLabel.font = .boldSystemFont(ofSize: 14)
        titleLabel.textColor = .white
    }
}

extension TVCollectionViewCell {
    
    func configureCellData(_ data: TVModel) {
        let url = URL(string: "https://image.tmdb.org/t/p/w500/\(data.posterPath ?? "")")
        posterImageView.kf.setImage(with: url)
        titleLabel.text = data.name
    }
    
    func configureCellData(_ data: CastModel) {
        let url = URL(string: "https://image.tmdb.org/t/p/w500/\(data.posterPath ?? "")")
        posterImageView.kf.setImage(with: url)
        titleLabel.text = data.name
    }
    
    // MARK: - cell에서 구현할때는 제네릭보다는 차라리 모델마다 개별적인 함수를 만들어서 관리하기
    //타입캐스팅도 리소스가 들고, 나중에 관리가 힘들어짐
//    func configureCellData<T: Decodable>(_ data: T) {
//        if let data = data as? TVModel  {
//            let url = URL(string: "https://image.tmdb.org/t/p/w500/\(data.posterPath ?? "")")
//            posterImageView.kf.setImage(with: url)
//            titleLabel.text = data.name
//        }
//        if let data = data as? CastModel {
//            let url = URL(string: "https://image.tmdb.org/t/p/w500/\(data.posterPath ?? "")")
//            posterImageView.kf.setImage(with: url)
//            titleLabel.text = data.name
//        }
//    }
}
