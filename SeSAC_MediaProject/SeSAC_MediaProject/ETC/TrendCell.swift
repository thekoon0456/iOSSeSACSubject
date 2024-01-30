//
//  TrendCell.swift
//  SeSAC_MediaProject
//
//  Created by Deokhun KIM on 1/25/24.
//

//import UIKit
//
//class TrendCell: UITableViewCell {
//    
//    private let dateLabel = {
//        let label = UILabel()
//        label.font = .systemFont(ofSize: 13)
//        label.textColor = .darkGray
//        label.translatesAutoresizingMaskIntoConstraints = false
//        return label
//    }()
//    
//    private let genreLabel = {
//        let label = UILabel()
//        label.font = .systemFont(ofSize: 15, weight: .bold)
//        label.translatesAutoresizingMaskIntoConstraints = false
//        return label
//    }()
//    
//    private let posterView = {
//        let imageView = UIImageView()
//        imageView.contentMode = .scaleAspectFill
//        imageView.layer.cornerRadius = 10
//        imageView.clipsToBounds = true
//        imageView.translatesAutoresizingMaskIntoConstraints = false
//        return imageView
//    }()
//    
//    private lazy var clipButton = {
//        let button = UIButton()
//        button.setImage(UIImage(systemName: "paperclip"), for: .normal)
//        button.layer.cornerRadius = 20
//        button.clipsToBounds = true
//        button.translatesAutoresizingMaskIntoConstraints = false
//        return button
//    }()
//    
//    private let scoreTitleLabel = {
//        let label = UILabel()
//        label.font = .systemFont(ofSize: 13)
//        label.backgroundColor = .purple
//        label.textColor = .white
//        label.translatesAutoresizingMaskIntoConstraints = false
//        return label
//    }()
//    
//    private let scoreLabel = {
//        let label = UILabel()
//        label.font = .systemFont(ofSize: 13)
//        label.backgroundColor = .white
//        label.translatesAutoresizingMaskIntoConstraints = false
//        return label
//    }()
//    
//    private let whiteView = {
//        let view = UIView()
//        view.backgroundColor = .white
//        view.translatesAutoresizingMaskIntoConstraints = false
//        return view
//    }()
//    
//    private let titleLabel = {
//        let label = UILabel()
//        label.font = .systemFont(ofSize: 15, weight: .semibold)
//        label.translatesAutoresizingMaskIntoConstraints = false
//        return label
//    }()
//    
//    private let overViewLabel = {
//        let label = UILabel()
//        label.font = .systemFont(ofSize: 14)
//        label.textColor = .darkGray
//        label.translatesAutoresizingMaskIntoConstraints = false
//        return label
//    }()
//    
//    private let lineView = {
//        let view = UIView()
//        view.backgroundColor = .darkGray
//        view.translatesAutoresizingMaskIntoConstraints = false
//        return view
//    }()
//    
//    private let detailLabel = {
//        let label = UILabel()
//        label.font = .systemFont(ofSize: 13)
//        label.textColor = .darkGray
//        label.translatesAutoresizingMaskIntoConstraints = false
//        return label
//    }()
//    
//    private let nextButton = {
//        let button = UIButton()
//        button.setImage(UIImage(systemName: "chevron.right"), for: .normal)
//        button.translatesAutoresizingMaskIntoConstraints = false
//        return button
//    }()
//    
//    
//    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
//        super.init(style: style, reuseIdentifier: reuseIdentifier)
//        
//        configureUI()
//    }
//    
//    required init?(coder: NSCoder) {
//        fatalError("init(coder:) has not been implemented")
//    }
//    
//    
//}
//
//extension TrendCell: SetCell {
//
//    typealias T = Trend
//    
//    func configureCellData(_ data: Trend) {
//        dateLabel.text = data.releaseDate
//        genreLabel.text = "\(data.genreIDS.first)"
////        posterView.image =
//        scoreLabel.text = "\(data.voteAverage)"
//        titleLabel.text = data.title
//        overViewLabel.text = data.overview
//    }
//    
//    func configureUI() {
//        addSubviews(dateLabel, genreLabel, posterView, whiteView)
//        posterView.addSubviews(clipButton, scoreTitleLabel, scoreLabel)
//        whiteView.addSubviews(titleLabel, overViewLabel, lineView, detailLabel, nextButton)
//        
//        
//        NSLayoutConstraint.activate([
//            dateLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 0),
//            dateLabel.heightAnchor.constraint(equalToConstant: 12),
//            
//            genreLabel.topAnchor.constraint(equalTo: dateLabel.bottomAnchor, constant: 4),
//            genreLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 0),
//            
//            posterView.topAnchor.constraint(equalTo: genreLabel.bottomAnchor, constant: 8),
//            posterView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 0),
//            posterView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: 0),
//            posterView.heightAnchor.constraint(equalTo: widthAnchor, multiplier: 1.5),
//            posterView.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 0.9),
//            posterView.centerXAnchor.constraint(equalTo: centerXAnchor),
//            
//            whiteView.widthAnchor.constraint(equalTo: widthAnchor),
//            whiteView.heightAnchor.constraint(equalToConstant: 200),
//            
//            titleLabel.topAnchor.constraint(equalTo: whiteView.topAnchor, constant: 12),
//            titleLabel.leadingAnchor.constraint(equalTo: whiteView.leadingAnchor, constant: 12),
//            
//            overViewLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 4),
//            overViewLabel.leadingAnchor.constraint(equalTo: whiteView.leadingAnchor, constant: 12),
//            
//            lineView.topAnchor.constraint(equalTo: overViewLabel.bottomAnchor, constant: 12),
//            lineView.widthAnchor.constraint(equalTo: whiteView.widthAnchor, multiplier: 0.9),
//            lineView.centerXAnchor.constraint(equalTo: whiteView.centerXAnchor),
//            lineView.heightAnchor.constraint(equalToConstant: 1),
//            
//            detailLabel.topAnchor.constraint(equalTo: lineView.bottomAnchor, constant: 12),
//            detailLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -12),
//            
//            nextButton.topAnchor.constraint(equalTo: lineView.bottomAnchor, constant: 12),
//            nextButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -12)
//        ])
//        
//    }
//    
//}
