//
//  DramaDetailView.swift
//  SeSAC_MediaProject
//
//  Created by Deokhun KIM on 1/31/24.
//

import UIKit

final class DramaDetailView: BaseUIView {
    
    let backdropImageView = UIImageView()
    let posterImageView = UIImageView()
    let nameLabel = UILabel()
    let overViewLabel = UILabel()
    let lastAirDateLabel = UILabel()
    let numberOfEpisodesLabel = UILabel()
    
    var id: Int = 0

    override func configureHierarchy() {
        addSubviews(backdropImageView,
                    posterImageView
                    , nameLabel,
                    overViewLabel,
                    lastAirDateLabel,
                    numberOfEpisodesLabel)
    }
    
    override func configureLayout() {
        backdropImageView.snp.makeConstraints { make in
            make.edges.equalTo(safeAreaLayoutGuide)
        }
        
        posterImageView.snp.makeConstraints { make in
            make.top.equalTo(safeAreaLayoutGuide).offset(8)
            make.leading.equalToSuperview().offset(8)
            make.bottom.equalToSuperview().offset(-8)
            make.width.equalTo(posterImageView.snp.height).multipliedBy(0.7)
        }
        
        nameLabel.snp.makeConstraints { make in
            make.top.equalTo(safeAreaLayoutGuide).offset(8)
            make.leading.equalTo(posterImageView.snp.trailing).offset(12)
            make.trailing.equalToSuperview().offset(-12)
            make.height.equalTo(20)
        }
        
        overViewLabel.snp.makeConstraints { make in
            make.top.equalTo(nameLabel.snp.bottom).offset(8)
            make.leading.equalTo(posterImageView.snp.trailing).offset(12)
            make.trailing.equalToSuperview().offset(-12)
        }
        
        lastAirDateLabel.snp.makeConstraints { make in
            make.top.equalTo(overViewLabel.snp.bottom).offset(8)
            make.leading.equalTo(posterImageView.snp.trailing).offset(12)
            make.trailing.equalToSuperview().offset(-12)
        }
        
        numberOfEpisodesLabel.snp.makeConstraints { make in
            make.top.equalTo(lastAirDateLabel.snp.bottom).offset(4)
            make.leading.equalTo(posterImageView.snp.trailing).offset(12)
            make.trailing.equalToSuperview().offset(-12)
            make.bottom.equalToSuperview().offset(-8)
        }
    }
    
    override func configureView() {
        backgroundColor = .black
        backdropImageView.alpha = 0.5
        posterImageView.contentMode = .scaleAspectFill
        posterImageView.clipsToBounds = true
        overViewLabel.numberOfLines = 0
        nameLabel.font = .systemFont(ofSize: 16)
        
        [nameLabel, overViewLabel, lastAirDateLabel, numberOfEpisodesLabel].forEach { label in
            label.textColor = .white
            label.font = .systemFont(ofSize: 14)
        }
    }
    
    func setDramaDetailView(data: DramaDetail) {
        self.id = data.id
        let backdropUrl = URL(string: "https://image.tmdb.org/t/p/w500/\(data.backdropPath)")
        let posterUrl = URL(string: "https://image.tmdb.org/t/p/w500/\(data.posterPath ?? "")")
        backdropImageView.kf.setImage(with: backdropUrl)
        posterImageView.kf.setImage(with: posterUrl)
        nameLabel.text = data.name
        overViewLabel.text = data.overview
        lastAirDateLabel.text = "최근 방영일: " + data.lastAirDate
        numberOfEpisodesLabel.text = "총 에피소드 : \(data.numberOfEpisodes)개"
    }
}
