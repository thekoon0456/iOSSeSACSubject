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
    
    //불변 채팅 데이터
    let defaultData = mockChatList
    
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

extension ChattingViewController: SetUI {
    
    func setTableView() {
        chattingTableView.delegate = self
        chattingTableView.dataSource = self
        
        chattingTableView.showsVerticalScrollIndicator = false
        chattingTableView.separatorStyle = .none
        
        let defaultCellXIB = UINib(nibName: ChattingRoomTableViewCell.identifier, bundle: nil)
        chattingTableView.register(defaultCellXIB, forCellReuseIdentifier: ChattingRoomTableViewCell.identifier)
        
        let fourCellXIB = UINib(nibName: FourChattingRoomTableViewCell.identifier, bundle: nil)
        chattingTableView.register(fourCellXIB, forCellReuseIdentifier: FourChattingRoomTableViewCell.identifier)
        chattingTableView.rowHeight = UITableView.automaticDimension
    }
    
    func setSearchBar() {
        friendSearchBar.delegate = self
        friendSearchBar.placeholder = ChatConst.searchPlaceHolder.rawValue
    }
    
    func configureUI() {
        navigationItem.title = ChatConst.travelTalkTitle.rawValue
        navigationItem.backButtonDisplayMode = .minimal
    }
}

// MARK: - SearchBar

extension ChattingViewController: UISearchBarDelegate {
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        let lowerCasedInputText = searchText.lowercased()
        
        var filteringData: [ChatRoom] = []
        
        //친구 필터
        if searchText.isEmpty == true {
            self.chatData = defaultData
        } else {
            for chat in defaultData {
                var chatName = chat.chatroomName.lowercased()
                if chatName.contains(lowerCasedInputText) {
                    filteringData.append(chat)
                }
            }
            
            chatData = filteringData
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
        
        let memberCount = chatData[indexPath.row].chatroomImage.count
        var resultCell = UITableViewCell()
        
        //채팅방 멤버 수에 따라 cell 이미지 구성 (현재 1, 4만 있음)
        switch memberCount {
        case 1:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: ChattingRoomTableViewCell.identifier, for: indexPath) as? ChattingRoomTableViewCell else {
                return UITableViewCell()
            }
            
            cell.configureCellData(chatData[indexPath.row])
            resultCell = cell
        default:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: FourChattingRoomTableViewCell.identifier, for: indexPath) as? FourChattingRoomTableViewCell else { 
                return UITableViewCell()
            }
            
            cell.configureCellData(chatData[indexPath.row])
            resultCell = cell
        }
        
        return resultCell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //cell로 화면 이동시 키보드 내리기
        dismissKeyboard()
        
        let vc = storyboard?.instantiateViewController(identifier: DetailChatViewController.identifier) as! DetailChatViewController
        
        vc.getChatData(chatData[indexPath.row].chatList)
        navigationController?.pushViewController(vc, animated: true)
        
        tableView.deselectRow(at: indexPath, animated: true)
    }
}


