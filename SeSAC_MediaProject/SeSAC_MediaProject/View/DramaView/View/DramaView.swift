//
//  DramaView.swift
//  SeSAC_MediaProject
//
//  Created by Deokhun KIM on 2/2/24.
//

import UIKit

final class DramaView: BaseUIView {
    
    let detailView = DramaDetailView()
    lazy var tableView = UITableView().then {
        $0.register(TVTableViewCell.self, forCellReuseIdentifier: TVTableViewCell.identifier)
        $0.rowHeight = 240
        $0.separatorStyle = .none
        $0.backgroundColor = .clear
    }
    
    let detailButton = UIButton().then {
        $0.setImage(UIImage(systemName: "safari")?.withRenderingMode(.alwaysOriginal), for: .normal)
        $0.setTitle("더 보기", for: .normal)
        $0.tintColor = .white
        $0.layer.borderWidth = 1
        $0.layer.borderColor = UIColor.white.cgColor
        $0.imageEdgeInsets = .init(top: 0, left: -24, bottom: 0, right: 0)
    }
    
    let youtubeButton = UIButton().then {
        $0.setImage(UIImage(systemName: "movieclapper")?.withRenderingMode(.alwaysOriginal), for: .normal)
        $0.setTitle("트레일러 보기", for: .normal)
        $0.tintColor = .white
        $0.layer.borderWidth = 1
        $0.layer.borderColor = UIColor.white.cgColor
        $0.imageEdgeInsets = .init(top: 0, left: -24, bottom: 0, right: 0)
    }

    override func configureHierarchy() {
        addSubviews(detailView, tableView, detailButton, youtubeButton)
    }
    
    override func configureLayout() {
        detailView.snp.makeConstraints { make in
            make.top.horizontalEdges.equalToSuperview()
            make.height.equalTo(300)
        }
        
        detailButton.snp.makeConstraints { make in
            make.top.equalTo(detailView.snp.bottom).offset(8)
            make.leading.equalToSuperview().offset(12)
            make.height.equalTo(40)
        }
        
        youtubeButton.snp.makeConstraints { make in
            make.top.equalTo(detailView.snp.bottom).offset(8)
            make.leading.equalTo(detailButton.snp.trailing).offset(12)
            make.trailing.equalToSuperview().offset(-12)
            make.height.equalTo(40)
            make.width.equalTo(detailButton.snp.width)
        }
        
        tableView.snp.makeConstraints { make in
            make.top.equalTo(detailButton.snp.bottom).offset(8)
            make.horizontalEdges.bottom.equalTo(safeAreaLayoutGuide)
        }
    }
    
    override func configureView() {
        backgroundColor = .black
    }
    
}
