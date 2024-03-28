//
//  PasswordViewController.swift
//  SeSACRxThreads
//
//  Created by jack on 2023/10/30.
//

import UIKit

import RxCocoa
import RxSwift
import SnapKit

class PasswordViewController: UIViewController {
   
    let passwordTextField = SignTextField(placeholderText: "비밀번호를 입력해주세요")
    let nextButton = PointButton(title: "다음")
    private let descriptionLabel = UILabel()
    private let validText = Observable.just("8자 이상 입력해주세요")
    private let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = Color.white
        
        configureLayout()
         
//        nextButton.addTarget(self, action: #selector(nextButtonClicked), for: .touchUpInside)
        bind()
    }
    
    func bind() {
        
        validText
            .bind(to: descriptionLabel.rx.text)
            .disposed(by: disposeBag)
        
        let validation = passwordTextField
            .rx.text.orEmpty
            .map { $0.count > 8 }
        
        validation
            .bind(to: nextButton.rx.isEnabled, descriptionLabel.rx.isHidden)
            .disposed(by: disposeBag)
        
        validation
            .bind(with: self) { owner, bool in
                owner.nextButton.backgroundColor = bool ? .systemPink : .lightGray
            }
            .disposed(by: disposeBag)
        
        nextButton.rx.tap
            .bind(with: self) { owner, _ in
                print("showAlert")
            }
            .disposed(by: disposeBag)
    }
    
//    @objc func nextButtonClicked() {
//        navigationController?.pushViewController(PhoneViewController(), animated: true)
//    }
    
    func configureLayout() {
        view.addSubview(passwordTextField)
        view.addSubview(nextButton)
        view.addSubview(descriptionLabel)
         
        passwordTextField.snp.makeConstraints { make in
            make.height.equalTo(50)
            make.top.equalTo(view.safeAreaLayoutGuide).offset(200)
            make.horizontalEdges.equalTo(view.safeAreaLayoutGuide).inset(20)
        }
        
        descriptionLabel.snp.makeConstraints { make in
            make.height.equalTo(20)
            make.top.equalTo(passwordTextField.snp.bottom)
            make.leading.equalTo(passwordTextField.snp.leading)
        }
        
        nextButton.snp.makeConstraints { make in
            make.height.equalTo(50)
            make.top.equalTo(passwordTextField.snp.bottom).offset(30)
            make.horizontalEdges.equalTo(view.safeAreaLayoutGuide).inset(20)
        }
    }

}
