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

    override func configureHierarchy() {
        addSubviews(detailView, tableView)
    }
    
    override func configureLayout() {
        detailView.snp.makeConstraints { make in
            make.top.horizontalEdges.equalToSuperview()
            make.height.equalTo(300)
        }
        
        tableView.snp.makeConstraints { make in
            make.top.equalTo(detailView.snp.bottom).offset(8)
            make.horizontalEdges.bottom.equalTo(safeAreaLayoutGuide)
        }
    }
    
    override func configureView() {
        backgroundColor = .black
    }
    
}
