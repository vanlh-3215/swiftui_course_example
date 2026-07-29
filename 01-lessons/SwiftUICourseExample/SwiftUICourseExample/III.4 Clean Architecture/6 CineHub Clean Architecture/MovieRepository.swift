//
//  MovieRepository.swift
//  SwiftUICourseExample
//
//  Created by le.hong.van on 29/7/26.
//

import Foundation

final class MovieRepository: MovieRepositoryProtocol {
    private let session: URLSession
    // Giả lập cơ chế lưu trữ bộ nhớ đệm trong RAM đại diện cho Local DataSource
    private var localMemoryCache: [Int: (entity: Movie, timestamp: Date)] = [:]
    private let cacheTTL: TimeInterval = 60.0 // Cache có hiệu lực trong 60 giây
    
    init(session: URLSession = .shared) {
        self.session = session
    }
    
    func fetchMovieDetail(id: Int) async -> Result<Movie, Error> {
        // 1. KIỂM TRA CACHE CỤC BỘ (Local Data Source Pass)
        if let cachedData = localMemoryCache[id],
           Date().timeIntervalSince(cachedData.timestamp) < cacheTTL {
            print("Repository: Lấy dữ liệu phim thành công từ bộ đệm RAM cho ID: \(id)")
            return .success(cachedData.entity)
        }
        
        // 2. KHỞI CHẠY TIẾN TRÌNH GỌI MẠNG VẬT LÝ (Remote Data Source Pass)
        // Gọi API thật của hệ thống TMDB Mock-up hoặc Endpoint ảo
        guard let url = URL(string: "https://api.themoviedb.org/3/movie/\(id)") else {
            return .failure(MovieError.invalidID)
        }
        
        do {
            let (rawData, _) = try await session.data(from: url)
            let decoder = JSONDecoder()
            let dto = try decoder.decode(MovieDTO.self, from: rawData)
            let mappingResult = MovieDataMapper.transformToDomain(dto: dto)
            
            if let entity = try? mappingResult.get() {
                // Ghi đè cập nhật vào bộ nhớ đệm cục bộ
                localMemoryCache[id] = (entity: entity, timestamp: Date())
            }
            return mappingResult
        } catch {
            // Giả lập nạp dữ liệu cứu cánh (Fallback Mock) phục vụ môi trường không có internet thực tế
            try? await Task.sleep(for: .seconds(1.0))
            let fallbackEntity = generateFallbackEntity(for: id)
            localMemoryCache[id] = (entity: fallbackEntity, timestamp: Date())
            return .success(fallbackEntity)
        }
    }
    
    private func generateFallbackEntity(for id: Int) -> Movie {
        let dummyTitle: String
        let dummyOverview: String
        let dummyVote: Double
        
        switch id {
        case 101:
            dummyTitle = "Avatar: Dòng Chảy Của Nước"
            dummyOverview = "Jake Sully sống cùng gia đình mới của mình trên hành tinh Pandora. Khi một mối đe dọa quen thuộc quay trở lại, anh phải hợp tác với quân đội bộ tộc Na'vi để bảo vệ hành tinh quê hương..."
            dummyVote = 8.5
        case 102:
            dummyTitle = "Oppenheimer: Kẻ Hủy Diệt Thế Giới"
            dummyOverview = "Câu chuyện về nhà vật lý lý thuyết J. Robert Oppenheimer, người đóng vai trò tối cao lãnh đạo Dự án Manhattan chế tạo bom nguyên tử trong Thế chiến thứ hai."
            dummyVote = 8.9
        case 103:
            dummyTitle = "Dune: Hành Tinh Cát - Phần 2"
            dummyOverview = "Paul Atreides hội quân cùng Chani và tộc người Fremen để phát động cuộc chiến báo thù những kẻ hủy diệt gia tộc anh, nỗ lực ngăn chặn tương lai đen tối sắp ập đến."
            dummyVote = 8.7
        default:
            dummyTitle = "Sự Kiện Công Chiếu Phim Bom Tấn CineHub"
            dummyOverview = "Thông tin chi tiết về suất chiếu ra mắt đặc quyền của dự án Capstone CineHub."
            dummyVote = 7.5
        }
        
        return Movie(
            id: id,
            title: dummyTitle,
            overview: dummyOverview,
            posterURL: URL(string: "https://image.tmdb.org/t/p/w500/mock.jpg"),
            voteAverage: dummyVote,
            releaseDate: Date()
        )
    }
}
