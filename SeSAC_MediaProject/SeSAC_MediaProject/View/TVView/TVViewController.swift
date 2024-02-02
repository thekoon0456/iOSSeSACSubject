//
//  TVViewController.swift
//  SeSAC_MediaProject
//
//  Created by Deokhun KIM on 1/30/24.
//

import UIKit

import SnapKit

final class TVViewController: BaseViewController {
    
    enum Sections: String, CaseIterable {
        case tvTrend = "TVTrend"
        case tvTopRated = "TVTopRated"
        case tvPopular = "TVPopular"
    }
    
    // MARK: - Properties
    
    private var list: [[TVModel]] = Array(repeating: [], count: Sections.allCases.count)
    private let tvView = TVView()
    
    // MARK: - LifeCycle
    
    override func loadView() {
        view = tvView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        requestTvData()
    }
    
    override func configureView() {
        navigationItem.title = "Tv"
    }
    
    private func configureTableView() {
        tvView.tableView.delegate = self
        tvView.tableView.dataSource = self
    }
}

// MARK: - Network

extension TVViewController {
    
    private func requestTvData() {
        let apiManager = TMDBAPIManager.shared
        
        let group = DispatchGroup()
        
        // FIXME: - 가끔씩 collectionView 보이지 않는 현상 발생
        let tv = [TMDBAPI.trend(sort: TMDBAPI.TrendSort.day.rawValue),
                  TMDBAPI.toprated(page: 1),
                  TMDBAPI.popular(page: 1)]
        
        tv.enumerated().forEach { index, tmdbAPI in
            group.enter()
            apiManager.fetchData(api: tmdbAPI, type: TV.self) { result in
                print("\(index)")
                self.list.insert(result.results, at: index)
                group.leave()
            }
        }
        
        group.notify(queue: .main) {
            print("\(3)")
            self.tvView.tableView.reloadData()
        }
    }
}

// MARK: - TableView

extension TVViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        Sections.allCases.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: TVTableViewCell.identifier, for: indexPath) as? TVTableViewCell
        else { return UITableViewCell() }
        
        cell.configureCellData(Sections.allCases[indexPath.row].rawValue)
        cell.congifureCollectionView(vc: self, tag: indexPath.row)
        return cell
    }
}

// MARK: - CollectionView

extension TVViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        list[collectionView.tag].count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: TVCollectionViewCell.identifier, for: indexPath) as? TVCollectionViewCell
        else { return UICollectionViewCell() }
        
        let model = list[collectionView.tag][indexPath.item]
        cell.configureCellData(model)
        return cell
    }
}
