//
//  imageSelectCell.swift
//  SeSAC_TodoProject
//
//  Created by Deokhun KIM on 2/19/24.
//

import UIKit

import SnapKit

final class ImageSelectCell: BaseTableViewCell {
    
    // MARK: - Properties
    
    private let titleLabel = UILabel().then {
        $0.font = .systemFont(ofSize: 16)
    }
    private let selectedImageView = UIImageView().then {
        $0.contentMode = .scaleAspectFill
        $0.clipsToBounds = true
        $0.backgroundColor = .systemGray
    }
    
    // MARK: - Helpers
    
    func configureCell(title: String, value: UIImage?) {
        titleLabel.text = title
        selectedImageView.image = value
    }
    
    override func configureHierarchy() {
        contentView.addSubviews(titleLabel, selectedImageView)
    }
    
    override func configureLayout() {
        titleLabel.snp.makeConstraints { make in
            make.top.leading.equalToSuperview().offset(12)
            make.width.equalTo(80)
            make.centerY.equalToSuperview()
        }
        
        selectedImageView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(12)
            make.leading.equalTo(titleLabel.snp.trailing).offset(12)
            make.trailing.bottom.equalToSuperview().offset(-12)
        }
    }
    
    override func configureView() {
        accessoryType = .disclosureIndicator
    }
}
