//
//  TMDBAPIManager.swift
//  SeSAC_MediaProject
//
//  Created by Deokhun KIM on 1/30/24.
//

import Foundation

import Alamofire

enum Endpoint: String {
    case trend = "trending/tv/day?language=ko-KR"
    case toprated = "/top_rated?language=ko-KR&page=1"
    case popular = "tv/popular?language=ko-KR&page=1"
}

final class TMDBAPIManager {
    
    static let shared = TMDBAPIManager()
    
    let baseURL = "https://api.themoviedb.org/3/"
    
    private let headers: HTTPHeaders = [
        "Authorization": "Bearer eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiIxNTJhNGZjYWM1NTFlNjRhYTA3MjBlZDUwM2UxNzBkYSIsInN1YiI6IjY0ZjE3NzRkZTBjYTdmMDEyZWIyYzg5ZCIsInNjb3BlcyI6WyJhcGlfcmVhZCJdLCJ2ZXJzaW9uIjoxfQ.j7badxgR21sbDqDxcvHhki_0BMB5x4vqoyMUYi943tQ"
    ]
    
    private init() { }
    
    func fetchTVTrend(completion: @escaping (([TVTrend]) -> Void)) {
        let url = baseURL + Endpoint.trend.rawValue
        
        AF.request(url, headers: headers)
            .validate(statusCode: 200...299)
            .responseDecodable(of: TVTrendModel.self) { response in
                switch response.result {
                case .success(let success):
                    completion(success.results)
                case .failure(let failure):
                    print(failure.localizedDescription)
                }
        }
    }
    
    func fetchTVTopRated(completion: @escaping (([TVTopRated]) -> Void)) {
        let url = baseURL + Endpoint.trend.rawValue
        
        AF.request(url, headers: headers)
            .validate(statusCode: 200...299)
            .responseDecodable(of: TVTopRatedModel.self) { response in
                switch response.result {
                case .success(let success):
                    completion(success.results)
                case .failure(let failure):
                    print(failure.localizedDescription)
                }
        }
    }
    
    func fetchTVPopular(completion: @escaping (([TVPopular]) -> Void)) {
        let url = baseURL + Endpoint.trend.rawValue
        
        AF.request(url, headers: headers)
            .validate(statusCode: 200...299)
            .responseDecodable(of: TVPopularModel.self) { response in
                switch response.result {
                case .success(let success):
                    completion(success.results)
                case .failure(let failure):
                    print(failure.localizedDescription)
                }
        }
    }
}
