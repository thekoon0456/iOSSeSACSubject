//
//  MagazinInfoTableViewController.swift
//  SeSAC_MakeTableViewController
//
//  Created by Deokhun KIM on 1/8/24.
//

import UIKit

final class MagazinInfoTableViewController: UITableViewController {
    
    let magazinInfoList = MagazineInfo().magazine
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureUI()
    }
}

extension MagazinInfoTableViewController: SetUI {
    
    func configureUI() {
        //모든 cell의 기본 높이 자동 설정
        navigationItem.title = "SeSAC TRAVEL"
        tableView.rowHeight = UITableView.automaticDimension
    }
}

// MARK: - TableView

extension MagazinInfoTableViewController {

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return magazinInfoList.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: MagazinInfoCell.identifier, for: indexPath) as? MagazinInfoCell else {
            return UITableViewCell()
        }
        
        cell.configureCellData(magazinInfoList[indexPath.row])
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = storyboard?.instantiateViewController(withIdentifier: MagazineWebViewController.identifier) as! MagazineWebViewController
        
        vc.setData(magazinInfoList[indexPath.row])
        navigationController?.pushViewController(vc, animated: true)
        
        tableView.reloadRows(at: [indexPath], with: .fade)
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        UITableView.automaticDimension
    }
}
