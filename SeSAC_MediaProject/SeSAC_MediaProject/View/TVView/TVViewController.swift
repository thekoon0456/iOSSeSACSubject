//
//  TVViewController.swift
//  SeSAC_MediaProject
//
//  Created by Deokhun KIM on 1/30/24.
//

import UIKit

import SnapKit

final class TVViewController: BaseViewController {

    // MARK: - Properties
    
    private let tvView = TVView()
    private var list: [[TVModel]] = []
    
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
        navigationItem.title = "TV"
        navigationController?.navigationBar.titleTextAttributes = [ NSAttributedString.Key.foregroundColor: UIColor.white ]
        navigationController?.navigationBar.tintColor = .white
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "magnifyingglass"),
                                                            style: .plain,
                                                            target: self,
                                                            action: #selector(searchButtonTapped))
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "person"),
                                                            style: .plain,
                                                            target: self,
                                                            action: #selector(personButtonTapped))
        navigationController?.navigationBar.scrollEdgeAppearance?.backgroundColor = .black
    }
    
    @objc func searchButtonTapped() {
        let vc = SearchViewController()
        navigationController?.pushViewController(vc, animated: true)
    }
    
    @objc func personButtonTapped() {
        let vc = ProfileViewController()
        navigationController?.pushViewController(vc, animated: true)
    }
    
    private func configureTableView() {
        tvView.tableView.delegate = self
        tvView.tableView.dataSource = self
    }
}

// MARK: - Sections

extension TVViewController {
    
    enum Sections: String, CaseIterable {
        case tvTrend = "TVTrend"
        case tvTopRated = "TVTopRated"
        case tvPopular = "TVPopular"
        
        var title: String {
            switch self {
            case .tvTrend:
                "트렌드 TV"
            case .tvTopRated:
                "이번주 Top Rated"
            case .tvPopular:
                "인기 TV 프로그램"
            }
        }
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
        
        //index와 함께 담아서 순서 정렬
        var list: [(Int, [TVModel])] = []
        
        tv.enumerated().forEach { index, tmdbAPI in
            group.enter()
            TMDBURLSessionManager.shared.fetchURLSessionData(api: tmdbAPI, type: TV.self) { [weak self] result in
                guard let self else { return }
                switch result {
                case .success(let success):
                    list.append((index, success.results))
                    
                case .failure(let failure):
                    print(failure)
                    DispatchQueue.main.async { [weak self] in
                        guard let self else { return }
                        errorAlert(title: failure.title,
                                   message: failure.description) { [weak self] in
                            guard let self else { return }
                            requestTvData()
                        }
                    }
                }
                
                group.leave()
            }
        }
        
        group.notify(queue: .main) {
            self.list = list.sorted(by: { $0.0 < $1.0 } ).map { $0.1 }
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
        
        cell.configureCellData(Sections.allCases[indexPath.row].title)
        cell.congifureCollectionView(vc: self, tag: indexPath.row)
        return cell
    }
}

// MARK: - CollectionView

extension TVViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        guard let list = list[safe: collectionView.tag] else { return 0 }
        return list.count
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
