//
//  DetailCell.swift
//  SeSAC_TodoProject
//
//  Created by Deokhun KIM on 2/15/24.
//

import UIKit

final class DetailCell: BaseTableViewCell {
    
    // MARK: - Properties
    
    private lazy var completeButton = UIButton().then {
        let image = UIImage(systemName: "circle")?.applyingSymbolConfiguration(.init(font: .systemFont(ofSize: 24)))
        let filledImage = UIImage(systemName: "circle.fill")?.applyingSymbolConfiguration(.init(font: .systemFont(ofSize: 24)))
        $0.setImage(image, for: .normal)
        $0.setImage(filledImage, for: .selected)
        $0.tintColor = .white
        $0.addTarget(self, action: #selector(completeButtonTapped), for: .touchUpInside)
    }
    
    private let titleLabel = UILabel().then {
        $0.font = .boldSystemFont(ofSize: 16)
        $0.textColor = .white
    }
    
    private let memoLabel = UILabel().then {
        $0.font = .systemFont(ofSize: 14)
        $0.textColor = .white
    }
    
    private let tagLabel = UILabel().then {
        $0.font = .systemFont(ofSize: 14)
        $0.textColor = .white
        $0.textAlignment = .center
        $0.backgroundColor = .systemOrange
        $0.layer.cornerRadius = 5
        $0.clipsToBounds = true
    }
    
    private let priorityLabel = UILabel().then {
        $0.font = .systemFont(ofSize: 14)
    }
    
    private let dateLabel = UILabel().then {
        $0.font = .systemFont(ofSize: 12)
        $0.textColor = .systemGray
    }
    
    // MARK: - Helpers
    
    @objc func completeButtonTapped(sender: UIButton) {
        sender.isSelected.toggle()
        
        sender.tintColor = sender.isSelected == true ? .systemYellow : .white
    }
    
    // MARK: - Helpers
    
    func configureCell(data: Todo) {
        let dateManager = DateFormatterManager.shared
        titleLabel.text = data.title
        memoLabel.text = data.memo
        tagLabel.text = data.tag
        priorityLabel.text = Priority.allCases[data.priority ?? 1].title
        dateLabel.text = dateManager.dateToString(data.endDate, format: .dateAndHour)
    }
    
    override func configureHierarchy() {
        contentView.addSubviews(completeButton, titleLabel, memoLabel, tagLabel, priorityLabel, dateLabel)
    }
    
    override func configureLayout() {
        completeButton.snp.makeConstraints { make in
            make.top.leading.equalToSuperview().offset(12)
            make.size.equalTo(40)
        }
        
        titleLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(12)
            make.leading.equalTo(completeButton.snp.trailing).offset(12)
            make.trailing.equalToSuperview().offset(-8)
        }
        
        memoLabel.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(8)
            make.leading.equalTo(titleLabel.snp.leading)
            make.trailing.equalToSuperview().offset(-8)
        }
        
        tagLabel.snp.makeConstraints { make in
            make.top.equalTo(memoLabel.snp.bottom).offset(8)
            make.leading.equalTo(titleLabel.snp.leading)
            make.width.equalTo(50)
            make.bottom.equalToSuperview().offset(-12)
        }
        
        priorityLabel.snp.makeConstraints { make in
            make.top.equalTo(tagLabel)
            make.leading.equalTo(tagLabel.snp.trailing).offset(8)
        }
        
        dateLabel.snp.makeConstraints { make in
            make.trailing.bottom.equalToSuperview().offset(-8)
        }
    }
}
