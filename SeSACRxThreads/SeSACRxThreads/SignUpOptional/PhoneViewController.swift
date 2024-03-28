//
//  PhoneViewController.swift
//  SeSACRxThreads
//
//  Created by jack on 2023/10/30.
//
 
import UIKit

import RxCocoa
import RxSwift
import SnapKit

class PhoneViewController: UIViewController {
   
    let phoneTextField = SignTextField(placeholderText: "연락처를 입력해주세요")
    let nextButton = PointButton(title: "다음")
    private let descriptionLabel = UILabel()
    private let validText = Observable.just("10자 이상, 숫자만 입력해주세요")
    private let phoneNumberSubject = BehaviorSubject<String>(value: "010")
    private let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = Color.white
        
        configureLayout()
        
//        nextButton.addTarget(self, action: #selector(nextButtonClicked), for: .touchUpInside)
        bind()
    }
    
    private func bind() {
        validText
            .bind(to: descriptionLabel.rx.text)
            .disposed(by: disposeBag)
        
        let validation = phoneTextField.rx.text.orEmpty
            .map { $0.count >= 10 && Int($0) != nil }
        
        validation
            .bind(to: nextButton.rx.isEnabled, descriptionLabel.rx.isHidden)
            .disposed(by: disposeBag)
        
        validation
            .bind(with: self) { owner, bool in
                owner.nextButton.backgroundColor = bool ? .black : .systemGray
            }
            .disposed(by: disposeBag)
        
        phoneNumberSubject
            .bind(to: phoneTextField.rx.text)
            .disposed(by: disposeBag)
        
        
        phoneTextField.rx.text.orEmpty
            .filter { Int($0) != nil }
            .bind(with: self) { owner, value in
                owner.phoneNumberSubject.onNext(value)
            }
            .disposed(by: disposeBag)
        
        nextButton.rx.tap.bind(with: self) { owner, _ in
            owner.navigationController?.pushViewController(NicknameViewController(), animated: true)
        }
        .disposed(by: disposeBag)
    }
    
//    @objc func nextButtonClicked() {
//        navigationController?.pushViewController(NicknameViewController(), animated: true)
//    }

    
    func configureLayout() {
        view.addSubview(phoneTextField)
        view.addSubview(descriptionLabel)
        view.addSubview(nextButton)
         
        phoneTextField.snp.makeConstraints { make in
            make.height.equalTo(50)
            make.top.equalTo(view.safeAreaLayoutGuide).offset(200)
            make.horizontalEdges.equalTo(view.safeAreaLayoutGuide).inset(20)
        }
        
        descriptionLabel.snp.makeConstraints { make in
            make.height.equalTo(20)
            make.top.equalTo(phoneTextField.snp.bottom)
            make.leading.equalTo(phoneTextField.snp.leading)
        }
        
        nextButton.snp.makeConstraints { make in
            make.height.equalTo(50)
            make.top.equalTo(phoneTextField.snp.bottom).offset(30)
            make.horizontalEdges.equalTo(view.safeAreaLayoutGuide).inset(20)
        }
    }

}
