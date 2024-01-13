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
    
    @IBOutlet var cityTextField: UITextField!
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
        //기존에 설정된 segment 필터링
        changedSeg(sender: citySegment)
    }
    
    @objc
    func viewTapped() {
        view.endEditing(true)
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
        
        cityTextField.text = nil
    }
    
    // MARK: - 설정시 컬렉션뷰 클릭 안됨.
//    func setGesture() {
//        let gesture = UITapGestureRecognizer(target: self, action: #selector(viewTapped))
  //      view.addGestureRecognizer(gesture)
//    }
    
    func setSearchText(_ input: String?) {
        guard var lowercasedText = input?.lowercased() else { return }
        
        //띄워쓰기 수정
        if lowercasedText.contains(" ") {
            lowercasedText = lowercasedText.replacingOccurrences(of: " ", with: "")
            self.cityTextField.text = lowercasedText
        }
        
        //필터링
        let result = cityList.filter {
            $0.city_name.contains(lowercasedText)
            || $0.city_english_name.lowercased().contains(lowercasedText)
            || $0.city_explain.contains(lowercasedText)
        }
        
        //결과 보여주기
        if result.isEmpty == false {
            cityList = result
        }
    }
}

extension CityViewController: setUI {
    
    func configureUI() {
        navigationItem.title = Title.popularCity
        
        configureTextField()
        configureSeg()
        configureCollectionView()
    }
    
    func configureTextField() {
        cityTextField.delegate = self
        cityTextField.placeholder = ConstString.searchPlaceHolder
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

// MARK: - CollectionView

extension CityViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        cityList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CityCollectionViewCell.identifier, for: indexPath) as? CityCollectionViewCell else {
            return UICollectionViewCell()
        }
        
        cell.configureCellData(data: cityList[indexPath.item])
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let vc = storyboard?.instantiateViewController(identifier: DetailCityInfoViewController.vcID) as! DetailCityInfoViewController
        
        navigationController?.pushViewController(vc, animated: true)
    }

}

// MARK: - TextField

extension CityViewController: UITextFieldDelegate {
//    func textFieldDidBeginEditing(_ textField: UITextField) {
//        self.cityTextField.text = nil
//        cityList = CityInfo().city
//    }
    
    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
        guard let lowercasedText = textField.text?.lowercased() else { return true }
        setSearchText(lowercasedText)
        return true
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        guard let lowercasedText = textField.text?.lowercased() else { return true }
        let input = (lowercasedText as NSString?)?.replacingCharacters(in: range, with: string)
        setSearchText(input)
        
        //비어있으면 각 seg에 맞는 화면 나오도록
//        if cityTextField.text?.isEmpty == true {
//
//        }
        return true
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        view.endEditing(true)
    }
}
