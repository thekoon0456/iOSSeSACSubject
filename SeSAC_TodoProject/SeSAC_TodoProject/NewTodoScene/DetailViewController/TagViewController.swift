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
        $0.leftPadding(8)
        $0.backgroundColor = .secondarySystemGroupedBackground
        $0.layer.cornerRadius = 10
        $0.clipsToBounds = true
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
            make.leading.equalToSuperview().offset(8)
            make.trailing.equalToSuperview().offset(-8)
            make.height.equalTo(50)
        }
    }
    
    override func configureView() {
        super.configureView()
    }
}
