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
    
    private let tvView = TVView()
    private var list: [[TVModel]] = Array(repeating: [], count: Sections.allCases.count)

    // MARK: - LifeCycle
    
    override func loadView() {
        view = tvView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        requestTvData()
        configureTableView()
    }
    
    override func configureView() {
        navigationItem.title = "Tv"
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "magnifyingglass"),
                                                            style: .plain,
                                                            target: self,
                                                            action: #selector(searchButtonTapped))
    }
    
    @objc func searchButtonTapped() {
        let vc = SearchViewController()
        
        navigationController?.pushViewController(vc, animated: true)
    }
    
    private func configureTableView() {
        tvView.tableView.delegate = self
        tvView.tableView.dataSource = self
    }
}

// MARK: - Network

extension TVViewController {
    
    private func requestTvData() {

        let group = DispatchGroup()
        
        // MARK: - Alamofire -> URLSession으로 리팩토링

        let tv = [TMDBAPIRouter.trend(sort: TMDBAPI.TrendSort.day.rawValue),
                  TMDBAPIRouter.toprated(page: 1),
                  TMDBAPIRouter.popular(page: 1)]
        
        tv.enumerated().forEach { index, tmdbAPI in
            
            group.enter()
            TMDBURLSessionManager.shared.fetchURLSessionData(api: tmdbAPI, type: TV.self) { [weak self] result in
                guard let self else { return }
                switch result {
                case .success(let success):
                    self.list.insert(success.results, at: index)
                    group.leave()
                case .failure(let failure):
                    print(failure)
                    DispatchQueue.main.async { [weak self] in
                        guard let self else { return }
                        errorAlert(title: failure.title,
                                        message: failure.description) { [weak self] in
                            guard let self else { return }
                            requestTvData()
                            group.leave()
                        }
                    }
                }
            }
        }
        
        group.notify(queue: .main) {
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
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let vc = DramaViewController()
        vc.requestDramaData(id: list[collectionView.tag][indexPath.item].id)
        navigationController?.pushViewController(vc, animated: true)
    }
}
