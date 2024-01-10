//
//  SettingTableViewController.swift
//  SeSAC_MakeTableViewController
//
//  Created by Deokhun KIM on 1/5/24.
//

import UIKit

class SettingTableViewController: UITableViewController {
    
    enum Section: CaseIterable {
        case all
        case personal
        case etc
        
        var sectionTitle: String {
            switch self {
            case .all:
                "전체 설정"
            case .personal:
                "개인 설정"
            case .etc:
                "기타"
            }
        }
        
        var cellTitle: [String] {
            switch self {
            case .all:
                ["공지사항", "실험실", "버전 정보"]
            case .personal:
                ["개인/보안", "알림", "채팅", "멀티프로필"]
            case .etc:
                ["고객센터/도움말"]
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureUI()
    }
}

extension SettingTableViewController: setUI {
    func configureUI() {
        navigationItem.title = "설정"
    }
}

extension SettingTableViewController {
    
    // MARK: - Section
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return Section.allCases.count
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return Section.allCases[section].cellTitle.count
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return Section.allCases[section].sectionTitle
    }
    
    // MARK: - confugure
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "SettingCell") else {
            return UITableViewCell()
        }
        
        let settingType = Section.allCases[indexPath.section]
        cell.textLabel?.text = settingType.cellTitle[indexPath.row]
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 40
    }
}
