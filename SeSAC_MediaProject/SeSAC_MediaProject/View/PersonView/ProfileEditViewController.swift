//
//  ProfileEditViewController.swift
//  SeSAC_MediaProject
//
//  Created by Deokhun KIM on 2/7/24.
//

import UIKit

import SnapKit

final class ProfileEditViewController: BaseViewController {
    
    // MARK: - Properties
    
    private let label = UILabel().then {
        $0.font = .systemFont(ofSize: 12)
        $0.textColor = .systemGray
    }
    
    private let textField = UITextField().then {
        $0.borderStyle = .none
    }
    
    let lineView = UIView().then {
        $0.backgroundColor = .darkGray
    }
    
    // MARK: - Helpers
    
    func configureLabel(input: String) {
        navigationItem.title = input
        label.text = input
    }
    
    override func configureHierarchy() {
        view.addSubviews(label, textField, lineView)
    }
    
    override func configureLayout() {
        label.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide)
            make.leading.equalToSuperview().offset(4)
        }
        
        textField.snp.makeConstraints { make in
            make.top.equalTo(label.snp.bottom)
            make.horizontalEdges.equalToSuperview()
            make.height.equalTo(40)
        }
        lineView.snp.makeConstraints { make in
            make.top.equalTo(textField.snp.bottom)
            make.width.equalTo(textField.snp.width)
            make.height.equalTo(1)
        }
    }
}
