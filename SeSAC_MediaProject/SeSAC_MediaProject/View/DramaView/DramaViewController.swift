//
//  DramaViewController.swift
//  SeSAC_MediaProject
//
//  Created by Deokhun KIM on 1/31/24.
//

import UIKit

import Kingfisher
import SnapKit

final class DramaViewController: BaseViewController {
    
    enum Sections: String, CaseIterable {
        case DramaCasting = "캐스팅"
        case DramaRecommends = "추천 드라마"
    }
    
    private let dramaView = DramaView()
    private var castList = [CastModel]()
    private var recommendationList = [TVModel]()
    
    // MARK: - Lifecycles
    
    override func loadView() {
        view = dramaView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureTableView()
    }
    
    func configureTableView() {
        dramaView.tableView.delegate = self
        dramaView.tableView.dataSource = self
    }
    
    func requestDramaData(id: Int?) {
        guard let id else { return }
        
        let group = DispatchGroup()
        
        group.enter()
        TMDBURLSessionManager.shared.fetchURLSessionData(api: .tvSeriesDetails(id: id), type: DramaDetail.self) { result in
            switch result {
            case .success(let success):
                DispatchQueue.main.async {
                    self.setDramaDetailView(data: success)
                    self.navigationItem.title = success.name
                }
            case .failure(let failure):
                DispatchQueue.main.async { [weak self] in
                    guard let self else { return }
                    errorAlert(title: failure.title, message: failure.description) { [weak self] in
                        guard let self else { return }
                        requestDramaData(id: id)
                    }
                }
            }
            group.leave()
        }
        
        group.enter()
        TMDBURLSessionManager.shared.fetchURLSessionData(api: .aggregateCredits(id: id, page: 1), type: DramaCast.self) { result in
            switch result {
            case .success(let success):
                self.castList = success.cast
            case .failure(let failure):
                DispatchQueue.main.async { [weak self] in
                    guard let self else { return }
                    errorAlert(title: failure.title, message: failure.description) { [weak self] in
                        guard let self else { return }
                        requestDramaData(id: id)
                    }
                }
            }
            group.leave()
        }
        
        group.enter()
        TMDBURLSessionManager.shared.fetchURLSessionData(api: .recommendations(id: id, page: 1), type: TV.self) { result in
            switch result {
            case .success(let success):
                self.recommendationList = success.results
            case .failure(let failure):
                DispatchQueue.main.async { [weak self] in
                    guard let self else { return }
                    errorAlert(title: failure.title, message: failure.description) { [weak self] in
                        guard let self else { return }
                        requestDramaData(id: id)
                    }
                }
            }
            group.leave()
        }
        
        group.notify(queue: .main) {
            self.dramaView.tableView.reloadData()
        }
    }
}

extension DramaViewController {
    func setDramaDetailView(data: DramaDetail) {
        dramaView.detailView.setDramaDetailView(data: data)
    }
}

extension DramaViewController: UITableViewDelegate, UITableViewDataSource {
    
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

// MARK: - DramaViewController

extension DramaViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch collectionView.tag {
        case 0:
            castList.count
        default:
            recommendationList.count
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: TVCollectionViewCell.identifier, for: indexPath) as? TVCollectionViewCell
        else { return UICollectionViewCell() }
        
        switch collectionView.tag {
        case 0:
            let model = castList[indexPath.item]
            cell.configureCellData(model)
        default:
            let model = recommendationList[indexPath.item]
            cell.configureCellData(model)
        }
        
        return cell
    }
}
