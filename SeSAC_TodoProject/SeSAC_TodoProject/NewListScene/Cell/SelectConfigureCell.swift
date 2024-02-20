//
//  SelectConfigureCell.swift
//  SeSAC_TodoProject
//
//  Created by Deokhun KIM on 2/20/24.
//

import UIKit

import SnapKit

final class SelectConfigureCell: BaseTableViewCell {
    
    // MARK: - Properties
    
    var list: [CircleConfig] = []
    
    private lazy var cellWidth = contentView.frame.width
    
    private lazy var collectionView = {
        let layout = UICollectionViewFlowLayout()
        let width = ((cellWidth - (56 / 2)) / 6)
        layout.itemSize = .init(width: width, height: width)
        layout.minimumLineSpacing = 8
        layout.sectionInset = .init(top: 8, left: 8, bottom: 8, right: 8)
        layout.scrollDirection = .horizontal
        
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.delegate = self
        cv.dataSource = self
        cv.register(SelectCircleCell.self, forCellWithReuseIdentifier: SelectCircleCell.identifier)
        cv.backgroundColor = .clear
        return cv
    }()
    
    // MARK: - Helpers
    
    override func configureHierarchy() {
        contentView.addSubview(collectionView)
    }
    
    override func configureLayout() {
        collectionView.snp.makeConstraints { make in
            make.top.leading.trailing.bottom.equalToSuperview()
            make.height.equalTo(100)
        }
    }
    
    override func configureView() { }
}

extension SelectConfigureCell: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        list.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: SelectCircleCell.identifier, for: indexPath) as? SelectCircleCell else { return UICollectionViewCell() }
        cell.condifureCell(list[indexPath.item])
        return cell
    }
}
