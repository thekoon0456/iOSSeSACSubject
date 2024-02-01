//
//  TVTrend.swift
//  SeSAC_MediaProject
//
//  Created by Deokhun KIM on 1/30/24.
//

import Foundation

struct TV: Decodable {
    let page: Int
    let results: [TVModel]
    let totalPages, totalResults: Int

    enum CodingKeys: String, CodingKey {
        case page, results
        case totalPages = "total_pages"
        case totalResults = "total_results"
    }
}

struct TVModel: Decodable {
    let backdropPath: String?
    let genreIDS: [Int]
    let id: Int
    let originalName, overview: String
    let popularity: Double
    let posterPath: String?
    let firstAirDate: String
    let name: String
    let voteAverage: Double
    let voteCount: Int

    enum CodingKeys: String, CodingKey {
        case backdropPath = "backdrop_path"
        case genreIDS = "genre_ids"
        case id
        case originalName = "original_name"
        case overview, popularity
        case posterPath = "poster_path"
        case firstAirDate = "first_air_date"
        case name
        case voteAverage = "vote_average"
        case voteCount = "vote_count"
    }
}
