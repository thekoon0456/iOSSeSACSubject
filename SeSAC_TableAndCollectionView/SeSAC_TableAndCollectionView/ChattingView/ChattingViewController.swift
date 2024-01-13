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
    
    static var identifier: String {
        return String(describing: self)
    }
    
    //채팅 데이터
    private var chatData = mockChatList {
        didSet {
            chattingTableView.reloadData()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureUI()
        setTableView()
        setSearchBar()
    }
}

// MARK: - Helper

extension ChattingViewController {
    
    func dismissKeyboard() {
        view.endEditing(true)
    }
}

// MARK: -  UI

extension ChattingViewController: setUI {
    
    func setTableView() {
        chattingTableView.delegate = self
        chattingTableView.dataSource = self
        
        chattingTableView.showsVerticalScrollIndicator = false
        chattingTableView.separatorStyle = .none
        
        let xib = UINib(nibName: ChattingRoomTableViewCell.identifier, bundle: nil)
        chattingTableView.register(xib, forCellReuseIdentifier: ChattingRoomTableViewCell.identifier)
        chattingTableView.rowHeight = UITableView.automaticDimension
    }
    
    func setSearchBar() {
        friendSearchBar.delegate = self
        friendSearchBar.placeholder = ChatConst.searchPlaceHolder
    }
    
    func configureUI() {
        navigationItem.title = ChatConst.travelTalkTitle
        navigationItem.backButtonDisplayMode = .minimal
    }
}

// MARK: - SearchBar

extension ChattingViewController: UISearchBarDelegate {
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        let lowerCasedInputText = searchText.lowercased()
        
        if searchText.isEmpty {
            self.chatData = mockChatList
        }
        //친구 필터
        mockChatList.forEach { chatRoom in
            let lowercasedName = chatRoom.chatroomName.lowercased()
            
            if lowercasedName.contains(lowerCasedInputText) {
                self.chatData = mockChatList.filter {
                    let name = $0.chatroomName.lowercased()
                    return name.contains(lowerCasedInputText)
                }
            }
        }
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        dismissKeyboard()
    }
}

// MARK: - TableView

extension ChattingViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        chatData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: ChattingRoomTableViewCell.identifier, for: indexPath) as? ChattingRoomTableViewCell else {
            return UITableViewCell()
        }
        
        cell.configureCellData(chatData[indexPath.row])
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //화면 이동시 키보드 내리기
        dismissKeyboard()
        
        let vc = storyboard?.instantiateViewController(identifier: DetailChatViewController.identifier) as! DetailChatViewController
        
        vc.getChatData(chatData[indexPath.row].chatList)
        navigationController?.pushViewController(vc, animated: true)
        
        tableView.deselectRow(at: indexPath, animated: true)
    }
}