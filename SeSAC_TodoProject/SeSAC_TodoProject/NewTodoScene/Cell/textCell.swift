//
//  textCell.swift
//  SeSAC_TodoProject
//
//  Created by Deokhun KIM on 2/14/24.
//

import UIKit

import SnapKit

final class textCell: BaseTableViewCell {
    
    // MARK: - Properties
    
    private let titleLabel = UILabel().then {
        $0.font = .systemFont(ofSize: 16)
    }
    private let valueLabel = UILabel().then {
        $0.font = .systemFont(ofSize: 14)
        $0.textColor = .systemGray
        $0.textAlignment = .right
    }
    
    // MARK: - Helpers
    
    func configureCell(title: String, value: String?) {
        self.titleLabel.text = title
        self.valueLabel.text = value
    }
    
    override func configureHierarchy() {
        contentView.addSubviews(titleLabel, valueLabel)
    }
    
    override func configureLayout() {
        titleLabel.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(12)
            make.centerY.equalToSuperview()
            make.width.equalTo(80)
        }
        
        valueLabel.snp.makeConstraints { make in
            make.leading.equalTo(titleLabel.snp.trailing).offset(12)
            make.trailing.equalToSuperview().offset(-12)
            make.centerY.equalToSuperview()
        }
    }
    
    override func configureView() {
        accessoryType = .disclosureIndicator
    }
}
