//
//  Movie.swift
//  SwiftUICourseExample
//
//  Created by le.hong.van on 29/7/26.
//

import Foundation

// 2. Thực thể sạch tinh khiết bảo vệ logic lõi (Tầng Domain)
struct Movie: Identifiable, Hashable {
    let id: Int
    let title: String
    let overview: String
    let posterURL: URL?
    let voteAverage: Double
    let releaseDate: Date?
}
