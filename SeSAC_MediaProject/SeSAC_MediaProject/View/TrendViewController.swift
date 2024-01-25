//
//  TrendViewController.swift
//  SeSAC_MediaProject
//
//  Created by Deokhun KIM on 1/25/24.
//

import UIKit

class TrendViewController: UIViewController {
    
    let apiManager = APIManager.shared
    
    private let tableView = UITableView()

    override func viewDidLoad() {
        super.viewDidLoad()

        configureUI()
        requestURL()
    }

}

extension TrendViewController {
    
    func requestURL() {
        apiManager.callRequest(url: apiManager.url) { trend in
            print(trend)
        }
    }
}

extension TrendViewController: SetUI {
    
    func configureUI() {
        configureNav()
        configureView()
    }
    
    func configureNav() {
        navigationItem.title = "Trend"
    }
    
    func configureView() {
        view.backgroundColor = .red
    }
}
