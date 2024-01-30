//
//  TrendViewController.swift
//  SeSAC_MediaProject
//
//  Created by Deokhun KIM on 1/25/24.
//

//import UIKit
//
//class TrendViewController: UIViewController {
//    
//    let apiManager = APIManager.shared
//    
//    private lazy var trendTableView = {
//        let tableView = UITableView(frame: .zero, style: .plain)
//        tableView.delegate = self
//        tableView.dataSource = self
//        tableView.register(TrendCell.self, forCellReuseIdentifier: TrendCell.identifier)
//        tableView.translatesAutoresizingMaskIntoConstraints = false
//        return tableView
//    }()
//    
//    var trendList: [Trend] = [] {
//        didSet {
//            trendTableView.reloadData()
//        }
//    }
//
//    override func viewDidLoad() {
//        super.viewDidLoad()
//
//        configureUI()
//        requestURL()
//    }
//
//}
//
//extension TrendViewController {
//    
//    func requestURL() {
//        DispatchQueue.global().async {
//            self.apiManager.callRequest(url: self.apiManager.url) { trends in
//                print(trends)
//                DispatchQueue.main.async {
//                    self.trendList = trends
//                }
//            }
//        }
//
//    }
//}
//
//extension TrendViewController: SetUI {
//    
//    func configureUI() {
//        configureNav()
//        configureView()
//    }
//    
//    func configureNav() {
//        navigationItem.title = "Trend"
//    }
//    
//    func configureView() {
//        view.backgroundColor = .red
//        view.addSubview(trendTableView)
//        
//        NSLayoutConstraint.activate([
//            trendTableView.topAnchor.constraint(equalTo: view.topAnchor),
//            trendTableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
//            trendTableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
//            trendTableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
//        
//        ])
//    }
//    
//}
//
//extension TrendViewController: UITableViewDelegate, UITableViewDataSource {
//    
//    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        trendList.count
//    }
//    
//    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        guard let cell = tableView.dequeueReusableCell(withIdentifier: TrendCell.identifier, for: indexPath) as? TrendCell else {
//            return UITableViewCell()
//        }
//        
//        cell.configureCellData(trendList[indexPath.row])
//        return cell
//    }
//    
//    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
//        UITableView.automaticDimension
//    }
//}
