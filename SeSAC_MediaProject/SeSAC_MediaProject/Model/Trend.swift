//
//  Model.swift
//  SeSAC_MediaProject
//
//  Created by Deokhun KIM on 1/25/24.
//

import Foundation

//https://developers.themoviedb.org/3/trending/get-trending

struct Movie: Codable {
    let page: Int
    let results: [Trend]
    let totalPages, totalResults: Int

    enum CodingKeys: String, CodingKey {
        case page, results
        case totalPages = "total_pages"
        case totalResults = "total_results"
    }
}

struct Trend: Model, Codable {
    let id: Int
    let title: String
    let overview: String
    let genreIDS: [Int]
    let voteAverage: Double
    let releaseDate: String
    let posterPath: String
    
    enum CodingKeys: String, CodingKey {
        case id
        case title
        case overview
        case genreIDS = "genre_ids"
        case voteAverage = "vote_average"
        case releaseDate = "release_date"
        case posterPath = "poster_path"
    }
}
