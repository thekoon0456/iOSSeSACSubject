//
//  CityViewController.swift
//  SeSAC_MakeTableViewController
//
//  Created by Deokhun KIM on 1/9/24.
//

import UIKit

class CityViewController: UIViewController {
    
    enum CityCategory: Int, CaseIterable {
        case all
        case inside
        case outside
        
        var value: String {
            switch self {
            case .all:
                return "모두"
            case .inside:
                return "국내"
            case .outside:
                return "해외"
            }
        }
    }
    
    @IBOutlet var citySegment: UISegmentedControl!
    @IBOutlet var cityCollectionView: UICollectionView!
    
    var cityList = CityInfo().city {
        didSet {
            cityCollectionView.reloadData()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureUI()
    }
    
    @objc
    func changedSeg(sender: UISegmentedControl) {
        let list = CityInfo().city
        switch sender.selectedSegmentIndex {
        case 0:
            UserDefaultsManager.shared.citySegIndex = 0
            self.cityList = list
        case 1:
            UserDefaultsManager.shared.citySegIndex = 1
            self.cityList = list.filter { $0.domestic_travel == true }
        case 2:
            UserDefaultsManager.shared.citySegIndex = 2
            self.cityList = list.filter { $0.domestic_travel == false }
        default:
            return
        }
    }
}

extension CityViewController: setUI {
    
    func configureUI() {
        navigationItem.title = "인기 도시"
        
        configureSeg()
        configureCollectionView()
    }
    
    func configureSeg() {
        citySegment.selectedSegmentIndex = UserDefaultsManager.shared.citySegIndex
        citySegment.setTitle(CityCategory.all.value,
                             forSegmentAt: CityCategory.all.rawValue)
        citySegment.setTitle(CityCategory.inside.value,
                             forSegmentAt: CityCategory.inside.rawValue)
        citySegment.setTitle(CityCategory.outside.value,
                             forSegmentAt: CityCategory.outside.rawValue)
        citySegment.addTarget(self,
                              action: #selector(changedSeg),
                              for: .valueChanged)
    }
    
    func configureCollectionView() {
        cityCollectionView.delegate = self
        cityCollectionView.dataSource = self
        
        let xib = UINib(nibName: CityCollectionViewCell.cellID, bundle: nil)
        cityCollectionView.register(xib, forCellWithReuseIdentifier: CityCollectionViewCell.cellID)
        
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = .init(width: ConstFloat.cellWidth.value,
                                height:  ConstFloat.cellHeight.value)
        layout.sectionInset = .init(top: ConstFloat.spacing.value,
                                    left: ConstFloat.spacing.value,
                                    bottom: ConstFloat.spacing.value,
                                    right: ConstFloat.spacing.value)
        layout.minimumLineSpacing = ConstFloat.spacing.value
        layout.minimumLineSpacing = ConstFloat.spacing.value
        
        cityCollectionView.collectionViewLayout = layout
    }
}

extension CityViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        cityList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CityCollectionViewCell.cellID, for: indexPath) as? CityCollectionViewCell else {
            return UICollectionViewCell()
        }
        
        cell.setValus(cityList[indexPath.item])
        
        return cell
    }
}
