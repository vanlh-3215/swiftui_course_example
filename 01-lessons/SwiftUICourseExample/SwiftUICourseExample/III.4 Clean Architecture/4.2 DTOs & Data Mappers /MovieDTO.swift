//
//  MovieDTO.swift
//  SwiftUICourseExample
//
//  Created by le.hong.van on 29/7/26.
//

import Foundation

struct MovieDTO: Decodable {
    let id: Int
    let original_title: String
    let overview: String
    let poster_path: String?
    let vote_average: Double
    let release_date: String
}
