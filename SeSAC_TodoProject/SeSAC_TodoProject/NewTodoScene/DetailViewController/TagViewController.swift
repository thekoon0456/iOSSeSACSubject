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

extension TagViewController: UITextFieldDelegate {
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        guard let input = textField.text,
              input.count < 10 else { return false }
        let text = (input as NSString).replacingCharacters(in: range, with: string)
        textField.text = text
        return true
    }
}
