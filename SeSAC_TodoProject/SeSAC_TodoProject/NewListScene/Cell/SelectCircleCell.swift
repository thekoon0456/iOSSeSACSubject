//
//  SelectCircleCell.swift
//  SeSAC_TodoProject
//
//  Created by Deokhun KIM on 2/20/24.
//

import UIKit

import SnapKit

final class SelectCircleCell: BaseCollectionViewCell {
    
    private lazy var cellWidth = contentView.frame.width
    
    private lazy var bgView = UIView().then {
        $0.layer.cornerRadius = (cellWidth - 8) / 2
        $0.clipsToBounds = true
    }
    
    private lazy var circleImageView = UIImageView().then {
        $0.contentMode = .scaleAspectFit
        $0.tintColor = .white
    }
    
    // MARK: - Helpers
    
    func condifureCell(_ data: CircleConfig) {
        circleImageView.image = UIImage(systemName: data.imageName)
        bgView.backgroundColor = data.colorName.toUIColor()
    }
    
    override func configureHierarchy() {
        contentView.addSubviews(bgView, circleImageView)
        
    }
    
    override func configureLayout() {
        bgView.snp.makeConstraints { make in
            make.top.leading.equalToSuperview().offset(4)
            make.trailing.bottom.equalToSuperview().offset(-4)
        }
        
        circleImageView.snp.makeConstraints { make in
            make.top.leading.equalToSuperview().offset(12)
            make.trailing.bottom.equalToSuperview().offset(-12)
        }
    }
    
    override func configureView() { }
}
