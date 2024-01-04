//
//  ViewController.swift
//  SeSAC_BMiCalculator
//
//  Created by Deokhun KIM on 1/3/24.
//

import UIKit

final class ViewController: UIViewController {
    
    enum InputType: String {
        case name
        case tall
        case weight
        
        var type: String {
            switch self {
            case .name:
                return "name"
            case .tall:
                return "tall"
            case .weight:
                return "weight"
            }
        }
    }
    
    enum InputError: Error {
        case emptyInput
        case notIntInput
        case faultInput
        case faultTallInput
        case faultWeightInput
    }
    
    enum ResultValue {
        case 저체중
        case 정상체중
        case 과체중
        case 비만
        case 고도비만
        
        var name: String {
            switch self {
            case .저체중:
                return "저체중"
            case .정상체중:
                return "정상 체중"
            case .과체중:
                return "과체중"
            case .비만:
                return "비만"
            case .고도비만:
                return "고도비만"
            }
        }
    }
    
    @IBOutlet var titleLabel: UILabel!
    @IBOutlet var subTitleLabel: UILabel!
    @IBOutlet var peopleImage: UIImageView!
    
    @IBOutlet var nameLabel: UILabel!
    @IBOutlet var nameTextField: UITextField!
    
    @IBOutlet var tallLabel: UILabel!
    @IBOutlet var weightLabel: UILabel!
    
    @IBOutlet var tallTextField: UITextField!
    @IBOutlet var weightTextField: UITextField!
    
    @IBOutlet var secureModeButton: UIButton!
    @IBOutlet var randomInputButton: UIButton!
    @IBOutlet var resultButton: UIButton!
    
    //키, 몸무게 범위
    let tallRangeArray = Array(100...250)
    let weightRangeArray = Array(30...200)
    
    //alert에 띄울 결과값
    var finalResult: String = ""
    
    //입력 유효성 검사
    var isTallInput = false
    var isWeightInput = false
    
    //버튼 Secure표시
    var isSecure: Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureUI()
        configureButton()
        
        if let oldName = UserDefaults.standard.string(forKey: InputType.name.type) {
            tallLabel.text = "\(oldName)의 키는 어떻게 되시나요?"
            weightLabel.text = "\(oldName)의 몸무게는 어떻게 되시나요?"
            nameTextField.text = oldName
        }
        
        if let oldTall = UserDefaults.standard.string(forKey: InputType.tall.type),
           let oldWeight = UserDefaults.standard.string(forKey: InputType.weight.type) {
            tallTextField.text = oldTall
            weightTextField.text = oldWeight
            
            checkValidInput(tallTextField)
            checkValidInput(weightTextField)
        }
        
    }
    
    // MARK: - IBAction
    @IBAction func nameTextFieldInput(_ sender: UITextField) {
        guard let name = sender.text else {
            setPresentAlert(title: "이름을 입력해주세요",
                            message: "다시 입력해주세요")
            resetTextField()
            return
        }
        
        UserDefaults.standard.set(name, forKey: InputType.name.type)
    }
    
    @IBAction func tallTextFieldInput(_ sender: UITextField) {
        
        guard let inputInt = checkInput(sender.text) else {
            setPresentAlert(title: "숫자를 입력해주세요",
                            message: "다시 입력해주세요")
            resetTextField()
            return
        }
        
        guard tallRangeArray.contains(inputInt) else {
            let title = "\(tallRangeArray.first ?? 0)cm ~ \(tallRangeArray.last ?? 0)cm 사이의 키를 입력해주세요"
            let message = "다시 입력해주세요"
            
            setPresentAlert(title: title,
                            message: message)
            resetTextField()
            return
        }
    }
    
    @IBAction func weightTextFieldInput(_ sender: UITextField) {

        guard let inputInt = checkInput(sender.text) else {
            setPresentAlert(title: "숫자를 입력해주세요",
                            message: "다시 입력해주세요")
            resetTextField()
            return
        }
        
        guard weightRangeArray.contains(Int(inputInt)) else {
            let title = "\(weightRangeArray.first ?? 0)kg ~ \(weightRangeArray.last ?? 0)kg 사이의 몸무게를 입력해주세요"
            let message = "다시 입력해주세요"
            
            setPresentAlert(title: title,
                            message: message)
            resetTextField()
            return
        }
    }
    
    @IBAction func checkValidInput(_ sender: UITextField) {
        guard
            let input = sender.text,
            !input.isEmpty
        else {
            resultButton.isEnabled = false
            return
        }
        
        //textField 종류 검사
        if sender.tag == 0 {
            isTallInput = true
        } else {
            isWeightInput = true
        }
        
        //둘 다 입력되어있을때 활성화
        if isTallInput && isWeightInput {
            resultButton.isEnabled = true
        } else {
            resultButton.isEnabled = false
        }
    }
    
    @IBAction func randomInputButtonTapped(_ sender: UIButton) throws {
        guard
            let randomTall = tallRangeArray.randomElement(),
            let randomWeight = weightRangeArray.randomElement()
        else {
            setPresentAlert(title: "랜덤 값이 없습니다",
                            message: "다시 입력해주세요")
            return
        }
        
        tallTextField.text = String(randomTall)
        weightTextField.text = String(randomWeight)
        
        //랜덤 입력시도 유효성 체크
        checkValidInput(tallTextField)
        checkValidInput(weightTextField)
    }
    
    @IBAction func resultButtonTapped(_ sender: UIButton) {
        guard
            let tall = tallTextField.text,
            let weight = weightTextField.text,
            let doubleTall = Double(tall),
            let doubleWeight = Double(weight)
        else {
            setPresentAlert(title: "입력이 잘못되었습니다",
                            message: "다시 입력해주세요")
            resetTextField()
            return
        }
        
        //UserDefault저장
        UserDefaults.standard.set(tall, forKey: InputType.tall.type)
        UserDefaults.standard.set(weight, forKey: InputType.weight.type)
        
        let computedTall = doubleTall / 100
        let result = doubleWeight / (computedTall * computedTall)
        let stringResult = getResultString(result)
        
        //결과값
        finalResult = String(format: "%.2f",  result)
        
        if let oldName = UserDefaults.standard.string(forKey: InputType.name.type) {
            setPresentAlert(title: "\(oldName) 님의 BMI는",
                            message: "\(finalResult)\n\(stringResult)입니다")
        } else {
            setPresentAlert(title: "당신의 BMI는",
                            message: "\(finalResult)\n\(stringResult)입니다")
        }
    }
    
    @IBAction func secureModeButtomTapped(_ sender: UIButton) {
        isSecure.toggle()
        weightTextField.isSecureTextEntry.toggle()
        
        if isSecure {
            secureModeButton.setImage(UIImage(systemName: "eye.slash.fill"),
                                      for: .normal)
        } else {
            secureModeButton.setImage(UIImage(systemName: "eye.fill"),
                                      for: .normal)
        }
    }
    
    @IBAction func dismissKeyboard(_ sender: Any) {
        view.endEditing(true)
    }
    
    // MARK: - Helpers
    
    func configureUI() {
        setLabel(titleLabel, title: "BMI Calculator",
                 font: .boldSystemFont(ofSize: 25))
        
        setLabel(subTitleLabel, title: "당신의 BMI지수를\n알려드릴게요.",
                 font: .systemFont(ofSize: 15, weight: .semibold),
                 lines: 2)
        
        setLabel(nameLabel, title: "당신의 닉네임은?",
                 font: .systemFont(ofSize: 15, weight: .semibold))
        
        setLabel(tallLabel, title: "키가 어떻게 되시나요?",
                 font: .systemFont(ofSize: 15, weight: .semibold))
        
        setLabel(weightLabel, title: "몸무게는 어떻게 되시나요?",
                 font: .systemFont(ofSize: 15, weight: .semibold))
        
        setTextField(tallTextField, tag: 0)
        setTextField(weightTextField, tag: 1)
        setTextField(nameTextField, tag: 2, keyboardType: .default, cornerRadius: 15)
        
        peopleImage.image = .image
        peopleImage.contentMode = .scaleAspectFill
    }
    
    func configureButton() {
        resultButton.setTitle("결과 확인", for: .normal)
        resultButton.setTitle("모두 입력해주세요", for: .disabled)
        resultButton.setTitleColor(.white, for: .normal)
        resultButton.setTitleColor(.lightGray, for: .disabled)
        resultButton.backgroundColor = .purple
        resultButton.tintColor = .white
        resultButton.layer.cornerRadius = 15
        resultButton.isEnabled = false
        
        randomInputButton.setTitle("랜덤으로 BMI 계산하기", for: .normal)
        randomInputButton.setTitleColor(.brown, for: .normal)
        
        secureModeButton.setImage(UIImage(systemName: "eye.fill"), for: .normal)
        secureModeButton.tintColor = .black
    }
    
    func setLabel(_ label: UILabel,
                  title: String,
                  font: UIFont = .systemFont(ofSize: 18),
                  lines: Int = 1
    ) {
        label.text = title
        label.font = font
        label.numberOfLines = lines
        label.textAlignment = .left
        label.adjustsFontSizeToFitWidth = .random()
    }
    
    func setTextField(_ textField: UITextField,
                      tag: Int,
                      keyboardType: UIKeyboardType = .numberPad,
                      cornerRadius: CGFloat = 20) {
        textField.tag = tag
        textField.keyboardType = keyboardType
        textField.layer.borderColor = UIColor.darkGray.cgColor
        textField.layer.borderWidth = 2
        textField.layer.cornerRadius = cornerRadius
        textField.clipsToBounds = true
    }
    
    func resetTextField() {
        tallTextField.text = ""
        weightTextField.text = ""
    }
    
    //Alert
    func setPresentAlert(title: String, message: String) {
        let alert = UIAlertController(title: title,
                                      message: message,
                                      preferredStyle: .alert)
        
        let defaultButton = UIAlertAction(title: "확인", style: .default)
        
        alert.addAction(defaultButton)
        
        present(alert, animated: true)
    }
    
    //입력 공통 확인 로직
    func checkInput(_ textfieldInput: String?) -> Int? {
        guard 
            let input = textfieldInput,
            !input.isEmpty
        else {
            setPresentAlert(title: "값을 입력해주세요",
                            message: "다시 입력해주세요")
            return nil
        }
        
        guard
            let intInput = Int(input)
        else {
            setPresentAlert(title: "숫자를 입력해주세요",
                            message: "다시 입력해주세요")
            resetTextField()
            return nil
        }
        
        return intInput
    }
    
    //결과 리턴 로직
    func getResultString(_ input: Double) -> String {
        switch input {
        case 0..<18.5:
            return ResultValue.저체중.name
        case 18.5..<23:
            return ResultValue.정상체중.name
        case 23..<25:
            return ResultValue.과체중.name
        case 25..<30:
            return ResultValue.비만.name
        default:
            return ResultValue.고도비만.name
        }
    }
}

