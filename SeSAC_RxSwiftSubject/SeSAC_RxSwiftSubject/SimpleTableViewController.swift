//
//  SimpleTableViewController.swift
//  SeSAC_RxSwiftSubject
//
//  Created by Deokhun KIM on 3/27/24.
//

import UIKit

import RxCocoa
import RxSwift
import SnapKit

final class SimpleTableViewController: BaseViewController {
    
    private let tableView = UITableView().then {
        $0.register(UITableViewCell.self, forCellReuseIdentifier: "Cell")
    }
    
    let items = Observable.just(0..<20).map { "\($0)" }
    
    override func bind() {
        super.bind()
        
        items.bind(to: tableView.rx.items(cellIdentifier: "Cell", cellType: UITableViewCell.self)) { row, element, cell in
            cell.textLabel?.text = "\(element) @ row \(row)"
        }.disposed(by: disposeBag)
        
        tableView.rx.modelSelected(String.self)
            .subscribe(with: self) { owner, value in
                print("Tapped \(value)")
            }.disposed(by: disposeBag)
        
        tableView.rx
            .itemAccessoryButtonTapped
            .subscribe(with: self) { owner, indexPath in
                print("Tapped Detail @ \(indexPath.section),\(indexPath.row)")
            }.disposed(by: disposeBag)
    }
    
    override func configureHierarchy() {
        super.configureHierarchy()
        view.addSubview(tableView)
    }
    
    override func configureLayout() {
        super.configureLayout()
        tableView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
}
