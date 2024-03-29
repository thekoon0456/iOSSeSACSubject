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
    @IBOutlet var chatTextViewHeight: NSLayoutConstraint!
    
    lazy var detailChatData: [Chat] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureUI()
        setTableView()
        setChatTextView()
        setButton()
    }

    @IBAction func sendButtonTapped(_ sender: UIButton) {
        let newChat = Chat(user: .user,
                           date: DateService.shared.dateToString(Date(),
                                                                 format: DateService.DateStyle.chatRoomStyle),
                           message: chatTextView.text)
        //배열에 추가하고, reload
        detailChatData.append(newChat)
        detailChatTableView.reloadData()
        
        //textView초기화
        chatTextView.text = nil
        textViewDidChange(chatTextView)
        
        //아래로 스크롤
        scrollToBottom(detailChatTableView,
                       row: detailChatData.count - 1)
        
    }
}

// MARK: - Logic

extension DetailChatViewController {
    //데이터 넣어주기
    func getChatData(_ data: [Chat]) {
        navigationItem.title = setTitle(data)
        makeDateDifferenceLine(data: data)
    }
    
    //네비 타이틀 이름
    func setTitle(_ input: [Chat]) -> String? {
        input.filter { $0.user != .user }.first?.user.rawValue
    }
    
    func makeDateDifferenceLine(data: [Chat]) {
        var data = data
        
        //기존 날짜 데이터에서 날짜만 떼서 비교
        let firstDates = data.map { chat in
            chat.date.split(separator: " ").first
        }

        //인접한 인덱스끼리 날짜 비교
        (1..<firstDates.count).forEach { index in
            if firstDates[index - 1] != firstDates[index] {
                //날짜 바뀌는 cell을 true로 값 변경
                data[index].isChangedDate = true
            }
        }
        
        detailChatData = data
    }
}

// MARK: - UI

extension DetailChatViewController: SetUI {
    
    func setChatTextView() {
        chatTextView.delegate = self
        chatTextView.font = .systemFont(ofSize: 16)
        chatTextView.textColor = .lightGray
        chatTextView.backgroundColor = .systemGray6
        chatTextView.returnKeyType = .send
        chatTextView.showsVerticalScrollIndicator = false
        chatTextView.textContainerInset = .init(top: 15, left: 10, bottom: 15, right: 60)
        setRoundedView(chatTextView, cornerRadius: 10)
    }
    
    func setButton() {
        sendButton.setImage(UIImage(systemName: ChatConst.sendButton.rawValue), for: .normal)
        sendButton.tintColor = .systemGray
    }
    
    func setTableView() {
        detailChatTableView.delegate = self
        detailChatTableView.dataSource = self
        
        let userXib = UINib(nibName: DetailChatTableViewCell.identifier, bundle: nil)
        detailChatTableView.register(userXib, forCellReuseIdentifier: DetailChatTableViewCell.identifier)
        
        let ownXib = UINib(nibName: DetailOwnUserTableViewCell.identifier, bundle: nil)
        detailChatTableView.register(ownXib, forCellReuseIdentifier: DetailOwnUserTableViewCell.identifier)
        
        
        //아래 스크롤
        scrollToBottom(detailChatTableView,
                       row: detailChatData.count - 1)
    }
    
    func configureUI() {
        //placeHolder세팅
        textViewDidEndEditing(chatTextView)
        
        //tableView세팅
        detailChatTableView.separatorStyle = .none
        detailChatTableView.showsVerticalScrollIndicator = false
        detailChatTableView.allowsSelection = false
    }
}

// MARK: - TextView

extension DetailChatViewController : UITextViewDelegate {
    // 입력을 시작할때
    func textViewDidBeginEditing(_ textView: UITextView) {
        if textView.textColor == .lightGray {
            textView.text = nil
            textView.textColor = .black
        }
    }
    
    // 입력이 끝났을때
    func textViewDidEndEditing(_ textView: UITextView) {
        // 비어있으면 다시 플레이스 홀더처럼 입력하기 위해서 조건 확인
        if textView.text.isEmpty {
            textView.text = ChatConst.inputMessagePlaceHolder.rawValue
            textView.textColor = .lightGray
            
            //Text가 비어있을때는 버튼 못 누르도록
            sendButton.isEnabled = false
        }
    }
    
    //높이 어느정도 늘어나면 스크롤로 전환
    func textViewDidChange(_ textView: UITextView) {
        //Text가 띄워쓰기만 있을때는 버튼 못 누르도록
        if textView.text.filter({ $0 == " " }).count == textView.text.count {
            sendButton.isEnabled = false
        } else {
            sendButton.isEnabled = true
        }
        
        //textView 높이 유동적 설정
        let maxHeight: CGFloat = 120
        let chatViewSize = CGSize(width: view.frame.width - 32, height: .infinity)
        let estimagedSize = chatTextView.sizeThatFits(chatViewSize)
        
        guard estimagedSize.height < maxHeight else { return }
        chatTextViewHeight.constant = estimagedSize.height
    }
}

// MARK: - TableView

extension DetailChatViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        detailChatData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        //유저인지, 상대방인지에 따라 cell 구성
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
