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
    //TODO: - 설정값 저장
    var isSecure: Bool = false
    
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
    
    func loadNameData(input: String) {
        if let oldName = UserDefaults.standard.string(forKey: input) {
            setTitleLabel(name: oldName)
//            tallLabel.text = TitleLabel.tall(name: oldName).setTitle
//            weightLabel.text = TitleLabel.weight(name: oldName).setTitle
            nameTextField.text = oldName
        }
    }
    
    func loadTallWeightData(tall: String, weight: String) {
        if let oldTall = UserDefaults.standard.string(forKey: tall),
           let oldWeight = UserDefaults.standard.string(forKey: weight) {
            tallTextField.text = oldTall
            weightTextField.text = oldWeight
            
            //유효성 검사
            checkValidInput(tallTextField)
            checkValidInput(weightTextField)
        }
    }
    
    // MARK: - IBAction
    
    @IBAction func nameTextFieldInput(_ sender: UITextField) {
        guard let name = sender.text else {
            setPresentAlert(title: "이름을 입력해주세요")
            resetTextField()
            return
        }
        
        UserDefaults.standard.set(name, forKey: InputType.name.type)
    }
    
    @IBAction func tallTextFieldInput(_ sender: UITextField) {
        
        guard let inputInt = checkInput(sender.text) else {
            setPresentAlert(title: "숫자를 입력해주세요")
            resetTextField()
            return
        }
        
        guard tallRangeArray.contains(inputInt) else {
            let title = "\(tallRangeArray.first ?? 0)cm ~ \(tallRangeArray.last ?? 0)cm 사이의 키를 입력해주세요"
            
            setPresentAlert(title: title)
            resetTextField()
            return
        }
    }
    
    @IBAction func weightTextFieldInput(_ sender: UITextField) {
        
        guard let inputInt = checkInput(sender.text) else {
            setPresentAlert(title: "숫자를 입력해주세요")
            resetTextField()
            return
        }
        
        guard weightRangeArray.contains(Int(inputInt)) else {
            let title = "\(weightRangeArray.first ?? 0)kg ~ \(weightRangeArray.last ?? 0)kg 사이의 몸무게를 입력해주세요"
            
            setPresentAlert(title: title)
            resetTextField()
            return
        }
    }
    
    //TODO: -중복호출 정리
    
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
            setPresentAlert(title: "랜덤 값이 없습니다")
            return
        }
        
        tallTextField.text = String(randomTall)
        weightTextField.text = String(randomWeight)
        
        //랜덤 입력시도 유효성 체크
        checkValidInput(tallTextField)
        checkValidInput(weightTextField)
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
                        customTitle: "예") {
            //값 삭제
            keys.forEach { key in
                UserDefaults.standard.removeObject(forKey: key)
            }
            
            //textField 초기화
            textField.forEach { tf in
                tf.text = ""
            }
            
            self.setTitleLabel(name: nil)
            
            self.checkValidInput(self.tallTextField)
            self.checkValidInput(self.weightTextField)
        }
    }
    
    @IBAction func resultButtonTapped(_ sender: UIButton) {
        guard
            let tall = tallTextField.text,
            let weight = weightTextField.text,
            let doubleTall = Double(tall),
            let doubleWeight = Double(weight)
        else {
            setPresentAlert(title: "입력이 잘못되었습니다")
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
            setTitleLabel(name: oldName)
        }
        
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
    
    //입력 공통 확인 로직
    func checkInput(_ textfieldInput: String?) -> Int? {
        //값이 비어있는지
        guard
            let input = textfieldInput,
            !input.isEmpty
        else {
            setPresentAlert(title: "값을 입력해주세요")
            return nil
        }
        
        //값이 숫자인지
        guard
            let intInput = Int(input)
        else {
            setPresentAlert(title: "숫자를 입력해주세요")
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

// MARK: - Logic

extension ViewController {
    
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
        
        setLabel(nameLabel, title: TitleLabel.name(name: "").defaultTitle,
                 font: .systemFont(ofSize: 15, weight: .semibold))
        
        setLabel(tallLabel, title: TitleLabel.tall(name: "").defaultTitle,
                 font: .systemFont(ofSize: 15, weight: .semibold))
        
        setLabel(weightLabel, title: TitleLabel.weight(name: "").defaultTitle,
                 font: .systemFont(ofSize: 15, weight: .semibold))
        
        //textfield 설정
        setTextField(tallTextField, tag: 0)
        setTextField(weightTextField, tag: 1)
        setTextField(nameTextField, tag: 2, keyboardType: .default, cornerRadius: 15)
        
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
        
        secureModeButton.setImage(UIImage(systemName: "eye.fill"), for: .normal)
        secureModeButton.tintColor = .black
        
        resetButton.setTitle("reset", for: .normal)
        resetButton.setTitleColor(.red, for: .normal)
    }
    
    func setLabel(_ label: UILabel,
                  title: String,
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
        //이름 있으면 이름 설정
        if let name {
            nameLabel.text = TitleLabel.name(name: name).setTitle
            tallLabel.text = TitleLabel.tall(name: name).setTitle
            weightLabel.text = TitleLabel.weight(name: name).setTitle
        } else {
            //이름 없으면 기본 label 설정
            nameLabel.text = TitleLabel.name(name: "").defaultTitle
            tallLabel.text = TitleLabel.tall(name: "").defaultTitle
            weightLabel.text = TitleLabel.weight(name: "").defaultTitle
        }
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
        let alert = UIAlertController(title: title,
                                      message: message,
                                      preferredStyle: .alert)
        
        let defaultButton = UIAlertAction(title: defaultButton, style: .cancel)
        alert.addAction(defaultButton)
        
        //추가 설정시 title, 액션 전달
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
    }
}

//error 타입
extension ViewController {
    enum InputError: Error {
        case emptyInput
        case notIntInput
        case faultInput
        case faultTallInput(min: Int, max: Int)
        case faultWeightInput(min: Int, max: Int)
        
        var description: String {
            switch self {
            case .emptyInput:
                return "값을 입력해주세요"
            case .faultInput:
                return "입력이 잘못되었습니다"
            case .faultTallInput(min: let min, max: let max):
                return "\(min)kg ~ \(max)cm 사이의 키를 입력해주세요"
            case .faultWeightInput(min: let min, max: let max):
                return "\(min)kg ~ \(max)kg 사이의 몸무게를 입력해주세요"
            case .notIntInput:
                return "숫자를 입력해주세요"
            }
        }
    }
}

//체중
extension ViewController {
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
                return "\(name)의 키는 어떻게 되시나요?"
            case .weight(name: let name):
                return "\(name)의 몸무게는 어떻게 되시나요?"
            }
        }
    }
}
