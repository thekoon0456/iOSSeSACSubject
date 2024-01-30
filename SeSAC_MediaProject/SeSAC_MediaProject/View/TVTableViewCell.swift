//
//  TVTableViewCell.swift
//  SeSAC_MediaProject
//
//  Created by Deokhun KIM on 1/30/24.
//

import UIKit

import SnapKit

final class TVTableViewCell: UITableViewCell {
    
    lazy var collectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = .init(width: 90, height: 180)
        layout.minimumLineSpacing = 40
        layout.minimumInteritemSpacing = 0
//        layout.sectionInset = .init(top: 0, left: 10, bottom: 0, right: 0)
        layout.scrollDirection = .horizontal
        
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        return cv
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        configureUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

extension TVTableViewCell: SetCell {

    func configureCellData(_ data: Model) {
        
    }
    
    func configureUI() {
        configureView()
    }
    
    private func configureView() {
        contentView.addSubview(collectionView)
        collectionView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    
}
