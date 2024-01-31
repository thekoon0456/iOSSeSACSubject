//
//  DramaCast.swift
//  SeSAC_MediaProject
//
//  Created by Deokhun KIM on 1/31/24.
//

import Foundation

struct DramaCast: Decodable {
    let cast: [CastModel]
}

// MARK: - Cast
struct CastModel: Decodable, Model {
    let id: Int
    let name: String
    let knownForDepartment: String
    let popularity: Double
    let posterPath: String?
    let roles: [Role]

    enum CodingKeys: String, CodingKey {
        case id
        case name
        case knownForDepartment = "known_for_department"
        case popularity
        case posterPath = "profile_path"
        case roles
    }
}

// MARK: - Role
struct Role: Decodable {
    let creditID: String
    let character: String
    let episodeCount: Int

    enum CodingKeys: String, CodingKey {
        case creditID = "credit_id"
        case character
        case episodeCount = "episode_count"
    }
}
