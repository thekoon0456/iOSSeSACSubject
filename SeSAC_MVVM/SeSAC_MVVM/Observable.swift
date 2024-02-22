//
//  Observable.swift
//  SeSAC_MVVM
//
//  Created by Deokhun KIM on 2/22/24.
//

import Foundation

final class Observable<T> {
    
    typealias Listener = ((T) -> Void)?
    
    var value: T {
        didSet {
            listener?(value)
        }
    }
    
    private var listener: Listener
    
    init(_ value: T) {
        self.value = value
        self.listener = nil
    }
    
    func bind(_ listener: Listener) {
        self.listener?(value)
        self.listener = listener
    }
}
