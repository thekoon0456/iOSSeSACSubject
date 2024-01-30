//
//  APIManager.swift
//  SeSAC_MediaProject
//
//  Created by Deokhun KIM on 1/25/24.
//

//import Foundation
//
//class APIManager {
//    
//    static let shared = APIManager()
//    let url = "https://api.themoviedb.org/3/trending/movie/week?api_key=152a4fcac551e64aa0720ed503e170da"
//    
//    private init() { }
//    
//    func callRequest(url: String, completion: @escaping ([Trend]) -> Void) {
//        
//        guard let url = URL(string: url) else { return }
//        
//        URLSession.shared.dataTask(with: url) { data, response, error in
//            if let error {
//                print("\(error)")
//            }
//            
//            guard response != nil else {
//                print("response Error")
//                return
//            }
//            
//            guard let data else {
//                print("data Error")
//                return
//            }
//            
//            guard let item = self.parseJSON(data) else {
//                print("parse Error")
//                return
//            }
//            print(item)
//            
//            completion(item)
//        }.resume()
//    }
//    
//    func parseJSON(_ data: Data) -> [Trend]? {
//        do {
//            let decodedData = try JSONDecoder().decode(Movie.self, from: data)
//            let item = decodedData.results
//            return item
//        } catch {
//            print("JSON파싱 실패")
//            return nil
//        }
//    }
//    
//}
//
//enum Quary: String {
//    case movie = "https://api.themoviedb.org/3/trending/movie/week"
//    case credits = "https://api.themoviedb.org/3/movie/787699/credits"
//}
