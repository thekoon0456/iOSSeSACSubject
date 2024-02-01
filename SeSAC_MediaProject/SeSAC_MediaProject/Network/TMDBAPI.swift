//
//  TMDBAPI.swift
//  SeSAC_MediaProject
//
//  Created by Deokhun KIM on 2/1/24.
//

import Alamofire

//enum Endpoint: String, CaseIterable {
//    case trend = "trending/tv/day?language=ko-KR"
//    case toprated = "tv/top_rated?language=ko-KR&page=12"
//    case popular = "tv/popular?language=ko-KR&page=12"
//}
//
//enum DramaEndpoint: String, CaseIterable { //만달로리안
//    case tvSeriesDetails = "tv/82856?language=ko-KR"
//    case aggregateCredits = "tv/82856/aggregate_credits?language=ko-KR&page=1"
//    case recommendations = "tv/82856/recommendations?language=ko-KR&page=1"
//}

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
        }
    }
    
    var baseURL: String {
        "https://api.themoviedb.org/3/"
    }
    
    var headers: HTTPHeaders {
        ["Authorization": "Bearer eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiIxNTJhNGZjYWM1NTFlNjRhYTA3MjBlZDUwM2UxNzBkYSIsInN1YiI6IjY0ZjE3NzRkZTBjYTdmMDEyZWIyYzg5ZCIsInNjb3BlcyI6WyJhcGlfcmVhZCJdLCJ2ZXJzaW9uIjoxfQ.j7badxgR21sbDqDxcvHhki_0BMB5x4vqoyMUYi943tQ"]
    }
    
    var method: HTTPMethod {
        switch self {
        case .trend, .toprated, .popular, .tvSeriesDetails, .aggregateCredits, .recommendations:
            return .get
        }
    }
    
    var parameters: Parameters {
        switch self {
        case .trend:
            ["language": "ko-KR"]
        case .toprated(let page):
            ["language": "ko-KR",
             "page": "\(page)"]
        case .popular(let page):
            ["language": "ko-KR",
             "page": "\(page)"]
        case .tvSeriesDetails:
            ["language": "ko-KR"]
        case .aggregateCredits(_, let page):
            ["language": "ko-KR",
             "page": "\(page)"]
        case .recommendations(_, let page):
            ["language": "ko-KR",
             "page": "\(page)"]
        }
    }
}
