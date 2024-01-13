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
    
    static let identifier = "ChattingViewController"
    
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
        
        let xib = UINib(nibName: ChattingRoomTableViewCell.identifier, bundle: nil)
        chattingTableView.register(xib, forCellReuseIdentifier: ChattingRoomTableViewCell.identifier)
        chattingTableView.rowHeight = UITableView.automaticDimension
    }
    
    func configureUI() {
        navigationItem.title = ChatConst.travelTalkTitle
        navigationItem.backButtonDisplayMode = .minimal
        
        friendSearchBar.placeholder = ChatConst.searchPlaceHolder
        
        chattingTableView.showsVerticalScrollIndicator = false
        chattingTableView.separatorStyle = .none
    }
}

extension ChattingViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        chatData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: ChattingRoomTableViewCell.identifier, for: indexPath) as? ChattingRoomTableViewCell else {
            return UITableViewCell()
        }
        
        cell.setCellData(chatData[indexPath.row])
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = storyboard?.instantiateViewController(identifier: DetailChatViewController.identifier) as! DetailChatViewController
        
        vc.getChatData(chatData[indexPath.row].chatList)
        navigationController?.pushViewController(vc, animated: true)
        
        tableView.deselectRow(at: indexPath, animated: true)
    }
}
