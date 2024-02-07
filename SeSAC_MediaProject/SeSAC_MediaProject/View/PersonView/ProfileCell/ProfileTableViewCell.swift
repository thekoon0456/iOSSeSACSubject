//
//  ProfileTableViewCell.swift
//  SeSAC_MediaProject
//
//  Created by Deokhun KIM on 2/7/24.
//

import UIKit

final class ProfileTableViewCell: BaseTableViewCell {
    
    // MARK: - Properties
    
    private let titleLabel = UILabel().then {
        $0.font = .systemFont(ofSize: 14)
        $0.textColor = .white
    }
    
    private lazy var textfield = UITextField().then {
        $0.placeholder = titleLabel.text
        $0.isUserInteractionEnabled = false
    }
    
    private let button = UIButton().then {
        $0.setImage(UIImage(systemName: "chevron.right")?.withTintColor(.white, renderingMode: .alwaysOriginal), for: .normal)
        $0.isHidden = true
    }
    
    // MARK: - Lifecycles
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        button.isHidden = true
    }
    
    // MARK: - Helpers
    
    override func configureHierarchy() {
        contentView.addSubviews(titleLabel, textfield, button)
    }
    
    override func configureLayout() {
        titleLabel.snp.makeConstraints { make in
            make.top.leading.bottom.equalToSuperview().inset(4)
            make.width.equalToSuperview().multipliedBy(0.3)
        }
        
        textfield.snp.makeConstraints { make in
            make.leading.equalTo(titleLabel.snp.trailing).offset(8)
            make.verticalEdges.equalToSuperview().inset(4)
            make.trailing.equalTo(button.snp.leading)
        }
        
        button.snp.makeConstraints { make in
            make.trailing.equalToSuperview().offset(-4)
            make.size.equalTo(contentView.snp.height)
        }
    }
    
    func setButton(isLink: String) {
        if isLink == "링크" {
            button.isHidden = false
        }
    }
    
    func configureCellData(input: String) {
        titleLabel.text = input
        textfield.placeholder = input
        setButton(isLink: input)
    }
    
    func setTextFieldText(input: String?) {
        textfield.text = input
    }
}
