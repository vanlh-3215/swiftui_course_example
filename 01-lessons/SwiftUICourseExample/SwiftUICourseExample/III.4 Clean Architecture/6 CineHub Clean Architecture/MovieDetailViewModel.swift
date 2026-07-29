//
//  MovieDetailViewModel.swift
//  SwiftUICourseExample
//
//  Created by le.hong.van on 29/7/26.
//

import SwiftUI
import Observation

@Observable @MainActor
final class MovieDetailViewModel {
    // Đóng gói trừu tượng: Kết nối lỏng lẻo 100% qua Protocol
    private let getMovieDetailUseCase: GetMovieDetailUseCaseProtocol
    
    // Các biến trạng thái hình học quản lý màn hình hiển thị
    var displayedMovie: Movie? = nil
    var errorMessageLog: String? = nil
    var isFetchingData: Bool = false
    
    init(getMovieDetailUseCase: GetMovieDetailUseCaseProtocol) {
        self.getMovieDetailUseCase = getMovieDetailUseCase
    }
    
    func loadMovieMetrics(id: Int) async {
        self.isFetchingData = true
        self.errorMessageLog = nil
        
        // Vòng lặp UDF: Thực thi UseCase lõi nghiệp vụ đơn nhiệm
        let result = await getMovieDetailUseCase(id: id)
        switch result {
        case .success(let pureEntity):
            self.displayedMovie = pureEntity
        case .failure(let error):
            self.errorMessageLog = error.localizedDescription
            self.displayedMovie = nil
        }
        self.isFetchingData = false
    }
}
