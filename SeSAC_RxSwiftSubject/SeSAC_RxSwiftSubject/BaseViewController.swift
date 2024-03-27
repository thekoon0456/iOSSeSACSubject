//
//  BaseViewController.swift
//  SeSAC_RxSwiftSubject
//
//  Created by Deokhun KIM on 3/27/24.
//

import UIKit

import RxSwift

class BaseViewController: UIViewController {
    
    let disposeBag = DisposeBag()
    
    init() {
        super.init(nibName: nil, bundle: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureHierarchy()
        configureLayout()
        configureView()
        bind()
    }
    
    func configureHierarchy() { }
    func configureLayout() { }
    func configureView() { 
        view.backgroundColor = .white
    }
    func bind() { }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
