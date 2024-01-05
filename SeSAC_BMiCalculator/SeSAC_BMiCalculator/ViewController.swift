//
//  ViewController.swift
//  SeSAC_BMiCalculator
//
//  Created by Deokhun KIM on 1/3/24.
//

import UIKit

final class ViewController: UIViewController {
    
    // MARK: - Properties
    
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
    @IBOutlet var resetButton: UIButton!
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
    var isSecure: Bool = UserDefaults.standard.bool(forKey: "isSecure")
    //기본값 false 반환
    
    // MARK: - Lifecycles
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //UI구성
        configureUI()
        configureButton()
        
        //저장값 load
        loadNameData(input: InputType.name.type)
        loadTallWeightData(tall: InputType.tall.type, weight: InputType.weight.type)
        
    }
    
    // MARK: - IBAction
    
    @IBAction func nameTextFieldInput(_ sender: UITextField) {
        guard
            let name = sender.text,
            !name.isEmpty
        else {
            setTitleLabel(name: nil)
            return
        }
    }
    
    @IBAction func tallTextFieldInput(_ sender: UITextField) {
        guard let inputInt = checkInput(sender.text) else {
            showAlert(input: .notIntInput)
            return
        }
        
        guard tallRangeArray.contains(inputInt) else {
            showAlert(input: .faultTallInput(min: tallRangeArray.first ?? 0,
                                             max: tallRangeArray.last ?? 0))
            return
        }
    }
    
    @IBAction func weightTextFieldInput(_ sender: UITextField) {
        guard let inputInt = checkInput(sender.text) else {
            showAlert(input: .notIntInput)
            return
        }
        
        guard weightRangeArray.contains(Int(inputInt)) else {
            showAlert(input: .faultWeightInput(min: weightRangeArray.first ?? 0,
                                               max: weightRangeArray.last ?? 0))
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
        switch sender.tag {
        case InputType.tall.tag:
            isTallInput = true
        case InputType.weight.tag:
            isWeightInput = true
        default:
            return
        }
        
        //둘 다 입력되어있을때 활성화
        if isTallInput && isWeightInput {
            resultButton.isEnabled = true
        } else {
            resultButton.isEnabled = false
        }
    }
    
    @IBAction func randomInputButtonTapped(_ sender: UIButton) {
        let randomName = ["아이네", "징버거", "릴파", "주르르", "고세구", "비챤"]
        guard
            let randomTall = tallRangeArray.randomElement(),
            let randomWeight = weightRangeArray.randomElement()
        else {
            showAlert(input: .faultInput)
            return
        }
        
        setTextFieldText(name: randomName.randomElement(),
                         tall: String(randomTall),
                         weight: String(randomWeight))
        
        //랜덤 입력시도 유효성 체크
        checkWholeTextFieldInput(tall: tallTextField,
                                 weight: weightTextField)
    }
    
    @IBAction func resetButtonTapped(_ sender: UIButton) {
        
        let keys: [String] = [InputType.name.type,
                              InputType.tall.type,
                              InputType.weight.type]
        
        let textField: [UITextField] = [nameTextField,
                                        tallTextField,
                                        weightTextField]
        
        setPresentAlert(title: "리셋",
                        message: "값을 초기화하시겠습니까?",
                        defaultButton: "취소",
                        customSetting: true,
                        customTitle: "예") { [self] in
            //값 삭제
            keys.forEach { key in
                UserDefaults.standard.removeObject(forKey: key)
            }
            
            //textField 초기화
            textField.forEach { tf in
                tf.text = ""
            }
            
            //alert컨트롤러에서 뷰컨을 참조하는건 맞지만, 뷰컨에 종속되어있는 컨트롤러라서 순환참조는 일어나지 않는다고 생각
            setTitleLabel(name: nil)
            
            checkWholeTextFieldInput(tall: tallTextField,
                                     weight: weightTextField)
        }
    }
    
    @IBAction func resultButtonTapped(_ sender: UIButton) {
        guard
            let name = nameTextField.text,
            let tall = tallTextField.text,
            let weight = weightTextField.text,
            let doubleTall = Double(tall),
            let doubleWeight = Double(weight)
        else {
            showAlert(input: .faultInput)
            return
        }
        
        //UserDefault저장
        UserDefaults.standard.set(name, forKey: InputType.name.type)
        UserDefaults.standard.set(tall, forKey: InputType.tall.type)
        UserDefaults.standard.set(weight, forKey: InputType.weight.type)
        
        //로직 계산
        let computedTall = doubleTall / 100
        let result = doubleWeight / (computedTall * computedTall)
        let stringResult = getResultString(result)
        
        //결과값
        finalResult = String(format: "%.2f",  result)
        
        //label, alert 설정
        guard
            let inputName = UserDefaults.standard.string(forKey: InputType.name.type),
            !inputName.isEmpty
        else {
            setPresentAlert(title: "당신의 BMI는",
                            message: "\(finalResult)\n\(stringResult)입니다")
            setTitleLabel(name: nil)
            return
        }
        
        setPresentAlert(title: "\(inputName) 님의 BMI는",
                        message: "\(finalResult)\n\(stringResult)입니다")
        
        setTitleLabel(name: inputName)
    }
    
    
    @IBAction func secureModeButtomTapped(_ sender: UIButton) {
        isSecure.toggle()
        weightTextField.isSecureTextEntry = isSecure
        
        //설정값 저장
        UserDefaults.standard.set(isSecure, forKey: "isSecure")
        
        //버튼 설정
        setSecureButtonImage(isSecure)
    }
    
    @IBAction func dismissKeyboard(_ sender: Any) {
        view.endEditing(true)
    }
    
    // MARK: - Helpers
    
    func loadNameData(input: String) {
        if let oldName = UserDefaults.standard.string(forKey: input) {
            setTitleLabel(name: oldName)
        }
    }
    
    func loadTallWeightData(tall: String, weight: String) {
        if let oldTall = UserDefaults.standard.string(forKey: tall),
           let oldWeight = UserDefaults.standard.string(forKey: weight) {
            
            setTextFieldText(tall: oldTall, weight: oldWeight)
            
            //유효성 검사
            checkWholeTextFieldInput(tall: tallTextField, weight: weightTextField)
        }
    }
    
    func setTextFieldText(name: String? = nil, tall: String, weight: String) {
        if let name {
            nameTextField.text = name
        }
        tallTextField.text = tall
        weightTextField.text = weight
    }
    
    func setSecureButtonImage(_ isSecure: Bool) {
        if isSecure {
            secureModeButton.setImage(UIImage(systemName: "eye.slash.fill"),
                                      for: .normal)
        } else {
            secureModeButton.setImage(UIImage(systemName: "eye.fill"),
                                      for: .normal)
        }
    }
    
    //TextField 입력 공통 확인 로직
    func checkInput(_ textfieldInput: String?) -> Int? {
        //값이 비어있는지
        guard
            let input = textfieldInput,
            !input.isEmpty
        else {
            showAlert(input: .emptyInput)
            return nil
        }
        
        //값이 숫자인지
        guard let intInput = Int(input) else {
            showAlert(input: .notIntInput)
            return nil
        }
        
        return intInput
    }
    
    //tall, weight 유효성 검사
    func checkWholeTextFieldInput(tall: UITextField, weight: UITextField) {
        checkValidInput(tallTextField)
        checkValidInput(weightTextField)
    }
    
    //결과 리턴 로직
    func getResultString(_ input: Double) -> String {
        switch input {
        case 0..<18.5:
            return ResultValue.underweight.name
        case 18.5..<23:
            return ResultValue.normalweight.name
        case 23..<25:
            return ResultValue.overweight.name
        case 25..<30:
            return ResultValue.obesity.name
        default:
            return ResultValue.severeObesity.name
        }
    }
}

// MARK: - Logic

extension ViewController {
    func showAlert(input: InputError) {
        switch input {
        case .emptyName:
            setPresentAlert(title: "닉네임을 입력해주세요")
        case .emptyInput:
            setPresentAlert(title: "값을 입력해주세요")
        case .faultInput:
            setPresentAlert(title: "입력이 잘못되었습니다")
        case .faultTallInput(min: let min, max: let max):
            setPresentAlert(title: "\(min)kg ~ \(max)cm 사이의 키를 입력해주세요")
        case .faultWeightInput(min: let min, max: let max):
            setPresentAlert(title: "\(min)kg ~ \(max)kg 사이의 몸무게를 입력해주세요")
        case .notIntInput:
            setPresentAlert(title: "숫자를 입력해주세요")
        }
        
        //textField 초기화
        resetTextField()
    }
}

// MARK: - UI

extension ViewController {
    func configureUI() {
        //label 설정
        setLabel(titleLabel, title: "BMI Calculator",
                 font: .boldSystemFont(ofSize: 25))
        
        setLabel(subTitleLabel, title: "당신의 BMI지수를\n알려드릴게요.",
                 font: .systemFont(ofSize: 15, weight: .semibold),
                 lines: 2)
        
        setLabel(nameLabel,
                 font: .systemFont(ofSize: 15, weight: .semibold))
        
        setLabel(tallLabel,
                 font: .systemFont(ofSize: 15, weight: .semibold))
        
        setLabel(weightLabel,
                 font: .systemFont(ofSize: 15, weight: .semibold))
        
        setTitleLabel(name: UserDefaults.standard.string(forKey: InputType.name.type))
        
        //textfield 설정
        setTextField(tallTextField, tag: 0)
        setTextField(weightTextField, tag: 1)
        setTextField(nameTextField, tag: 2, keyboardType: .default, cornerRadius: 15)
        //secure 설정 로드
        weightTextField.isSecureTextEntry = isSecure
        
        //image 설정
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
        
        setSecureButtonImage(isSecure)
        secureModeButton.tintColor = .black
        
        resetButton.setTitle("reset", for: .normal)
        resetButton.setTitleColor(.red, for: .normal)
    }
    
    func setLabel(_ label: UILabel,
                  title: String? = nil,
                  font: UIFont = .systemFont(ofSize: 18),
                  lines: Int = 1) {
        label.text = title
        label.font = font
        label.numberOfLines = lines
        label.textAlignment = .left
        label.adjustsFontSizeToFitWidth = .random()
    }
    
    //label 멘트 설정
    func setTitleLabel(name: String?) {
        guard
            let name,
            name != ""
        else {
            nameLabel.text = TitleLabel.name(name: "").defaultTitle
            tallLabel.text = TitleLabel.tall(name: "").defaultTitle
            weightLabel.text = TitleLabel.weight(name: "").defaultTitle
            return
        }
        
        nameTextField.text = name
        nameLabel.text = TitleLabel.name(name: name).setTitle
        tallLabel.text = TitleLabel.tall(name: name).setTitle
        weightLabel.text = TitleLabel.weight(name: name).setTitle
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
    
    //Alert 설정, present
    func setPresentAlert(title: String,
                         message: String = "다시 입력해주세요",
                         defaultButton: String = "확인",
                         customSetting: Bool = false,
                         customTitle: String? = nil,
                         customAction: (() -> ())? = nil) {
        //기본 설정
        let alert = CustomAlert(title: title,
                                      message: message,
                                      preferredStyle: .alert)
        
        let defaultButton = UIAlertAction(title: defaultButton, style: .cancel)
        alert.addAction(defaultButton)
        
        //customSetting true로 추가 설정시 title, 액션 전달
        if customSetting {
            let customButton = UIAlertAction(title: customTitle,
                                             style: .default) { action in
                customAction?()
            }
            
            alert.addAction(customButton)
        }
        
        present(alert, animated: true)
    }
}

//TextField 입력 타입

extension ViewController {
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
        
        var tag: Int {
            switch self {
            case .tall:
                return 0
            case .weight:
                return 1
            case .name:
                return 2
            }
        }
    }
}

//잭님..error 타입처리하는건..어떻게 구현해야 할 지 잘 모르겠습니다...도움이 필요합니다..
extension ViewController {
    enum InputError: Error {
        case emptyName
        case emptyInput
        case notIntInput
        case faultInput
        case faultTallInput(min: Int, max: Int)
        case faultWeightInput(min: Int, max: Int)
    }
}

//체중
extension ViewController {
    enum ResultValue {
        case underweight
        case normalweight
        case overweight
        case obesity
        case severeObesity
        
        var name: String {
            switch self {
            case .underweight:
                return "저체중"
            case .normalweight:
                return "정상 체중"
            case .overweight:
                return "과체중"
            case .obesity:
                return "비만"
            case .severeObesity:
                return "고도비만"
            }
        }
    }
}

//titleLabel 설정
extension ViewController {
    enum TitleLabel {
        case name(name: String)
        case tall(name: String)
        case weight(name: String)
        
        //nickname 없을때 title
        var defaultTitle: String {
            switch self {
            case .name:
                return "당신의 닉네임은?"
            case .tall:
                return "당신의 키는 어떻게 되시나요?"
            case .weight:
                return "당신의 몸무게는 어떻게 되시나요?"
            }
        }
        
        //nickname 설정 시 타이틀
        var setTitle: String {
            switch self {
            case .name(name: let name):
                return "\(name)님 안녕하세요."
            case .tall(name: let name):
                return "\(name)님의 키는 어떻게 되시나요?"
            case .weight(name: let name):
                return "\(name)님의 몸무게는 어떻게 되시나요?"
            }
        }
    }
}

// MARK: - alert컨트롤러 해제 test

class CustomAlert: UIAlertController {
    
    deinit {
        print("\(self) 해제")
    }
}
