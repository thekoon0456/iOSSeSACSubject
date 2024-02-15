//
//  InputHeaderView.swift
//  SeSAC_TodoProject
//
//  Created by Deokhun KIM on 2/14/24.
//

import UIKit

final class InputHeaderCell: BaseTableViewCell {
    
    // MARK: - Properties
    
    let titleTextField = UITextField().then {
        $0.placeholder = "제목"
        $0.tintColor = .white
        $0.leftPadding(10)
    }
    
    let memoTextView = UITextView().then {
        $0.backgroundColor = .clear
        $0.tintColor = .white
        $0.text = "텍스트를 여기에 입력하세요."
        $0.textColor = .systemGray
        $0.font = .systemFont(ofSize: 14)
    }
    
    private let lineView = UIView().then {
        $0.backgroundColor = .systemGray
    }
    
    // MARK: - Helpers
    
    override func configureHierarchy() {
        contentView.addSubviews(titleTextField, lineView, memoTextView)
    }
    
    override func configureLayout() {
        titleTextField.snp.makeConstraints { make in
            make.top.leading.trailing.equalToSuperview()
            make.height.equalTo(50)
        }
        
        lineView.snp.makeConstraints { make in
            make.top.equalTo(titleTextField.snp.bottom)
            make.leading.trailing.equalToSuperview()
            make.height.equalTo(1)
        }
        
        memoTextView.snp.makeConstraints { make in
            make.top.equalTo(lineView.snp.bottom)
            make.leading.equalToSuperview().offset(8)
            make.trailing.equalToSuperview().offset(-8)
            make.height.equalTo(100)
        }
    }
}
