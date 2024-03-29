//
//  TVTableViewCell.swift
//  SeSAC_MediaProject
//
//  Created by Deokhun KIM on 1/30/24.
//

import UIKit

import SnapKit

final class TVTableViewCell: BaseTableViewCell {
    
    // MARK: - Properties
    
    private let sectionTitle = UILabel().then {
        $0.textColor = .white
    }
    
    private let collectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = .init(width: 120, height: 180)
        layout.minimumLineSpacing = 12
        layout.minimumInteritemSpacing = 0
        layout.sectionInset = .init(top: 0, left: 12, bottom: 0, right: 12)
        layout.scrollDirection = .horizontal
        
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.backgroundColor = .clear
        return cv
    }()
    
    // MARK: - Helpers
    
    override func configureHierarchy() {
        contentView.addSubviews(sectionTitle, collectionView)
    }
    
    override func configureLayout() {
        sectionTitle.snp.makeConstraints { make in
            make.top.leading.equalToSuperview().offset(12)
            make.height.equalTo(20)
        }
        
        collectionView.snp.makeConstraints { make in
            make.top.equalTo(sectionTitle.snp.bottom)
            make.horizontalEdges.equalToSuperview()
            make.bottom.equalToSuperview().offset(-16)
        }
    }
    
    override func configureView() {
        contentView.backgroundColor = .black
    }
}

// MARK: - CollectionView

extension TVTableViewCell {
    
    func configureCellData(_ data: String) {
        sectionTitle.text = data
    }
    
    func congifureCollectionView(vc: UIViewController, tag: Int) {
        collectionView.delegate = vc as? any UICollectionViewDelegate
        collectionView.dataSource = vc as? any UICollectionViewDataSource
        collectionView.register(TVCollectionViewCell.self, forCellWithReuseIdentifier: TVCollectionViewCell.identifier)
        collectionView.tag = tag
        reloadCollectionView()
    }
    
    func reloadCollectionView() {
        collectionView.reloadData()
    }
}
