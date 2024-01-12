//
//  ChattingViewController.swift
//  SeSAC_TableAndCollectionView
//
//  Created by Deokhun KIM on 1/12/24.
//

import UIKit

class ChattingViewController: UIViewController {

    @IBOutlet var friendSearchBar: UISearchBar!
    @IBOutlet var chattingTableView: UITableView!
    
    static let vcID = "ChattingViewController"
    
    //채팅 데이터
    let chatData = mockChatList

    override func viewDidLoad() {
        super.viewDidLoad()

        configureUI()
        setTableView()
    }
    
    func setTableView() {
        chattingTableView.delegate = self
        chattingTableView.dataSource = self
        
        let xib = UINib(nibName: ChattingRoomTableViewCell.cellID, bundle: nil)
        chattingTableView.register(xib, forCellReuseIdentifier: ChattingRoomTableViewCell.cellID)
        chattingTableView.rowHeight = UITableView.automaticDimension
    }
    
    func configureUI() {
        navigationItem.title = ChatConst.travelTalkTitle
        friendSearchBar.placeholder = ChatConst.searchPlaceHolder
    }
}

extension ChattingViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        chatData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: ChattingRoomTableViewCell.cellID, for: indexPath) as? ChattingRoomTableViewCell else {
            return UITableViewCell()
        }
        
        cell.setCellData(chatData[indexPath.row])
        
        return cell
    }
}
