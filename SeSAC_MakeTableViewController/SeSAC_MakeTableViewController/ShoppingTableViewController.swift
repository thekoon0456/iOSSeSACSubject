//
//  ShoppingTableViewController.swift
//  SeSAC_MakeTableViewController
//
//  Created by Deokhun KIM on 1/5/24.
//

import UIKit

@propertyWrapper
struct UserDefault<T: Codable> {
    private var key: String
    private var defaultData: T?
    
    init(key: String, defaultData: T?) {
        self.key = key
        self.defaultData = defaultData
    }
    
    var wrappedValue: T? {
        get {
            if let savedData = UserDefaults.standard.object(forKey: key) as? Data {
                let decoder = JSONDecoder()
                if let loadedData = try? decoder.decode(T.self, from: savedData) {
                    return loadedData
                }
            }
            return defaultData
        }
        set {
            let encoder = JSONEncoder()
            if let encodedData = try? encoder.encode(newValue) {
                UserDefaults.standard.set(encodedData, forKey: key)
            }
        }
    }
    
}

struct Shopping: Codable {
    var isChecked: Bool
    let title: String
    var isBookmarked: Bool
}

class ShoppingTableViewController: UITableViewController {

    @IBOutlet var customHeaderView: UIView!
    @IBOutlet var inputTextField: UITextField!
    
    @UserDefault(key: "shoppingList", defaultData: nil)
    var list: [Shopping]?
    
    var shoppingList = [Shopping(isChecked: false, title: "그립톡 구매하기", isBookmarked: false),
                        Shopping(isChecked: false, title: "사이다 구매", isBookmarked: false),
                        Shopping(isChecked: false, title: "아이패드 케이스 최저가 알아보기", isBookmarked: false),
                        Shopping(isChecked: false, title: "양말", isBookmarked: false),] {
        didSet {
            list = shoppingList
            tableView.reloadData()
        }
    }
    
    let sections = ["header", "list"]
    
//    var contentList = ["그립톡 구매하기",
//                       "사이다 구매",
//                       "아이패드 케이스 최저가 알아보기",
//                       "양말"] {
//        didSet {
//            print("\(contentList) 수정됨")
//            tableView.reloadData()
//        }
//    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureUI()
    }
    
    func configureUI() {
        navigationItem.title = "쇼핑"
        
        customHeaderView.layer.cornerRadius = 10
        customHeaderView.clipsToBounds = true
    }
    
    @IBAction func addButtonTapped(_ sender: UIButton) {
        guard let input = inputTextField.text,
              input.isEmpty == false
        else {
            print("입력해주세요")
            return
        }
        
        let inputShopping = Shopping(isChecked: false, title: input, isBookmarked: false)
        
        shoppingList.append(inputShopping)
    }
    
    // MARK: - TableView 구성
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return shoppingList.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: ShoppingTableViewCell.cellID, for: indexPath) as? ShoppingTableViewCell else {
            return UITableViewCell()
        }
        
        cell.setValue(shopping: shoppingList[indexPath.row])
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
            shoppingList.remove(at: indexPath.row)
        }
    }
}
