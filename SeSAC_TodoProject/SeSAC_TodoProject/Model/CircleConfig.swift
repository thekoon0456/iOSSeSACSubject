//
//  CircleConfig.swift
//  SeSAC_TodoProject
//
//  Created by Deokhun KIM on 2/20/24.
//

import UIKit

struct CircleConfig {
    var imageName: String
    var colorName: String
    
    init(imageName: String = "", colorName: String = "systemGray") {
        self.imageName = imageName
        self.colorName = colorName
    }
}
