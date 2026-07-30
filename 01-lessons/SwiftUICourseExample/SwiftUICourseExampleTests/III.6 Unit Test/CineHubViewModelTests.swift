//
//  CineHubViewModelTests.swift
//  SwiftUICourseExample
//
//  Created by le.hong.van on 30/7/26.
//

import Testing
import Foundation
@testable import SwiftUICourseExample

// 1. Khai báo Suite - Một nhóm các ca kiểm thử liên quan đến nhau
@Suite("Kiểm thử logic của bộ điều phối MovieDetailViewModel")
struct CineHubViewModelTests {
    
    // 2. CA KIỂM THỬ SỐ 1: Trạng thái tải dữ liệu phim THÀNH CÔNG
    @Test("Kiểm tra ViewModel nhận và nạp dữ liệu phim thành công từ UseCase")
    @MainActor // Đảm bảo test chạy trên MainActor vì ViewModel được đánh dấu @MainActor
    func testLoadMovieMetricsSuccess() async throws {
        // GIAI ĐOẠN 1: GIVEN (Thiết lập trạng thái thành công)
        let mockRepository = MockMovieRepository()
        mockRepository.shouldTriggerNetworkError = false // Kịch bản: Mạng chạy bình thường
        
        let useCase = GetMovieDetailUseCase(repository: mockRepository)
        let viewModel = MovieDetailViewModel(getMovieDetailUseCase: useCase)
        
        // GIAI ĐOẠN 2: WHEN (Thực thi hành động gọi nạp dữ liệu phim)
        await viewModel.loadMovieMetrics(id: 101)
        
        // GIAI ĐOẠN 3: THEN (Dùng macro #expect để kiểm chứng kết quả)
        // 3.1. Đảm bảo biến lỗi bằng nil
        #expect(viewModel.errorMessageLog == nil)
        
        // 3.2. Dùng #require để unwrap an toàn biến displayedMovie, nếu de-nil thất bại, test dừng ngay lập tức
        let displayedMovie = try #require(viewModel.displayedMovie)
        
        // 3.3. Kiểm chứng các thuộc tính của phim hiển thị khớp chính xác với Mock Payload
        #expect(displayedMovie.id == 999)
        #expect(displayedMovie.title == "MOCK AVATAR: TESTING")
        #expect(displayedMovie.voteAverage == 9.8)
    }
    
    // 3. CA KIỂM THỬ SỐ 2: Trạng thái tải dữ liệu phim THẤT BẠI do mất mạng
    @Test("Kiểm tra ViewModel xử lý chính xác và nạp log lỗi khi gặp sự cố mất mạng")
    @MainActor
    func testLoadMovieMetricsFailure() async {
        // GIAI ĐOẠN 1: GIVEN (Thiết lập kịch bản lỗi mất mạng)
        let mockRepository = MockMovieRepository()
        mockRepository.shouldTriggerNetworkError = true // Ép kịch bản rơi vào lỗi kết nối
        
        let useCase = GetMovieDetailUseCase(repository: mockRepository)
        let viewModel = MovieDetailViewModel(getMovieDetailUseCase: useCase)
        
        // GIAI ĐOẠN 2: WHEN (Thực thi hành động)
        await viewModel.loadMovieMetrics(id: 101)
        
        // GIAI ĐOẠN 3: THEN (Kiểm chứng)
        // 3.1. Đảm bảo phim hiển thị đã được giải phóng về nil để tránh hiển thị sai lệch
        #expect(viewModel.displayedMovie == nil)
        
        // 3.2. Đảm bảo log lỗi hiển thị chính xác thông điệp bản địa hóa
        let expectedErrorMessage = MovieError.networkConnectionLimit.localizedDescription
        #expect(viewModel.errorMessageLog == expectedErrorMessage)
    }
}
