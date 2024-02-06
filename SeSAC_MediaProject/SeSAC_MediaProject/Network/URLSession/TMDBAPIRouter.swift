//
//  TMDBAPIRouter.swift
//  SeSAC_MediaProject
//
//  Created by Deokhun KIM on 2/5/24.
//

import Foundation

enum TMDBAPIRouter {
    
    enum TrendSort: String {
        case day
        case week
    }
    
    case trend(sort: TrendSort.RawValue)
    case toprated(page: Int)
    case popular(page: Int)
    case tvSeriesDetails(id: Int)
    case aggregateCredits(id: Int, page: Int)
    case recommendations(id: Int, page: Int)
    case search(text: String, page: Int)
    case provider(id: Int)
    case youtubeLink(id: Int, season: Int = 1)
    
    var endPoint: String {
        switch self {
        case .trend(let sort):
            baseURL + "trending/tv/\(sort)"
        case .toprated:
            baseURL + "tv/top_rated?language=ko-KR&page=1"
        case .popular:
            baseURL + "tv/popular?language=ko-KR&page=1"
        case .tvSeriesDetails(let id):
            baseURL + "tv/\(id)"
        case .aggregateCredits(let id, _):
            baseURL + "tv/\(id)/aggregate_credits"
        case .recommendations(let id, _):
            baseURL + "tv/\(id)/recommendations"
        case .search:
            baseURL + "search/tv"
        case .provider(let id):
            baseURL + "tv/\(id)/watch/providers"
        case .youtubeLink(let id, let season):
            baseURL + "tv/\(id)/season/\(season)/videos"
        }
    }
    
    private var baseURL: String {
        "https://api.themoviedb.org/3/"
    }
    
    var headers: [String: String] {
        ["Authorization": "Bearer eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiIxNTJhNGZjYWM1NTFlNjRhYTA3MjBlZDUwM2UxNzBkYSIsInN1YiI6IjY0ZjE3NzRkZTBjYTdmMDEyZWIyYzg5ZCIsInNjb3BlcyI6WyJhcGlfcmVhZCJdLCJ2ZXJzaW9uIjoxfQ.j7badxgR21sbDqDxcvHhki_0BMB5x4vqoyMUYi943tQ"]
    }
    
    var method: String {
        switch self {
        case .trend, .toprated, .popular, .tvSeriesDetails, .aggregateCredits, .recommendations, .search, .provider, .youtubeLink:
            "GET"
        }
    }
    
    var parameters: [String: String] {
        switch self {
        case .trend, .tvSeriesDetails:
            ["language": "ko-KR"]
        case .toprated(let page), .popular(let page):
            ["language": "ko-KR",
             "page": "\(page)"]
        case .aggregateCredits(_, let page), .recommendations(_, let page):
            ["language": "ko-KR",
             "page": "\(page)"]
        case .search(text: let text, let page):
            ["query": text,
             "language": "ko-KR",
             "page": "\(page)"]
        case .provider, .youtubeLink:
            [:]
        }
    }
}
