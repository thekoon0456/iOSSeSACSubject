//
//  WholeTodoCell.swift
//  SeSAC_TodoProject
//
//  Created by Deokhun KIM on 2/14/24.
//

import UIKit

struct WholeTodo {
    let color: UIColor
    let imageName: String
    let title: String
    let count: Int?
}

final class WholeTodoCell: BaseCollectionViewCell {
    
    // MARK: - Properties
    
    private lazy var circleBGView = UIView().then {
        $0.layer.cornerRadius = 15
        $0.clipsToBounds = true
        $0.addSubview(iconView)
        
        iconView.snp.makeConstraints { make in
            make.top.leading.equalToSuperview().offset(4)
            make.trailing.bottom.equalToSuperview().offset(-4)
        }
    }
    
    private let iconView = UIImageView().then {
        $0.contentMode = .scaleAspectFill
    }
    
    private let titleLabel = UILabel().then {
        $0.font = .systemFont(ofSize: 14)
        $0.textColor = .systemGray
    }
    
    private let countLabel = UILabel().then {
        $0.font = .boldSystemFont(ofSize: 25)
    }
    
    // MARK: - Helpers
    
    func configureCell(data: TodoSection) {
        circleBGView.backgroundColor = data.bgColor
        setImageView(systemName: data.imageName)
        titleLabel.text = data.title
        
        //TODO: -count 연동
//        guard let count = data.count else { return }
//        countLabel.text = String(count)
    }
    
    private func setImageView(systemName: String) {
        let image = UIImage(systemName: systemName)?.withTintColor(.white, renderingMode: .alwaysOriginal)
        iconView.image = image
    }
    
    override func configureHierarchy() {
        contentView.addSubviews(circleBGView, titleLabel, countLabel)
    }
    
    override func configureLayout() {
        circleBGView.snp.makeConstraints { make in
            make.size.equalTo(30)
            make.top.leading.equalToSuperview().offset(10)
        }
        
        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(circleBGView.snp.bottom).offset(8)
            make.leading.equalToSuperview().offset(10)
        }
        
        countLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(10)
            make.trailing.equalToSuperview().offset(-10)
        }
    }
    
    override func configureView() {
        super.configureView()
        
    }
}
