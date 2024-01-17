//
//  CityViewController.swift
//  SeSAC_MakeTableViewController
//
//  Created by Deokhun KIM on 1/9/24.
//

import UIKit

final class CityViewController: UIViewController {
    
    @IBOutlet var citySearchBar: UISearchBar!
    @IBOutlet var citySegment: UISegmentedControl!
    @IBOutlet var cityCollectionView: UICollectionView!
    
    //초기 배열
    let defaultData = CityInfo().city
    
    //세그먼트 이동시 사용하는 데이터
    var segData = CityInfo().city
    
    //화면에 보여지는 배열
    var cityList = CityInfo().city {
        didSet {
            cityCollectionView.reloadData()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureUI()
        //기존에 설정된 segment 필터링
        changedSeg(sender: citySegment)
    }
    
    @objc
    func viewTapped() {
        view.endEditing(true)
    }
    
    @objc
    func changedSeg(sender: UISegmentedControl) {
        switch sender.selectedSegmentIndex {
        case 0:
            UserDefaultService.shared.citySegIndex = 0
            cityList = segData
        case 1:
            UserDefaultService.shared.citySegIndex = 1
            cityList = segData.filter { $0.domestic_travel == true }
        case 2:
            UserDefaultService.shared.citySegIndex = 2
            cityList = segData.filter { $0.domestic_travel == false }
        default:
            return
        }
    }
}

// MARK: - Type

extension CityViewController {
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
}

// MARK: - UI

extension CityViewController: SetUI {
    
    func configureUI() {
        navigationItem.title = Title.popularCity
        
        configureSearcuBar()
        configureSeg()
        configureCollectionView()
    }
    
    func configureSearcuBar() {
        citySearchBar.delegate = self
        citySearchBar.placeholder = ConstString.searchPlaceHolder
    }
    
    func configureSeg() {
        citySegment.selectedSegmentIndex = UserDefaultService.shared.citySegIndex
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
        
        let xib = UINib(nibName: CityCollectionViewCell.identifier, bundle: nil)
        cityCollectionView.register(xib, forCellWithReuseIdentifier: CityCollectionViewCell.identifier)
        
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
        cityCollectionView.keyboardDismissMode = .onDrag //스크롤시 키보드 내림
    }
}

// MARK: - SearchBar

extension CityViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        //모두 lowercased로 비교
        var lowercasedText = searchText.lowercased()
        //필터링 배열
        var filteringData: [City] = []
        
        //띄워쓰기 수정
        if lowercasedText.contains(" ") {
            lowercasedText = lowercasedText.replacingOccurrences(of: " ", with: "")
            searchBar.text = lowercasedText
        }
        
        guard searchBar.text?.isEmpty == false else {
            cityList = defaultData
            segData = defaultData
            return
        }
        
        for item in defaultData {
            if item.city_name.contains(lowercasedText)
                || item.city_english_name.lowercased().contains(lowercasedText)
                || item.city_explain.contains(lowercasedText) {
                filteringData.append(item)
            }
            
            //결과 넣어주기
            cityList = filteringData
            segData = filteringData
        }
    }
}

// MARK: - CollectionView

extension CityViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        cityList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CityCollectionViewCell.identifier, for: indexPath) as? CityCollectionViewCell else {
            return UICollectionViewCell()
        }
        
        cell.configureCellData(cityList[indexPath.item])
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let vc = storyboard?.instantiateViewController(identifier: DetailCityInfoViewController.vcID) as! DetailCityInfoViewController
        
        navigationController?.pushViewController(vc, animated: true)
    }
}
