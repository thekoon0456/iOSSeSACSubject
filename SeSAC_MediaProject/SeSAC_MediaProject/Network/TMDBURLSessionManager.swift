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
    
    var title: String {
        switch self {
        case .networkError:
            "네트워크 에러"
        case .responseError:
            "응답 에러"
        case .dataError:
            "데이터 에러"
        case .parseError:
            "파싱 에러"
        }
    }
    
    var description: String {
        switch self {
        case .networkError:
            "네트워크 에러입니다. 재시도해주세요."
        case .responseError:
            "서버 응답 에러입니다. 재시도해주세요."
        case .dataError:
            "데이터 에러입니다. 재시도해주세요."
        case .parseError:
            "파싱 에러입니다. 재시도해주세요."
        }
    }
}

final class TMDBURLSessionManager {
    
    static let shared = TMDBURLSessionManager()
    
    private init() { }

    func fetchURLSessionData<T: Decodable>(api: TMDBAPIRouter, type: T.Type = T.self, completion: @escaping ((Result<T, TMDBError>) -> Void)) {
        //urlComponents 생성
        guard var urlComponents = URLComponents(string: api.endPoint) else { return }
        //쿼리 추가
        let quaryItemArr = api.parameters.map { URLQueryItem(name: $0.key, value: $0.value) }
        urlComponents.queryItems = quaryItemArr
        
        guard let url = urlComponents.url else { return }
        //header, method 추가
        var request = URLRequest(url: url)
        request.allHTTPHeaderFields = api.headers
        request.httpMethod = api.method
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            
            if let error {
                print(error)
                completion(.failure(.networkError))
                return
            }
            
            guard let response = response as? HTTPURLResponse else {
                completion(.failure(.responseError))
                return
            }
            
            guard response.statusCode == 200 else {
                completion(.failure(.dataError))
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
