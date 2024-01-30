//
//  TVTableViewCell.swift
//  SeSAC_MediaProject
//
//  Created by Deokhun KIM on 1/30/24.
//

import UIKit

import SnapKit

final class TVTableViewCell: UITableViewCell {
    
    private let sectionTitle = UILabel()
    private lazy var collectionView = {
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

// MARK: - CollectionView

extension TVTableViewCell {
    func congifureCollectionView(vc: UIViewController, tag: Int) {
        collectionView.delegate = vc as? TVViewController
        collectionView.dataSource = vc as? TVViewController
        collectionView.register(TVCollectionViewCell.self, forCellWithReuseIdentifier: TVCollectionViewCell.identifier)
        collectionView.tag = tag
    }
    
    func reloadCollectionView() {
        collectionView.reloadData()
    }
}


extension TVTableViewCell: SetCell {
    
    func configureCellData(_ data: String) {
        sectionTitle.text = data
    }

    func configureUI() {
        configureView()
    }
    
    private func configureView() {
        contentView.addSubviews(sectionTitle, collectionView)
        
        sectionTitle.snp.makeConstraints { make in
            make.top.leading.equalToSuperview().offset(4)
            make.height.equalTo(20)
        }
        
        collectionView.snp.makeConstraints { make in
            make.top.equalTo(sectionTitle.snp.bottom)
            make.horizontalEdges.equalToSuperview()
            make.bottom.equalToSuperview().offset(-16)
        }
    }
}
