//
//  DetailCityInfoViewController.swift
//  SeSAC_TableAndCollectionView
//
//  Created by Deokhun KIM on 1/11/24.
//

import UIKit

class DetailCityInfoViewController: UIViewController {
    
    @IBOutlet var detailTableView: UITableView!
    
    static let vcID = "DetailCityInfoViewController"
    
    let travelData = TravelInfo().travel
    
    override func viewDidLoad() {
        super.viewDidLoad()

        configureUI()
        setTableView()
    }
    
    func configureUI() {
        navigationItem.title = "도시 상세 정보"
    }
    
    func setTableView() {
        let cityXIB = UINib(nibName: CityDetailTableViewCell.cellID, bundle: nil)
        detailTableView.register(cityXIB, forCellReuseIdentifier: CityDetailTableViewCell.cellID)
        let adXIB = UINib(nibName: CityDatailAdTableViewCell.cellID, bundle: nil)
        detailTableView.register(adXIB, forCellReuseIdentifier: CityDatailAdTableViewCell.cellID)
        
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
            let adCell = tableView.dequeueReusableCell(withIdentifier: CityDatailAdTableViewCell.cellID, for: indexPath) as! CityDatailAdTableViewCell
            adCell.setCellData(travelData[indexPath.row])
            return adCell
            
        } else {
            let cityCell = tableView.dequeueReusableCell(withIdentifier: CityDetailTableViewCell.cellID, for: indexPath) as! CityDetailTableViewCell

            cityCell.setCellData(travelData[indexPath.row])
            return cityCell
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if travelData[indexPath.row].ad ?? true {
            let vc = storyboard?.instantiateViewController(identifier: AdViewController.vcID) as! AdViewController
            navigationController?.pushViewController(vc, animated: true)
        } else {
            let vc = storyboard?.instantiateViewController(identifier: TrevelSpotViewController.vcID) as! TrevelSpotViewController
            navigationController?.pushViewController(vc, animated: true)
        }
    }
}
