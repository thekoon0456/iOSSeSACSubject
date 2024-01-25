//
//  TrendViewController.swift
//  SeSAC_MediaProject
//
//  Created by Deokhun KIM on 1/25/24.
//

import UIKit

class TrendViewController: UIViewController {
    
    private let tableView = UITableView()

    override func viewDidLoad() {
        super.viewDidLoad()

        configureUI()
    }

}

extension TrendViewController: SetUI {
    
    func configureUI() {
        configureNav()
        configureView()
    }
    
    func configureNav() {
        view.backgroundColor = .red
    }
    
    func configureView() {
        
    }
}
