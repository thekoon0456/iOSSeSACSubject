//
//  SimpleValidationViewController.swift
//  SeSAC_RxSwiftSubject
//
//  Created by Deokhun KIM on 3/27/24.
//

import UIKit

import RxCocoa
import RxSwift
import SnapKit

final class SimpleValidationViewController: BaseViewController {
    
    private let minimalUsernameLength = 5
    private let minimalPasswordLength = 5
    
    private let userNameTextField = UITextField().then {
        $0.placeholder = "UserName"
        $0.borderStyle = .roundedRect
    }
    private let passwordTextField = UITextField().then {
        $0.placeholder = "Password"
        $0.borderStyle = .roundedRect
    }
    
    private let userNameTextFieldValidLabel = UILabel().then {
        $0.text = "Username has to be at least 5 characters"
    }
    private let passwordTextFieldValidLabel = UILabel().then {
        $0.text = "Password has to be at least 5 characters"
    }
    
    private let resultButton = UIButton().then {
        $0.backgroundColor = .systemGreen
        $0.isEnabled = false
        $0.setTitle("Do Something", for: .normal)
        $0.setTitleColor(.white, for: .normal)
    }
    
    override func bind() {
        super.bind()
        
        let userNameValid = userNameTextField.rx.text.orEmpty
            .withUnretained(self)
            .map { owner, text in
                text.count >= owner.minimalUsernameLength
            }
            .share(replay: 1)
        
        let passwordValid = passwordTextField.rx.text.orEmpty
            .withUnretained(self)
            .map { owner, text in
                text.count >= owner.minimalPasswordLength
            }
            .share(replay: 1)
        
        let everythingValid = Observable.combineLatest(userNameValid, passwordValid) { $0 && $1 }
            .share(replay: 1)
        
        userNameValid
            .bind(to: passwordTextField.rx.isEnabled)
            .disposed(by: disposeBag)
        
        userNameValid
            .bind(to: userNameTextFieldValidLabel.rx.isHidden)
            .disposed(by: disposeBag)
        
        passwordValid
            .bind(to: resultButton.rx.isEnabled)
            .disposed(by: disposeBag)
        
        passwordValid
            .bind(to: passwordTextFieldValidLabel.rx.isHidden)
            .disposed(by: disposeBag)
        
        everythingValid
            .bind(to: resultButton.rx.isEnabled)
            .disposed(by: disposeBag)
        
        resultButton.rx.tap.subscribe(with: self) { owner, _ in
            print("resultButtonTapped")
        }.disposed(by: disposeBag)
        
    }
    
    override func configureHierarchy() {
        super.configureHierarchy()
        view.addSubviews(userNameTextField, passwordTextField,
                         userNameTextFieldValidLabel, passwordTextFieldValidLabel, resultButton)
    }
    
    override func configureLayout() {
        super.configureLayout()
        userNameTextField.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.width.equalToSuperview().offset(-40)
            make.height.equalTo(100)
            make.top.equalTo(view.safeAreaLayoutGuide).offset(20)
        }
        
        userNameTextFieldValidLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.width.equalToSuperview().offset(-40)
            make.height.equalTo(100)
            make.top.equalTo(userNameTextField.snp.bottom).offset(20)
        }
           
        
        passwordTextField.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.width.equalToSuperview().offset(-40)
            make.height.equalTo(100)
            make.top.equalTo(userNameTextFieldValidLabel.snp.bottom).offset(20)
        }
               
        
        passwordTextFieldValidLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.width.equalToSuperview().offset(-40)
            make.height.equalTo(100)
            make.top.equalTo(passwordTextField.snp.bottom).offset(20)
        }
                   
        resultButton.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.width.equalToSuperview().offset(-40)
            make.height.equalTo(100)
            make.top.equalTo(passwordTextFieldValidLabel.snp.bottom).offset(20)
        }
    }
    
    override func configureView() {
        super.configureView()
    }
}
