//
//  DramaDetailView.swift
//  SeSAC_MediaProject
//
//  Created by Deokhun KIM on 1/31/24.
//

import UIKit

class DramaDetailView: UIView {
    
    let posterImageView = UIImageView()
    let name = UILabel()
    let overView = UILabel()
    let lastAirDate = UILabel()
    let numberOfEpisodes = UILabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        configureHierarchy()
        configureLayout()
        configureView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configureHierarchy() {
        addSubviews(posterImageView, name, overView, lastAirDate, numberOfEpisodes)
    }
    
    func configureLayout() {
        posterImageView.snp.makeConstraints { make in
            make.top.equalTo(safeAreaLayoutGuide)
            make.leading.equalToSuperview().offset(8)
            make.bottom.equalToSuperview().offset(-8)
            make.width.equalTo(posterImageView.snp.height).multipliedBy(0.7)
        }
        
        name.snp.makeConstraints { make in
            make.top.equalTo(safeAreaLayoutGuide).offset(12)
            make.leading.equalTo(posterImageView.snp.trailing).offset(12)
            make.trailing.equalToSuperview().offset(-12)
            make.height.equalTo(20)
        }
        
        overView.snp.makeConstraints { make in
            make.top.equalTo(name.snp.bottom).offset(8)
            make.leading.equalTo(posterImageView.snp.trailing).offset(12)
            make.trailing.equalToSuperview().offset(-12)
        }
        
        lastAirDate.snp.makeConstraints { make in
            make.top.equalTo(overView.snp.bottom).offset(8)
            make.leading.equalTo(posterImageView.snp.trailing).offset(12)
            make.trailing.equalToSuperview().offset(-12)
        }
        
        numberOfEpisodes.snp.makeConstraints { make in
            make.top.equalTo(lastAirDate.snp.bottom).offset(8)
            make.leading.equalTo(posterImageView.snp.trailing).offset(12)
            make.trailing.equalToSuperview().offset(-12)
            make.bottom.equalToSuperview().offset(-8)
        }
    }
    
    private func configureView() {
        backgroundColor = .white
        posterImageView.contentMode = .scaleAspectFill
        posterImageView.clipsToBounds = true
        overView.numberOfLines = 0
    }
}
