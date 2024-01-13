//
//  DetailChatViewController.swift
//  SeSAC_TableAndCollectionView
//
//  Created by Deokhun KIM on 1/12/24.
//

import UIKit

class DetailChatViewController: UIViewController {
     
    @IBOutlet var detailChatTableView: UITableView!
    
    @IBOutlet var chatTextView: UITextView!
    
    @IBOutlet var sendButton: UIButton!
    
    static var identifier: String {
        return String(describing: self)
    }
    
    var detailChatData: [Chat] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureUI()
        setTableView()
        setChatTextView()
        setButton()
        textViewDidEndEditing(chatTextView)
    }
    
    
    @IBAction func sendButtonTapped(_ sender: UIButton) {
        chatTextView.text = nil
        view.endEditing(true)
    }
    
    func getChatData(_ data: [Chat]) {
        navigationItem.title = setTitle(data)
        self.detailChatData = data
    }
    
    func setTitle(_ input: [Chat]) -> String? {
        input.filter { $0.user != .user }.first?.user.rawValue
    }
    
    func setChatTextView() {
        chatTextView.delegate = self
        chatTextView.font = .systemFont(ofSize: 20)
        chatTextView.backgroundColor = .systemGray6
        chatTextView.returnKeyType = .send
        chatTextView.isScrollEnabled = false
        chatTextView.showsVerticalScrollIndicator = false
        chatTextView.textContainerInset = .init(top: 15, left: 10, bottom: 15, right: 60)
        setRoundedView(chatTextView, cornerRadius: 10)
    }
}

// MARK: - UI

extension DetailChatViewController: setUI {
    
    func setButton() {
        sendButton.setImage(UIImage(systemName: ChatConst.sendButton), for: .normal)
        sendButton.tintColor = .systemGray
    }
    
    func setTableView() {
        detailChatTableView.delegate = self
        detailChatTableView.dataSource = self
        
        let userXib = UINib(nibName: DetailChatTableViewCell.identifier, bundle: nil)
        detailChatTableView.register(userXib, forCellReuseIdentifier: DetailChatTableViewCell.identifier)
        
        let ownXib = UINib(nibName: DetailOwnUserTableViewCell.identifier, bundle: nil)
        detailChatTableView.register(ownXib, forCellReuseIdentifier: DetailOwnUserTableViewCell.identifier)
    }
    
    func configureUI() {
        detailChatTableView.separatorStyle = .none
        detailChatTableView.showsVerticalScrollIndicator = false
        detailChatTableView.allowsSelection = false
    }
}

extension DetailChatViewController : UITextViewDelegate {
    // 입력을 시작할때
    // (텍스트뷰는 플레이스홀더가 따로 있지 않아서, 플레이스 홀더처럼 동작하도록 직접 구현)
    func textViewDidBeginEditing(_ textView: UITextView) {
        if textView.text == ChatConst.inputMessagePlaceHolder {
            textView.text = nil
            textView.textColor = .black
        }
    }
    
    // 입력이 끝났을때
    func textViewDidEndEditing(_ textView: UITextView) {
        // 비어있으면 다시 플레이스 홀더처럼 입력하기 위해서 조건 확인
        if textView.text.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty {
            textView.text = ChatConst.inputMessagePlaceHolder
            textView.textColor = .lightGray
        }
    }
    
    func textViewDidChange(_ textView: UITextView) {
        if textView.text.count > 100 {
            textView.isScrollEnabled = true
        } else {
            textView.isScrollEnabled = false
        }
    }
}

// MARK: - TableView

extension DetailChatViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        detailChatData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if detailChatData[indexPath.row].user == .user {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: DetailOwnUserTableViewCell.identifier, for: indexPath) as? DetailOwnUserTableViewCell else {
                return UITableViewCell()
            }
            
            cell.configureCellData(detailChatData[indexPath.row])
            return cell
            
        } else {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: DetailChatTableViewCell.identifier, for: indexPath) as? DetailChatTableViewCell else {
                return UITableViewCell()
            }
            
            cell.configureCellData(detailChatData[indexPath.row])
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        UITableView.automaticDimension
    }
}
