//
//  TVView.swift
//  SeSAC_MediaProject
//
//  Created by Deokhun KIM on 2/2/24.
//

import UIKit

final class TVView: BaseUIView {
    
    // MARK: - Properties
    
    let tableView = UITableView().then {
        $0.register(TVTableViewCell.self, forCellReuseIdentifier: TVTableViewCell.identifier)
        $0.rowHeight = 240
        $0.separatorStyle = .none
        $0.backgroundColor = .clear
    }
    
    // MARK: - Helpers
    
    override func configureHierarchy() {
        addSubview(tableView)
    }
    
    override func configureLayout() {
        tableView.snp.makeConstraints { make in
            make.edges.equalTo(safeAreaLayoutGuide)
        }
    }
    
    override func configureView() {
        backgroundColor = .black
    }
}
