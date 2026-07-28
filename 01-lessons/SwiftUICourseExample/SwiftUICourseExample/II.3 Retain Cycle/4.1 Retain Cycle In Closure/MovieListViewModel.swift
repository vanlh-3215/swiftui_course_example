//
//  MovieListViewModel.swift
//  SwiftUICourseExample
//
//  Created by le.hong.van on 27/7/26.
//

import Combine

class MovieListViewModel: ObservableObject {
    @Published var movies: [String] = []
    var apiService: TMDBNetworkService = TMDBNetworkService()
    
    func fetchMovies() {
        // closure của apiService đang capture mạnh (strong capture) 'self'
        apiService.request { data in
            // Lỗi tiềm ẩn ở đây!
            self.movies = data
        }
        // HOW TO FIX: Sử dụng [weak self] để tránh Retain Cycle
        // Sử dụng [weak self] để khai báo tham chiếu yếu đến ViewModel trong Closure
//            apiService.request { [weak self] data in
//                // Lúc này, self đã trở thành Optional kiểu MovieListViewModel?
//                guard let self = self else {
//                    print("MovieListViewModel đã bị giải phóng trước khi API trả về.")
//                    return
//                }
//                
//                // Cập nhật giao diện an toàn
//                self.movies = data
//            }

    }
    
    deinit {
        print("MovieListViewModel giải phóng bộ nhớ! (Sẽ KHÔNG bao giờ in dòng này nếu bị Retain Cycle)")
    }
}
