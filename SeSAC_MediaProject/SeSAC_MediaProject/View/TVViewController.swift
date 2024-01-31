//
//  TVViewController.swift
//  SeSAC_MediaProject
//
//  Created by Deokhun KIM on 1/30/24.
//

import UIKit

enum Sections: String, CaseIterable {
    case tvTrend = "TVTrend"
    case tvTopRated = "TVTopRated"
    case tvPopular = "TVPopular"
}

final class TVViewController: UIViewController {
    
    // MARK: - Properties
    
    private lazy var tvTableView = {
        let tv = UITableView()
        tv.delegate = self
        tv.dataSource = self
        tv.register(TVTableViewCell.self, forCellReuseIdentifier: TVTableViewCell.identifier)
        tv.rowHeight = 220
        tv.separatorStyle = .none
        return tv
    }()
    
    private var list: [[TVModel]] = Array(repeating: [], count: Sections.allCases.count)
    
    // MARK: - LifeCycle

    override func viewDidLoad() {
        super.viewDidLoad()

        configureUI()
        requestTvData()
    }
}

// MARK: - Network

extension TVViewController {
    
    private func requestTvData() {
        let apiManager = TMDBAPIManager.shared
        
        let group = DispatchGroup()
        
        Endpoint.allCases.enumerated().forEach { index, endPoint in
            
            group.enter()
            apiManager.fetchTVData(endPoint: endPoint.rawValue) { result in
                print("\(index)")
                print(result.count, "\(endPoint)")
                self.list.insert(result, at: index)
                group.leave()
            }
        }
        
        group.notify(queue: .main) {
            print("\(3)")
            self.tvTableView.reloadData()
        }
        
//        apiManager.fetchTVData(endPoint: Endpoint.trend.rawValue) { trend in
//            self.list.insert(trend, at: 0)
//        }
//        
//        apiManager.fetchTVData(endPoint: Endpoint.toprated.rawValue) { topRated in
//            self.list.insert(topRated, at: 1)
//        }
//        
//        apiManager.fetchTVData(endPoint: Endpoint.popular.rawValue) { popular in
//            self.list.insert(popular, at: 2)
//        }
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
        cell.reloadCollectionView()
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

// MARK: - Configure

extension TVViewController: SetUI {
    
    func configureUI() {
        configureAttributes()
        configureNav()
        configureView()
    }
    
    private func configureAttributes() {
        view.backgroundColor = .white
    }
    
    private func configureNav() {
        navigationItem.title = "Tv"
    }
    
    private func configureView() {
        view.addSubview(tvTableView)
        
        tvTableView.snp.makeConstraints { make in
            make.edges.equalTo(view.safeAreaLayoutGuide)
        }
    }
}

