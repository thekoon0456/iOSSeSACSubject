//
//  TagViewController.swift
//  SeSAC_TodoProject
//
//  Created by Deokhun KIM on 2/14/24.
//

import UIKit

final class TagViewController: BaseViewController {
    
    // MARK: - Properties
    
    private let tagTextField = UITextField().then {
        $0.placeholder = "태그를 입력해주세요"
        $0.leftPadding(10)
        $0.tintColor = .white
        $0.layer.borderWidth = 1
        $0.layer.borderColor = UIColor.white.cgColor
    }
    
    var getTag: ((String?) -> Void)?
    
    // MARK: - Lifecycles
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        getTag?(tagTextField.text)
    }
    
    // MARK: - Helpers
    
    override func configureHierarchy() {
        view.addSubview(tagTextField)
    }
    
    override func configureLayout() {
        tagTextField.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide)
            make.horizontalEdges.equalToSuperview()
            make.height.equalTo(50)
        }
    }
    
    override func configureView() {
        super.configureView()
    }
}
