//
//  NumbersViewController.swift
//  SeSAC_RxSwiftSubject
//
//  Created by Deokhun KIM on 3/27/24.
//

import UIKit

import RxCocoa
import RxSwift
import SnapKit

final class NumbersViewController: BaseViewController {
    
    private let textField1 = UITextField().then {
        $0.text = "0"
        $0.borderStyle = .roundedRect
    }
    private let textField2 = UITextField().then {
        $0.text = "0"
        $0.borderStyle = .roundedRect
    }
    private let textField3 = UITextField().then {
        $0.text = "0"
        $0.borderStyle = .roundedRect
    }
    private let resultLabel = UILabel()
    
    override func bind() {
        super.bind()
        
        Observable
            .combineLatest(textField1.rx.text.orEmpty,
                           textField2.rx.text.orEmpty,
                           textField3.rx.text.orEmpty) { value1, value2, value3 -> Int in
                guard let value1 = Int(value1),
                      let value2 = Int(value2),
                      let value3 = Int(value3) else { return 0}
                return value1 + value2 + value3
            }.map { $0.description }
            .bind(to: resultLabel.rx.text)
            .disposed(by: disposeBag)
    }
    
    override func configureHierarchy() {
        super.configureHierarchy()
        view.addSubviews(textField1, textField2, textField3, resultLabel)
    }
    
    override func configureLayout() {
        super.configureLayout()
        textField1.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.width.equalTo(100)
            make.height.equalTo(50)
            make.top.equalTo(view.safeAreaLayoutGuide).offset(200)
        }
        
        textField2.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.width.equalTo(100)
            make.height.equalTo(50)
            make.top.equalTo(textField1.snp.bottom).offset(12)
        }
        
        textField3.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.width.equalTo(100)
            make.height.equalTo(50)
            make.top.equalTo(textField2.snp.bottom).offset(12)
        }
        
        resultLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.width.equalTo(100)
            make.height.equalTo(50)
            make.top.equalTo(textField3.snp.bottom).offset(12)
        }
    }
    
    override func configureView() {
        super.configureView()
    }
}
