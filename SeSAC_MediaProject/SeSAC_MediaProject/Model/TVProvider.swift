//
//  TVProvider.swift
//  SeSAC_MediaProject
//
//  Created by Deokhun KIM on 2/6/24.
//

import Foundation

struct TVProvider: Decodable {
    let id: Int
    let results: TVProviderResults?
}

struct TVProviderResults: Decodable {
    let kr: Country?
    let us: Country?
    
    enum CodingKeys: String, CodingKey {
        case kr = "KR"
        case us = "US"
    }
}

struct Country: Decodable {
    let link: String?
}
