//
//  YoutubeLink.swift
//  SeSAC_MediaProject
//
//  Created by Deokhun KIM on 2/6/24.
//

import Foundation

struct YoutubeLink: Codable {
    let id: Int
    let results: [YoutubeLinkResults]
}

// MARK: - Result
struct YoutubeLinkResults: Codable {
    let iso639_1, iso3166_1, name: String
    let key: String
    let site: String
    let size: Int
    let type: String
    let official: Bool
    let publishedAt, id: String

    enum CodingKeys: String, CodingKey {
        case iso639_1 = "iso_639_1"
        case iso3166_1 = "iso_3166_1"
        case name, key, site, size, type, official
        case publishedAt = "published_at"
        case id
    }
}
