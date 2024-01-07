//
//  ShoppingTableViewController.swift
//  SeSAC_MakeTableViewController
//
//  Created by Deokhun KIM on 1/5/24.
//

import UIKit

class ShoppingTableViewController: UITableViewController {
    
    @IBOutlet var customHeaderView: UIView!
    @IBOutlet var inputTextField: UITextField!
    
    let sections = ["header", "list"]
    
    var contentList = ["그립톡 구매하기",
                       "사이다 구매",
                       "아이패드 케이스 최저가 알아보기",
                       "양말"] {
        didSet {
            print("\(contentList) 수정됨")
            tableView.reloadData()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureUI()
    }
    
    func configureUI() {
        navigationItem.title = "쇼핑"
        
        customHeaderView.layer.cornerRadius = 10
        customHeaderView.clipsToBounds = true
//        cellInnerView.layer.cornerRadius = 10
//        cellInnerView.clipsToBounds = true
//        cellInnerView.backgroundColor = .systemGray6
    }
    
    @IBAction func addButtonTapped(_ sender: UIButton) {
        guard let input = inputTextField.text,
              input.isEmpty == false
        else {
            print("입력해주세요")
            return
        }
        
        contentList.append(input)
    }
    
    // MARK: - TableView 구성
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return contentList.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: ShoppingTableViewCell.cellID, for: indexPath) as? ShoppingTableViewCell else {
            return UITableViewCell()
        }
        
        cell.setValue(content: contentList[indexPath.row])
        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
    
    
    // MARK: - 삭제 구현
    
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        true
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        
        if editingStyle == .delete {
            contentList.remove(at: indexPath.row)
        }
    }
}
