//
//  DetailCityInfoViewController.swift
//  SeSAC_TableAndCollectionView
//
//  Created by Deokhun KIM on 1/11/24.
//

import UIKit

final class DetailCityInfoViewController: UIViewController {
    
    @IBOutlet var detailTableView: UITableView!
    
    static let vcID = "DetailCityInfoViewController"
    
    let travelData = TravelInfo().travel
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureUI()
        setTableView()
    }
    
    func configureUI() {
        navigationItem.title = Title.cityDetailInfo
    }
    
    func setTableView() {
        let cityXIB = UINib(nibName: CityDetailTableViewCell.identifier, bundle: nil)
        detailTableView.register(cityXIB, forCellReuseIdentifier: CityDetailTableViewCell.identifier)
        let adXIB = UINib(nibName: CityDatailAdTableViewCell.identifier, bundle: nil)
        detailTableView.register(adXIB, forCellReuseIdentifier: CityDatailAdTableViewCell.identifier)
        
        detailTableView.delegate = self
        detailTableView.dataSource = self
    }
}

extension DetailCityInfoViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        travelData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if travelData[indexPath.row].ad ?? true {
            guard let adCell = tableView.dequeueReusableCell(withIdentifier: CityDatailAdTableViewCell.identifier, for: indexPath) as? CityDatailAdTableViewCell else {
                return UITableViewCell()
            }
            
            adCell.configureCellData(travelData[indexPath.row])
            return adCell
            
        } else {
            guard let cityCell = tableView.dequeueReusableCell(withIdentifier: CityDetailTableViewCell.identifier, for: indexPath) as? CityDetailTableViewCell else {
                return UITableViewCell()
            }
            
            cityCell.configureCellData(travelData[indexPath.row])
            return cityCell
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if travelData[indexPath.row].ad ?? true {
            let vc = storyboard?.instantiateViewController(identifier: AdViewController.identifier) as! AdViewController
            navigationController?.pushViewController(vc, animated: true)
        } else {
            let vc = storyboard?.instantiateViewController(identifier: TrevelSpotViewController.identifier) as! TrevelSpotViewController
            navigationController?.pushViewController(vc, animated: true)
        }
        
        tableView.deselectRow(at: indexPath, animated: true)
    }
}
