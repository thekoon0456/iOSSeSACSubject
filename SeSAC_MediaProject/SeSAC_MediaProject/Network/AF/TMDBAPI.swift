//
//  TMDBAPI.swift
//  SeSAC_MediaProject
//
//  Created by Deokhun KIM on 2/1/24.
//

import Foundation

import Alamofire

// MARK: - urlcomponents: https://developer.apple.com/documentation/foundation/urlcomponents

enum TMDBAPI {
    
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
    
    var endPoint: URL {
        switch self {
        case .trend(let sort):
            URL(string: baseURL + "trending/tv/\(sort)") ?? URL(string: baseURL)!
        case .toprated:
            URL(string: baseURL + "tv/top_rated?language=ko-KR&page=1") ?? URL(string: baseURL)!
        case .popular:
            URL(string: baseURL + "tv/popular?language=ko-KR&page=1") ?? URL(string: baseURL)!
        case .tvSeriesDetails(let id):
            URL(string: baseURL + "tv/\(id)") ?? URL(string: baseURL)!
        case .aggregateCredits(let id, _):
            URL(string: baseURL + "tv/\(id)/aggregate_credits") ?? URL(string: baseURL)!
        case .recommendations(let id, _):
            URL(string: baseURL + "tv/\(id)/recommendations") ?? URL(string: baseURL)!
        case .search:
            URL(string: baseURL + "search/tv") ?? URL(string: baseURL)!
        }
    }
    
    private var baseURL: String {
        "https://api.themoviedb.org/3/"
    }
    
    var headers: HTTPHeaders {
        ["Authorization": "Bearer eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiIxNTJhNGZjYWM1NTFlNjRhYTA3MjBlZDUwM2UxNzBkYSIsInN1YiI6IjY0ZjE3NzRkZTBjYTdmMDEyZWIyYzg5ZCIsInNjb3BlcyI6WyJhcGlfcmVhZCJdLCJ2ZXJzaW9uIjoxfQ.j7badxgR21sbDqDxcvHhki_0BMB5x4vqoyMUYi943tQ"]
    }
    
    var method: HTTPMethod {
        switch self {
        case .trend, .toprated, .popular, .tvSeriesDetails, .aggregateCredits, .recommendations, .search:
            return .get
        }
    }
    
    var parameters: Parameters {
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
        }
    }
}
