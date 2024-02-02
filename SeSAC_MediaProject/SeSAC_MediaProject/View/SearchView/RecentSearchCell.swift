//
//  RecentSearchCell.swift
//  SeSAC_MediaProject
//
//  Created by Deokhun KIM on 2/2/24.
//

import UIKit

final class RecentSearchCell: BaseTableViewCell {
    
    // MARK: - Properties
    
    private let magImageView = UIImageView()
    private let searchLabel = UILabel()
    let deleteButton = UIButton()
    
    // MARK: - Lifecycles
    
    override func configureHierarchy() {
        contentView.addSubviews(magImageView, searchLabel, deleteButton)
    }
    
    override func configureLayout() {
        setLayout()
    }
    
    override func configureView() {
        configureImage()
        configureLabel()
        configureButton()
    }
}

// MARK: - Configure

extension RecentSearchCell {

    func configureCellData(_ data: String) {
        searchLabel.text = data
    }

    private func configureImage() {
        magImageView.image = UIImage(systemName: "magnifyingglass")?.withTintColor(.white, renderingMode: .alwaysOriginal)
        magImageView.contentMode = .scaleAspectFit
    }
    
    private func configureLabel() {
        searchLabel.textColor = .label
    }
    
    private func configureButton() {
        deleteButton.setImage(UIImage(systemName: "xmark"),
                              for: .normal)
        deleteButton.tintColor = .systemGray
        deleteButton.contentEdgeInsets = .init(top: 20, left: 20, bottom: 20, right: 20)
    }
    
    private func setLayout() {
        magImageView.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(16)
            make.centerY.equalToSuperview()
            make.size.equalTo(30)
        }
        
        searchLabel.snp.makeConstraints { make in
            make.leading.equalTo(magImageView.snp.trailing).offset(16)
            make.centerY.equalToSuperview()
        }
        
        deleteButton.snp.makeConstraints { make in
            make.leading.equalTo(searchLabel.snp.trailing).offset(16)
            make.trailing.top.bottom.equalToSuperview()
            make.width.equalTo(deleteButton.snp.height)
        }
    }
}
