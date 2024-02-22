//
//  LoginViewController.swift
//  SeSAC_MVVM
//
//  Created by Deokhun KIM on 2/22/24.
//

import UIKit

import SnapKit

final class LoginViewController: BaseViewController {
    
    // MARK: - Properties
    
    let viewModel = LoginViewModel()

    private let titleLabel = UILabel().then {
        $0.text = "JACKFLIX"
        $0.textColor = .red
        $0.font = .boldSystemFont(ofSize: 30)
        $0.textAlignment = .center
    }
    
    private let inputMessageLabel = UILabel().then {
        $0.text = ""
        $0.textColor = .red
        $0.font = .boldSystemFont(ofSize: 20)
        $0.textAlignment = .center
    }
    
    private lazy var emailTextField = UITextField().then {
        $0.placeholder = "이메일 주소를 입력해주세요"
        $0.backgroundColor = .secondarySystemBackground
        $0.tintColor = .white
        $0.keyboardType = .emailAddress
        $0.textAlignment = .center
        $0.layer.cornerRadius = 5
        $0.clipsToBounds = true
        $0.delegate = self
    }
    
    private lazy var passwordTextField = UITextField().then {
        $0.placeholder = "비밀번호를 입력해주세요"
        $0.backgroundColor = .secondarySystemBackground
        $0.tintColor = .white
        $0.isSecureTextEntry = true
        $0.textAlignment = .center
        $0.layer.cornerRadius = 5
        $0.clipsToBounds = true
        $0.delegate = self
    }
    
    private lazy var nicknameTextField = UITextField().then {
        $0.placeholder = "닉네임"
        $0.backgroundColor = .secondarySystemBackground
        $0.tintColor = .white
        $0.textAlignment = .center
        $0.layer.cornerRadius = 5
        $0.clipsToBounds = true
        $0.delegate = self
    }
    
    private lazy var placeTextField = UITextField().then {
        $0.placeholder = "위치"
        $0.backgroundColor = .secondarySystemBackground
        $0.tintColor = .white
        $0.textAlignment = .center
        $0.layer.cornerRadius = 5
        $0.clipsToBounds = true
        $0.delegate = self
    }
    
    private lazy var recommendCodeTextField = UITextField().then {
        $0.placeholder = "추천 코드 입력"
        $0.backgroundColor = .secondarySystemBackground
        $0.tintColor = .white
        $0.textAlignment = .center
        $0.layer.cornerRadius = 5
        $0.clipsToBounds = true
        $0.delegate = self
    }
    
    private let joinButton = UIButton().then {
        $0.setTitle("회원가입", for: .normal)
        $0.setTitleColor(.systemGray, for: .disabled)
        $0.setTitleColor(.black, for: .normal)
        $0.backgroundColor = .white
    }
    
    // MARK: - Lifecycles
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        viewModel.outputEmailText.bind { [weak self] value in
            guard let self else { return }
            inputMessageLabel.text = value
        }
        
        viewModel.outputPasswordText.bind { [weak self] value in
            guard let self else { return }
            inputMessageLabel.text = value
        }
        
        viewModel.outputNicknameText.bind { [weak self] value in
            guard let self else { return }
            inputMessageLabel.text = value
        }
        
        viewModel.outputPlaceText.bind { [weak self] value in
            guard let self else { return }
            inputMessageLabel.text = value
        }
        
        viewModel.outputRecommendCodeText.bind { [weak self] value in
            guard let self else { return }
            inputMessageLabel.text = value
        }
    }
    
    // MARK: - Configure
    
    override func configureHierarchy() {
        view.addSubviews(titleLabel,
                         emailTextField,
                         passwordTextField,
                         nicknameTextField,
                         placeTextField,
                         recommendCodeTextField,
                         joinButton,
                         inputMessageLabel)
    }
    
    override func configureLayout() {
        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide)
            make.centerX.equalToSuperview()
            make.width.equalTo(200)
            make.height.equalTo(80)
        }
        
        emailTextField.snp.makeConstraints { make in
            make.height.equalTo(40)
            make.leading.equalToSuperview().offset(20)
            make.trailing.equalToSuperview().offset(-20)
            make.top.equalTo(titleLabel.snp.bottom).offset(160)
        }
        
        passwordTextField.snp.makeConstraints { make in
            make.height.equalTo(40)
            make.top.equalTo(emailTextField.snp.bottom).offset(16)
            make.leading.equalToSuperview().offset(20)
            make.trailing.equalToSuperview().offset(-20)
        }
        
        nicknameTextField.snp.makeConstraints { make in
            make.height.equalTo(40)
            make.top.equalTo(passwordTextField.snp.bottom).offset(16)
            make.leading.equalToSuperview().offset(20)
            make.trailing.equalToSuperview().offset(-20)
        }
        
        placeTextField.snp.makeConstraints { make in
            make.height.equalTo(40)
            make.top.equalTo(nicknameTextField.snp.bottom).offset(16)
            make.leading.equalToSuperview().offset(20)
            make.trailing.equalToSuperview().offset(-20)
        }
        
        recommendCodeTextField.snp.makeConstraints { make in
            make.height.equalTo(40)
            make.top.equalTo(placeTextField.snp.bottom).offset(16)
            make.leading.equalToSuperview().offset(20)
            make.trailing.equalToSuperview().offset(-20)
        }
        
        joinButton.snp.makeConstraints { make in
            make.height.equalTo(40)
            make.top.equalTo(recommendCodeTextField.snp.bottom).offset(16)
            make.leading.equalToSuperview().offset(20)
            make.trailing.equalToSuperview().offset(-20)
        }
        
        inputMessageLabel.snp.makeConstraints { make in
            make.height.equalTo(40)
            make.top.equalTo(joinButton.snp.bottom).offset(16)
            make.leading.equalToSuperview().offset(20)
            make.trailing.equalToSuperview().offset(-20)
        }
    }
    
    override func configureView() {
        view.backgroundColor = .black
    }
}

extension LoginViewController: UITextFieldDelegate {
    
    func textFieldDidChangeSelection(_ textField: UITextField) {
        switch textField {
        case emailTextField:
            viewModel.inputEmailText.value = textField.text
        case passwordTextField:
            viewModel.inputPasswordText.value = textField.text
        case nicknameTextField:
            viewModel.inputNicknameText.value = textField.text
        case placeTextField:
            viewModel.inputPlaceText.value = textField.text
        case recommendCodeTextField:
            viewModel.inputRecommendCodeText.value = textField.text
        default:
            break
        }
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        viewModel.isCountValidation(textField.text)
    }
}
