//
//  CircleConfig.swift
//  SeSAC_TodoProject
//
//  Created by Deokhun KIM on 2/20/24.
//

import UIKit

struct CircleConfig {
    let imageName: String
    let color: UIColor
    
    init(imageName: String = "", color: UIColor = .systemGray) {
        self.imageName = imageName
        self.color = color
    }
}
