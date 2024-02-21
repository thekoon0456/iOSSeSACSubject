//
//  InputTitleCell.swift
//  SeSAC_TodoProject
//
//  Created by Deokhun KIM on 2/20/24.
//

import UIKit

final class InputTitleCell: BaseTableViewCell {

    lazy var bgView = UIView().then {
        $0.layer.cornerRadius = 50
        $0.clipsToBounds = true
        $0.backgroundColor = .systemGray
    }
    
    lazy var circleImageView = UIImageView().then {
        $0.contentMode = .scaleAspectFit
        $0.tintColor = .white
    }
    
    let textField = UITextField().then {
        $0.placeholder = "목록 이름"
        $0.backgroundColor = .darkGray
        $0.textAlignment = .center
        $0.layer.cornerRadius = 5
    }
    
    // MARK: - Helpers
    
    override func configureHierarchy() {
        contentView.addSubviews(bgView, textField)
        bgView.addSubview(circleImageView)
    }
    
    override func configureLayout() {
        bgView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(24)
            make.centerX.equalToSuperview()
            make.height.width.equalTo(100)
        }
        
        circleImageView.snp.makeConstraints { make in
            make.top.leading.equalToSuperview().offset(12)
            make.trailing.bottom.equalToSuperview().offset(-12)
        }
        
        textField.snp.makeConstraints { make in
            make.height.equalTo(50)
            make.top.equalTo(bgView.snp.bottom).offset(24)
            make.leading.equalToSuperview().offset(20)
            make.trailing.equalToSuperview().offset(-20)
            make.bottom.equalToSuperview().offset(-24)
        }
    }
}
