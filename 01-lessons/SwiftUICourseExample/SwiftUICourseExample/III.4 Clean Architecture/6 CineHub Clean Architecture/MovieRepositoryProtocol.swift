//
//  MovieRepositoryProtocol.swift
//  SwiftUICourseExample
//
//  Created by le.hong.van on 29/7/26.
//

import Foundation

protocol MovieRepositoryProtocol {
    func fetchMovieDetail(id: Int) async -> Result<Movie, Error>
}

enum MovieError: Error, LocalizedError {
    case invalidID
    case parsingFailure
    case networkConnectionLimit
    case localCacheExpired
    
    var errorDescription: String? {
        switch self {
        case .invalidID:
            return "Lỗi: Mã số phim truy vấn không hợp lệ hoặc không được phép để trống."
        case .parsingFailure:
            return "Sự cố: Cấu trúc tệp tin dữ liệu từ biên giới bị xung đột định dạng cấu hình TMDB."
        case .networkConnectionLimit:
            return "Lỗi: Không thể thiết lập cổng kết nối mạng Internet tới máy chủ điện ảnh TMDB."
        case .localCacheExpired:
            return "Cảnh báo: Dữ liệu bộ nhớ đệm phim cục bộ đã hết hạn."
        }
    }
}
