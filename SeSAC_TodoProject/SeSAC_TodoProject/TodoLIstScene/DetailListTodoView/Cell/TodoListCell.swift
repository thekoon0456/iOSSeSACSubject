//
//  TodoListCell.swift
//  SeSAC_TodoProject
//
//  Created by Deokhun KIM on 2/21/24.
//

import UIKit

import SnapKit

final class TodoListCell: BaseTableViewCell {
    
    // MARK: - Properties
    
    private lazy var bgView = UIView().then {
        $0.layer.cornerRadius = 20
        $0.clipsToBounds = true
    }
    
    private lazy var circleImageView = UIImageView().then {
        $0.contentMode = .scaleAspectFit
        $0.tintColor = .white
    }
    
    private let titleLabel = UILabel().then {
        $0.font = .systemFont(ofSize: 16)
    }
    
    private let countLabel = UILabel().then {
        $0.font = .systemFont(ofSize: 14)
        $0.textColor = .systemGray
        $0.textAlignment = .right
    }
    
    // MARK: - Helpers
    
    func configureCell(_ data: TodoListSection) {
        bgView.backgroundColor = data.colorName.toUIColor()
        circleImageView.image = UIImage(systemName: data.imageName)?.withTintColor(.white, renderingMode: .alwaysOriginal)
        titleLabel.text = data.todoListTitle
        countLabel.text = String(data.todo.count)
    }
    
    override func configureHierarchy() {
        contentView.addSubviews(bgView, titleLabel, countLabel)
        bgView.addSubview(circleImageView)
    }
    
    override func configureLayout() {
        bgView.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(16)
            make.centerY.equalToSuperview()
            make.size.equalTo(40)
        }
        
        circleImageView.snp.makeConstraints { make in
            make.top.leading.equalToSuperview().offset(4)
            make.trailing.bottom.equalToSuperview().offset(-4)
        }
        
        titleLabel.snp.makeConstraints { make in
            make.leading.equalTo(bgView.snp.trailing).offset(16)
            make.centerY.equalToSuperview()
            make.width.equalTo(200)
        }
        
        countLabel.snp.makeConstraints { make in
            make.width.equalTo(50)
            make.centerY.equalToSuperview()
            make.trailing.equalToSuperview().offset(-8)
        }
    }
    
    override func configureView() {
        
    }
}
