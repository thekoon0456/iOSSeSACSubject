//
//  SimplePickerViewExampleViewController.swift
//  SeSAC_RxSwiftSubject
//
//  Created by Deokhun KIM on 3/27/24.
//

import UIKit

import RxCocoa
import RxSwift
import SnapKit

final class SimplePickerViewController: BaseViewController {
    
    private let pickerView1 = UIPickerView()
    private let pickerView2 = UIPickerView()
    private let pickerView3 = UIPickerView()
    
    override func bind() {
        super.bind()
        
        Observable.just([1, 2, 3])
            .bind(to: pickerView1.rx.itemTitles) { index, item in
                return "\(item)"
            }.disposed(by: disposeBag)
        
        pickerView1.rx.modelSelected(Int.self)
            .subscribe { value in
                print("selected1: \(value)")
            }.disposed(by: disposeBag)
        
        Observable.just([1, 2, 3])
            .bind(to: pickerView2.rx.itemAttributedTitles) { index, item in
                return NSAttributedString(string: "\(item)",
                                          attributes: [
                                            NSAttributedString.Key.foregroundColor: UIColor.cyan,
                                            NSAttributedString.Key.underlineStyle: NSUnderlineStyle.double.rawValue
                                        ])
            }.disposed(by: disposeBag)
        
        pickerView2.rx.modelSelected(Int.self)
            .subscribe { value in
                print("selected2: \(value)")
            }.disposed(by: disposeBag)
        
        Observable.just([UIColor.red, UIColor.green, UIColor.blue])
            .bind(to: pickerView3.rx.items) { index, item, view in
                let view = UIView()
                view.backgroundColor = item
                return view
            }.disposed(by: disposeBag)

        pickerView3.rx.modelSelected(UIColor.self)
            .subscribe(onNext: { models in
                print("selected3: \(models)")
            })
            .disposed(by: disposeBag)
    }
    
    override func configureHierarchy() {
        super.configureHierarchy()
        view.addSubviews(pickerView1, pickerView2, pickerView3)
    }
    
    override func configureLayout() {
        super.configureLayout()
        
        pickerView1.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.width.equalToSuperview().offset(-40)
            make.height.equalTo(150)
            make.top.equalTo(view.safeAreaLayoutGuide)
        }
        
        pickerView2.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.width.equalToSuperview().offset(-40)
            make.height.equalTo(150)
            make.top.equalTo(pickerView1.snp.bottom).offset(20)
        }
        
        pickerView3.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.width.equalToSuperview().offset(-40)
            make.height.equalTo(150)
            make.top.equalTo(pickerView2.snp.bottom).offset(20)
        }
    }
    
    override func configureView() {
        super.configureView()
        
    }
}
