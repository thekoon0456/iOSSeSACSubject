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
    }

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

}
