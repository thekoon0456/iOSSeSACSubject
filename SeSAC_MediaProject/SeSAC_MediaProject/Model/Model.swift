//
//  Model.swift
//  SeSAC_MediaProject
//
//  Created by Deokhun KIM on 1/25/24.
//

import Foundation

//https://developers.themoviedb.org/3/trending/get-trending

struct Trend: Model, Codable {
    let data: String
    let genre: String
    let title: String
    let overview: String
    let score: String
    let posterURL: String
    
    
}
