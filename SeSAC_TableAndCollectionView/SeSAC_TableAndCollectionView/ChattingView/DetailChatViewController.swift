//
//  DetailChatViewController.swift
//  SeSAC_TableAndCollectionView
//
//  Created by Deokhun KIM on 1/12/24.
//

import UIKit

class DetailChatViewController: UIViewController {
     
    @IBOutlet var detailChatTableView: UITableView!
    @IBOutlet var chattingTextField: UITextField!
    
    static let identifier = "DetailChatViewController"
    
    var detailChatData: [Chat] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureUI()
        setTableView()
    }
    
    func getChatData(_ data: [Chat]) {
        self.detailChatData = data
    }
    
    func configureUI() {
        navigationItem.title = "Den"
        
        detailChatTableView.separatorStyle = .none
        detailChatTableView.showsVerticalScrollIndicator = false
        chattingTextField.placeholder = "메세지를 입력하세요"
    }
    
    func setTableView() {
        detailChatTableView.delegate = self
        detailChatTableView.dataSource = self
        
        let userXib = UINib(nibName: DetailChatTableViewCell.identifier, bundle: nil)
        detailChatTableView.register(userXib, forCellReuseIdentifier: DetailChatTableViewCell.identifier)
        
        let ownXib = UINib(nibName: DetailOwnUserTableViewCell.identifier, bundle: nil)
        detailChatTableView.register(ownXib, forCellReuseIdentifier: DetailOwnUserTableViewCell.identifier)
    }
    
}

extension DetailChatViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        detailChatData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if detailChatData[indexPath.row].user == .user {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: DetailOwnUserTableViewCell.identifier, for: indexPath) as? DetailOwnUserTableViewCell else {
                return UITableViewCell()
            }
            
            cell.setCellData(detailChatData[indexPath.row])
            return cell
            
        } else {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: DetailChatTableViewCell.identifier, for: indexPath) as? DetailChatTableViewCell else {
                return UITableViewCell()
            }
            
            cell.setCellData(detailChatData[indexPath.row])
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        UITableView.automaticDimension
    }
}
