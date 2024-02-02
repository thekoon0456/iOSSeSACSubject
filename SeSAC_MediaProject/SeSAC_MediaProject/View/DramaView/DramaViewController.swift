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
        case DramaCasting
        case DramaRecommends
    }
    
    private let apiManager = TMDBAPIManager.shared
    private let dramaView = DramaView()
    private var castList = [CastModel]()
    private var recommendationList = [TVModel]()
    
    // MARK: - Lifecycles
    
    override func loadView() {
        view = dramaView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        requestDramaData()
        configureTableView()
    }
    
    func configureTableView() {
        dramaView.tableView.delegate = self
        dramaView.tableView.dataSource = self
    }
    
    func requestDramaData() {
        let group = DispatchGroup()
        
        group.enter()
        apiManager.fetchData(api: .tvSeriesDetails(id: 82856), type: DramaDetail.self) { data in
            self.setDramaDetailView(data: data)
            group.leave()
        }
        
        group.enter()
        apiManager.fetchData(api: .aggregateCredits(id: 82856, page: 1), type: DramaCast.self) { data in
            self.castList = data.cast
            group.leave()
        }
        
        group.enter()
        apiManager.fetchData(api: .recommendations(id: 82856, page: 1), type: TV.self) { data in
            self.recommendationList = data.results
            group.leave()
        }
        
        group.notify(queue: .main) {
            self.dramaView.tableView.reloadData()
        }
    }
    
    func setDramaDetailView(data: DramaDetail) {
        navigationItem.title = data.name
        let url = URL(string: "https://image.tmdb.org/t/p/w500/\(data.posterPath ?? "")")
        dramaView.detailView.posterImageView.kf.setImage(with: url)
        dramaView.detailView.name.text = data.name
        dramaView.detailView.overView.text = data.overview
        dramaView.detailView.lastAirDate.text = "최근 방영일: " + data.lastAirDate
        dramaView.detailView.numberOfEpisodes.text = "총 에피소드 : \(data.numberOfEpisodes)개"
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
