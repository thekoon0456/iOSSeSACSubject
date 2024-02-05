//
//  TMDBURLSessionManager.swift
//  SeSAC_MediaProject
//
//  Created by Deokhun KIM on 2/5/24.
//

import Foundation

enum TMDBError: Error {
    case networkError
    case responseError
    case dataError
    case parseError
    
}

final class TMDBURLSessionManager {
    
    static let shared = TMDBURLSessionManager()
    
    private init() { }

    func fetchURLSessionData<T: Decodable>(api: TMDBAPIRouter, type: T.Type = T.self, completion: @escaping ((Result<T, TMDBError>) -> Void)) {
        //url
        guard var urlComponents = URLComponents(string: api.endPoint) else { return }
        //쿼리 추가
        let quaryItemArr = api.parameters.map { URLQueryItem(name: $0.key, value: $0.value) }
        urlComponents.queryItems = quaryItemArr
        
        guard let url = urlComponents.url else { return }
        
        //header 추가
        var request = URLRequest(url: url)
        request.allHTTPHeaderFields = api.headers
        request.httpMethod = api.method
        
        URLSession.shared.dataTask(with: request) { data, reponse, error in
            
            if let error {
                completion(.failure(.networkError))
                return
            }
            
            guard let reponse else {
                completion(.failure(.responseError))
                return
            }
            
            guard let data else {
                completion(.failure(.dataError))
                return
            }
            
            do {
                let result = try JSONDecoder().decode(T.self, from: data)
                completion(.success(result))
            } catch {
                completion(.failure(.parseError))
            }
        }.resume()
    }
    
}
