//
//  DramaEpisode.swift
//  SeSAC_MediaProject
//
//  Created by Deokhun KIM on 1/31/24.
//

import Foundation

struct DramaDetail: Decodable {
    let id: Int
    let name: String
    let overview: String
    let backdropPath: String
    let genres: [Genre]
    let lastAirDate: String
    let numberOfEpisodes: Int
    let numberOfSeasons: Int
    let popularity: Double
    let posterPath: String?
    let seasons: [Season]
    let voteAverage: Double
    
    enum CodingKeys: String, CodingKey {
        case id
        case name
        case overview
        case backdropPath = "backdrop_path"
        case genres
        case lastAirDate = "last_air_date"
        case numberOfEpisodes = "number_of_episodes"
        case numberOfSeasons = "number_of_seasons"
        case popularity
        case posterPath = "poster_path"
        case seasons
        case voteAverage = "vote_average"
    }
}

struct Genre: Decodable {
    let id: Int
    let name: String
}

struct LastEpisodeToAir: Decodable {
    let id: Int
    let name: String
    let overview: String
    let voteAverage: Double
    let airDate: String
    let episodeNumber: Int
    let seasonNumber: Int
    let stillPath: String

    enum CodingKeys: String, CodingKey {
        case id
        case name
        case overview
        case voteAverage = "vote_average"
        case airDate = "air_date"
        case episodeNumber = "episode_number"
        case seasonNumber = "season_number"
        case stillPath = "still_path"
    }
}

// MARK: - Season
struct Season: Codable {
    let airDate: String?
    let episodeCount, id: Int
    let name, overview: String
    let posterPath: String?
    let seasonNumber: Int
    let voteAverage: Double

    enum CodingKeys: String, CodingKey {
        case airDate = "air_date"
        case episodeCount = "episode_count"
        case id, name, overview
        case posterPath = "poster_path"
        case seasonNumber = "season_number"
        case voteAverage = "vote_average"
    }
}
