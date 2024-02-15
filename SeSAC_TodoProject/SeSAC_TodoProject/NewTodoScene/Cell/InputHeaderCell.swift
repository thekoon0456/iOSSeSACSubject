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
    
    let memoTextField = UITextField().then {
        $0.placeholder = "메모"
        $0.tintColor = .white
        $0.leftPadding(10)
    }
    
    private let lineView = UIView().then {
        $0.backgroundColor = .systemGray
    }
    
    override func configureHierarchy() {
        contentView.addSubviews(titleTextField, lineView, memoTextField)
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
        
        memoTextField.snp.makeConstraints { make in
            make.top.equalTo(lineView.snp.bottom)
            make.leading.trailing.equalToSuperview()
            make.height.equalTo(100)
        }
    }
    
    override func configureView() {
        
    }
}
