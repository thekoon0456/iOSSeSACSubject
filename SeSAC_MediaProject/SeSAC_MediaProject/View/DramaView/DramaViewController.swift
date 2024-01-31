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
    private let dramaDetailView = DramaDetailView()
    
    private lazy var dramaTableView = {
        let tv = UITableView()
        tv.delegate = self
        tv.dataSource = self
        tv.register(TVTableViewCell.self, forCellReuseIdentifier: TVTableViewCell.identifier)
        tv.rowHeight = 220
        tv.separatorStyle = .none
        return tv
    }()
    
    var castList = [CastModel]()
    var recommendationList = [TVModel]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        getDramaData()
    }
    
    private func getDramaData() {
        let group = DispatchGroup()
        
        group.enter()
        apiManager.fetchDetailData(endPoint: DramaEndpoint.tvSeriesDetails.rawValue) { detail in
            print(detail)
            let url = URL(string: "https://image.tmdb.org/t/p/w500/\(detail.posterPath ?? "")")
            self.dramaDetailView.posterImageView.kf.setImage(with: url)
            self.dramaDetailView.name.text = detail.name
            self.dramaDetailView.overView.text = detail.overview

            self.dramaDetailView.lastAirDate.text = "최근 방영일: " + detail.lastAirDate
            self.dramaDetailView.numberOfEpisodes.text = "총 에피소드 : \(detail.numberOfEpisodes)개"
            group.leave()
        }
        
        group.enter()
        apiManager.fetchCastData(endPoint: DramaEndpoint.aggregateCredits.rawValue) { cast in
            self.castList = cast
            print(self.castList.count)
            group.leave()
        }
        
        group.enter()
        apiManager.fetchTVData(endPoint: DramaEndpoint.recommendations.rawValue) { tv in
            self.recommendationList = tv
            print(self.recommendationList.count)
            group.leave()
        }
        
        group.notify(queue: .main) {
            self.dramaTableView.reloadData()
            print("완료")
        }
        
    }
    
    override func configureHierarchy() {
        view.addSubview(dramaDetailView)
        view.addSubview(dramaTableView)
    }
    
    override func configureLayout() {
        dramaDetailView.snp.makeConstraints { make in
            make.top.horizontalEdges.equalToSuperview()
            make.height.equalTo(300)
        }
        
        dramaTableView.snp.makeConstraints { make in
            make.top.equalTo(dramaDetailView.snp.bottom).offset(8)
            make.horizontalEdges.bottom.equalTo(view.safeAreaLayoutGuide)
        }
    }
    
    override func configureView() {
        view.backgroundColor = .white
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
        cell.reloadCollectionView()
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
