//
//  MagazinInfoTableViewController.swift
//  SeSAC_MakeTableViewController
//
//  Created by Deokhun KIM on 1/8/24.
//

import UIKit

class MagazinInfoTableViewController: UITableViewController {
    
    let magazinInfoList = MagazineInfo()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.title = "SeSAC TRAVEL"
        configureUI()
    }
}

extension MagazinInfoTableViewController: setUI {
    func configureUI() {
        //모든 cell의 기본 높이 자동 설정
        tableView.rowHeight = UITableView.automaticDimension
    }
}

extension MagazinInfoTableViewController {

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return magazinInfoList.magazine.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: MagazinInfoCell.cellID, for: indexPath) as? MagazinInfoCell else {
            return UITableViewCell()
        }
        
        cell.setValue(magazinInfoList.magazine[indexPath.row])
        return cell
    }
    
    //각 cell마다 높이 가변 설정
//    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
//        //특정 index마다 가변 설정 가능
//        UITableView.automaticDimension
//    }
}
