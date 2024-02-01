//
//  TMDBAPIManager.swift
//  SeSAC_MediaProject
//
//  Created by Deokhun KIM on 1/30/24.
//

import Foundation

import Alamofire

final class TMDBAPIManager {
    
    static let shared = TMDBAPIManager()
    
    private init() { }
    
    func fetchData<T: Decodable>(api: TMDBAPI, type: T.Type = T.self, completion: @escaping ((T) -> Void)) {
        AF.request(api.endPoint,
                   method: api.method,
                   parameters: api.parameters,
                   headers: api.headers)
            .validate(statusCode: 200...299)
            .responseDecodable(of: T.self) { response in
                switch response.result {
                case .success(let success):
                    completion(success)
                case .failure(let failure):
                    print(failure.localizedDescription)
                }
        }
    }
}
