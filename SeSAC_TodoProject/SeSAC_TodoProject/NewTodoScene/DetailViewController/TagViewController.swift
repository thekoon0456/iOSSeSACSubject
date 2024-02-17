//
//  TagViewController.swift
//  SeSAC_TodoProject
//
//  Created by Deokhun KIM on 2/14/24.
//

import UIKit

final class TagViewController: BaseViewController {
    
    // MARK: - Properties
    
    private lazy var tagTextField = UITextField().then {
        $0.placeholder = "태그를 입력해주세요"
        $0.leftPadding(8)
        $0.backgroundColor = .secondarySystemGroupedBackground
        $0.layer.cornerRadius = 10
        $0.clipsToBounds = true
        $0.delegate = self
    }
    
    // MARK: - Lifecycles
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        postNotification(name: "우선순위",
                         userInfo: ["tag": tagTextField.text])
    }
    
    // MARK: - Helpers
    
    func postNotification(name: String, userInfo: [String: Any]?) {
        NotificationCenter.default.post(name: NSNotification.Name(name),
                                        object: nil,
                                        userInfo: userInfo)
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

extension TagViewController: UITextFieldDelegate {
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        guard let input = textField.text,
              input.count < 10 else { return false }
        let text = (input as NSString).replacingCharacters(in: range, with: string)
        
        tagTextField.text = text
        return true
    }
}
