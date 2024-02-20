//
//  InputTitleCell.swift
//  SeSAC_TodoProject
//
//  Created by Deokhun KIM on 2/20/24.
//

import UIKit

final class InputTitleCell: BaseTableViewCell {
    
    private let circleImageView = UIImageView().then {
        $0.isUserInteractionEnabled = true
        $0.contentMode = .scaleAspectFill
        $0.clipsToBounds = true
        $0.layer.cornerRadius = 50
        $0.backgroundColor = .systemGray
    }
    
    let textField = UITextField().then {
        $0.placeholder = "목록 이름"
        $0.backgroundColor = .darkGray
        $0.textAlignment = .center
        $0.layer.cornerRadius = 5
    }
    
    // MARK: - Helpers
    
    override func configureHierarchy() {
        contentView.addSubviews(circleImageView, textField)
    }
    
    override func configureLayout() {
        circleImageView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(24)
            make.centerX.equalToSuperview()
            make.size.equalTo(100)
        }
        
        textField.snp.makeConstraints { make in
            make.top.equalTo(circleImageView.snp.bottom).offset(24)
            make.leading.equalToSuperview().offset(20)
            make.trailing.equalToSuperview().offset(-20)
            make.height.equalTo(60)
            make.bottom.equalToSuperview().offset(-24)
        }
    }
    
    override func configureView() {
    }
    
}
