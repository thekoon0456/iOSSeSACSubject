//
//  ShoppingTableViewController.swift
//  SeSAC_MakeTableViewController
//
//  Created by Deokhun KIM on 1/5/24.
//

import UIKit

//UserDefaults 사용 Data 인코딩, 디코딩 위한 Codable 채택
struct Shopping: Codable {
    static let key = "shoppingList"
    
    var isChecked: Bool
    let title: String
    var isBookmarked: Bool
}

class ShoppingTableViewController: UITableViewController {

    @IBOutlet var customHeaderView: UIView!
    @IBOutlet var inputTextField: UITextField!
    
    //기본 값
    var shoppingList = [Shopping(isChecked: false, title: "그립톡 구매하기", isBookmarked: false),
                        Shopping(isChecked: false, title: "사이다 구매", isBookmarked: false),
                        Shopping(isChecked: false, title: "아이패드 케이스 최저가 알아보기", isBookmarked: false),
                        Shopping(isChecked: false, title: "양말", isBookmarked: false)] {
        didSet {
            UserDefaultsManager.shared.list = shoppingList
            tableView.reloadData()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureUI()
    }
    
    @IBAction func addButtonTapped(_ sender: UIButton) {
        guard
            let input = inputTextField.text,
            input.isEmpty == false
        else {
            print("입력해주세요")
            return
        }
        
        let inputShopping = Shopping(isChecked: false, title: input, isBookmarked: false)
        
        shoppingList.append(inputShopping)
    }
    
    @objc func checkButtonTapped(sender: UIButton) {
        shoppingList[sender.tag].isChecked.toggle()
    }
    
    @objc func starButtonTapped(sender: UIButton) {
        shoppingList[sender.tag].isBookmarked.toggle()
    }
    
    // MARK: - Helpers
    
    func configureUI() {
        navigationItem.title = "쇼핑"
        
        //UserDefaults값 있으면 불러옴
        if let list = UserDefaultsManager.shared.list {
            shoppingList = list
        }
        
        customHeaderView.layer.cornerRadius = 10
        customHeaderView.clipsToBounds = true
    }
    
    // MARK: - TableView 구성
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return shoppingList.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: ShoppingTableViewCell.cellID, for: indexPath) as? ShoppingTableViewCell else {
            return UITableViewCell()
        }
        
        //Data전달
        cell.setValue(shopping: shoppingList[indexPath.row])
        
        //각 버튼에 tag추가
        cell.checkButton.tag = indexPath.row
        cell.starButton.tag = indexPath.row
        
        //버튼 action추가
        cell.checkButton.addTarget(self,
                                   action: #selector(checkButtonTapped),
                                   for: .touchUpInside)
        cell.starButton.addTarget(self,
                                  action: #selector(starButtonTapped),
                                  for: .touchUpInside)
        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
    
    // MARK: - Cell 삭제
    
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        true
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        
        if editingStyle == .delete {
            shoppingList.remove(at: indexPath.row)
        }
    }
}
