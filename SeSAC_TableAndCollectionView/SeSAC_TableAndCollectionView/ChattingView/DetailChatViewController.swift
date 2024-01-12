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
    
    static let vcID = "DetailChatViewController"
    var detailChatData = [
        Chat(user: .jack,
             date: "2024-01-11 11:20",
             message: "\(User.user.rawValue)님~ 오늘 깃허브를 보니 커밋을 안해주셨더라구요~~~\n깃허브 푸쉬 부탁드릴게요~~~\n설마 과제를 안하신건 아니시겠죠~~?!"),
        Chat(user: .user,
             date: "2024-01-11 11:23",
             message: "제.. 제가 푸쉬를 안했군요... 얼른 푸쉬하도록 하겠습니다..."),
        Chat(user: .jack,
             date: "2024-01-11 13:29",
             message: "00님~ 아직도 푸쉬가 안되어있네요 ^_^ 수업 끝나고 면담 진행하도록 할게요~~ 끝나고 남아주세요~"),
        Chat(user: .user,
             date: "2024-01-11 13:31",
             message: "넵.."),
        Chat(user: .jack,
             date: "2024-01-11 14:42",
             message: "면담 때 매일 10시까지 남아있겠다는 말 잘 지키시는지 확인할게요~~/n아 매일은 오늘도 포함인거 아시죠?!"),
        Chat(user: .user,
             date: "2024-01-11 14:50",
             message: "네...."),
        Chat(user: .jack,
             date: "2024-01-12 20:30",
             message: "벌써 퇴근하세여?ㅎㅎㅎㅎㅎ"),
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureUI()
        setTableView()
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
        
        let userXib = UINib(nibName: DetailChatTableViewCell.cellID, bundle: nil)
        detailChatTableView.register(userXib, forCellReuseIdentifier: DetailChatTableViewCell.cellID)
        
        let ownXib = UINib(nibName: DetailOwnUserTableViewCell.cellID, bundle: nil)
        detailChatTableView.register(ownXib, forCellReuseIdentifier: DetailOwnUserTableViewCell.cellID)
    }
    
}

extension DetailChatViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        detailChatData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: DetailChatTableViewCell.cellID, for: indexPath) as? DetailChatTableViewCell else {
            return UITableViewCell()
        }
        
        if detailChatData[indexPath.row].user == .user {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: DetailOwnUserTableViewCell.cellID, for: indexPath) as? DetailOwnUserTableViewCell else {
                return UITableViewCell()
            }
            
            cell.setCellData(detailChatData[indexPath.row])
            return cell
            
        } else {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: DetailChatTableViewCell.cellID, for: indexPath) as? DetailChatTableViewCell else {
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
