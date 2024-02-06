//
//  ThrottleManager.swift
//  SeSAC_MediaProject
//
//  Created by Deokhun KIM on 2/5/24.
//

import UIKit

final class Throttler {
    
    private var timer: Timer?
    
    deinit {
        timer?.invalidate()
        print("deinit됨, \(String(describing: timer))")
    }

    func execute(timeInterval: TimeInterval, completion: @escaping (() -> Void)) {
        //타이머 동작중이면 무시
        guard timer == nil else { return }

        timer = Timer.scheduledTimer(withTimeInterval: timeInterval, repeats: false) { [weak self] _ in
            guard let self else { return }
            completion()
            
            // 타이머 초기화
            timer?.invalidate()
            timer = nil
        }
    }
}
