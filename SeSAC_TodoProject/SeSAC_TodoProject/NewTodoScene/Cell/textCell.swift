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
    
    private let titleLabel = UILabel()
    private let valueLabel = UILabel()
    
    // MARK: - Helpers
    
    func configureCell(title: String, value: String) {
        self.titleLabel.text = title
        self.valueLabel.text = value
    }
    
    override func configureHierarchy() {
        contentView.addSubviews(titleLabel, valueLabel)
    }
    
    override func configureLayout() {
        titleLabel.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(10)
            make.centerY.equalToSuperview()
        }
        
        valueLabel.snp.makeConstraints { make in
            make.leading.equalTo(titleLabel.snp.trailing).offset(10)
            make.trailing.equalToSuperview().offset(-20).priority(.low)
            make.centerY.equalToSuperview()
        }
    }
    
    override func configureView() {
        accessoryType = .disclosureIndicator
    }
}
