//
//  TVTopRated.swift
//  SeSAC_MediaProject
//
//  Created by Deokhun KIM on 1/30/24.
//

import Foundation

struct TVTopRatedModel: Decodable {
    let page: Int
    let results: [TVTopRated]
    let totalPages, totalResults: Int

    enum CodingKeys: String, CodingKey {
        case page, results
        case totalPages = "total_pages"
        case totalResults = "total_results"
    }
}

// MARK: - Result
struct TVTopRated: Decodable {
    let adult: Bool
    let backdropPath: String
    let genreIDS: [Int]
    let id: Int
    let originCountry: [String]
    let originalLanguage: OriginalLanguage
    let originalName, overview: String
    let popularity: Double
    let posterPath, firstAirDate, name: String
    let voteAverage: Double
    let voteCount: Int

    enum CodingKeys: String, CodingKey {
        case adult
        case backdropPath = "backdrop_path"
        case genreIDS = "genre_ids"
        case id
        case originCountry = "origin_country"
        case originalLanguage = "original_language"
        case originalName = "original_name"
        case overview, popularity
        case posterPath = "poster_path"
        case firstAirDate = "first_air_date"
        case name
        case voteAverage = "vote_average"
        case voteCount = "vote_count"
    }
}

enum OriginalLanguage: String, Codable {
    case ca = "ca"
    case en = "en"
    case ja = "ja"
    case ko = "ko"
}
