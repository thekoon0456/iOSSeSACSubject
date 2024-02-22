//
//  LoginViewModel.swift
//  SeSAC_MVVM
//
//  Created by Deokhun KIM on 2/22/24.
//

import Foundation

final class LoginViewModel {
    
    var inputEmailText = Observable<String?>("")
    var inputPasswordText = Observable<String?>("")
    var inputNicknameText = Observable<String?>("")
    var inputPlaceText = Observable<String?>("")
    var inputRecommendCodeText = Observable<String?>("")
    var outputEmailText = Observable<String?>("")
    var outputPasswordText = Observable<String?>("")
    var outputNicknameText = Observable<String?>("")
    var outputPlaceText = Observable<String?>("")
    var outputRecommendCodeText = Observable<String?>("")
    
    init() {
        inputEmailText.bind { [weak self] value in
            guard let self else { return }
            outputEmailText.value = validation(value)
        }
        inputPasswordText.bind { [weak self] value in
            guard let self else { return }
            outputPasswordText.value = validation(value)
        }
        inputNicknameText.bind { [weak self] value in
            guard let self else { return }
            outputNicknameText.value = validation(value)
        }
        inputPlaceText.bind { [weak self] value in
            guard let self else { return }
            outputPlaceText.value = validation(value)
        }
        inputRecommendCodeText.bind { [weak self] value in
            guard let self else { return }
            outputRecommendCodeText.value = validation(value)
        }
    }
    
    private func validation(_ text: String?) -> String? {
        guard let text else { return nil }
        
        if text.isEmpty {
            return "텍스트를 입력해주세요"
        }
        
        if text.count > 10 {
            return "10자 이내로 입력해주세요"
        }
        
        return text
    }
    
    func isCountValidation(_ text: String?) -> Bool {
        guard let input = text,
              input.count < 10
        else { return false }
        
        return true
    }
}
