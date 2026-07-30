//
//  MockMovieRepository.swift
//  SwiftUICourseExample
//
//  Created by le.hong.van on 30/7/26.
//

import Foundation
@testable import SwiftUICourseExample // Import module chính để lấy các struct Movie, MovieError...

// 1. Tạo Mock Repository để giả lập hành vi lấy dữ liệu phim từ TMDB API
final class MockMovieRepository: MovieRepositoryProtocol {
    // Các biến cờ giúp chúng ta chủ động thay đổi kịch bản kiểm thử từ bên ngoài
    var shouldTriggerNetworkError: Bool = false
    
    // Dữ liệu phim giả lập thành công mong muốn
    var mockSuccessMovie = Movie(
        id: 999,
        title: "MOCK AVATAR: TESTING",
        overview: "Nội dung phim giả lập phục vụ mục đích kiểm thử tự động.",
        posterURL: URL(string: "https://image.tmdb.org/t/p/w500/mock.jpg"),
        voteAverage: 9.8,
        releaseDate: Date()
    )
    
    func fetchMovieDetail(id: Int) async -> Result<Movie, Error> {
        // Kịch bản rẽ nhánh chủ động bằng code tĩnh cực nhanh
        if shouldTriggerNetworkError {
            return .failure(MovieError.networkConnectionLimit)
        } else {
            return .success(mockSuccessMovie)
        }
    }
}
