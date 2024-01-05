//
//  SettingTableViewController.swift
//  SeSAC_MakeTableViewController
//
//  Created by Deokhun KIM on 1/5/24.
//

import UIKit

class SettingTableViewController: UITableViewController {
    let sections = ["전체 설정", "개인 설정", "기타"]
    let wholeSetting = ["공지사항", "실험실", "버전 정보"]
    let personalSetting = ["개인/보안", "알림", "채팅", "멀티프로필"]
    let etc = ["고객센터/도움말"]

    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.title = "설정"
    }

    // MARK: - Section

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return sections.count
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        switch section {
        case 0:
            return wholeSetting.count
        case 1:
            return personalSetting.count
        case 2:
            return etc.count
        default:
            return 0
        }
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        switch section {
        case 0:
            return sections[0]
        case 1:
            return sections[1]
        case 2:
            return sections[2]
        default:
            return ""
        }
    }
    
    // MARK: - confugure
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "SettingCell") else {
            return UITableViewCell()
        }
        
        switch indexPath.section {
        case 0:
            cell.textLabel?.text = wholeSetting[indexPath.row]
        case 1:
            cell.textLabel?.text = personalSetting[indexPath.row]
        case 2:
            cell.textLabel?.text = etc[indexPath.row]
        default:
            return cell
        }
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        40
    }
}
