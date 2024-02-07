//
//  PersonViewController.swift
//  SeSAC_MediaProject
//
//  Created by Deokhun KIM on 2/7/24.
//

import UIKit

import Kingfisher
import SnapKit

final class ProfileViewController: BaseViewController {
    
    // MARK: - Properties
    
    private let profileSettingList = ["이름", "사용자 이름", "성별 대명사", "소개", "링크"]
    
    private let profileImageView = UIImageView().then {
        $0.contentMode = .scaleAspectFill
        $0.clipsToBounds = true
        $0.layer.cornerRadius = 50 //100
    }
    
    private lazy var tableView = UITableView().then {
        $0.register(ProfileTableViewCell.self, forCellReuseIdentifier: ProfileTableViewCell.identifier)
        $0.delegate = self
        $0.dataSource = self
    }
    
    private var inputText: String?
    private var index: Int? {
        didSet {
            tableView.reloadData()
        }
    }
    
    // MARK: - Helpers
    
    override func configureHierarchy() {
        view.addSubviews(profileImageView, tableView)
    }
    
    override func configureLayout() {
        profileImageView.snp.makeConstraints { make in
            make.size.equalTo(100)
            make.centerX.equalToSuperview()
            make.top.equalTo(view.safeAreaLayoutGuide).offset(12)
        }
        
        tableView.snp.makeConstraints { make in
            make.top.equalTo(profileImageView.snp.bottom).offset(12)
            make.horizontalEdges.bottom.equalToSuperview()
        }
    }
    
    override func configureView() {
        view.backgroundColor = .black
        navigationItem.title = "프로필 편집"
        navigationItem.backButtonDisplayMode = .minimal
        let placeHolder = UIImage(systemName: "movieclapper")?.withTintColor(.white, renderingMode: .alwaysOriginal)
        profileImageView.kf.setImage(with: URL(string: "https://avatars.githubusercontent.com/u/106993057?v=4"), placeholder: placeHolder)
    }
}

// MARK: - TableView

extension ProfileViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        profileSettingList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: ProfileTableViewCell.identifier, for: indexPath) as? ProfileTableViewCell else {
            return UITableViewCell()
        }
        if indexPath.row == self.index {
            cell.setTextFieldText(input: inputText)
        }
        cell.configureCellData(input: profileSettingList[indexPath.row])
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        50
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = ProfileEditViewController()
        vc.configureLabel(input: profileSettingList[indexPath.row])
        vc.getInputData = { [weak self] input in
            guard let self else { return }
            inputText = input
            index = indexPath.row
        }
        
        navigationController?.pushViewController(vc, animated: true)
        
        tableView.reloadRows(at: [indexPath], with: .fade)
    }
}
