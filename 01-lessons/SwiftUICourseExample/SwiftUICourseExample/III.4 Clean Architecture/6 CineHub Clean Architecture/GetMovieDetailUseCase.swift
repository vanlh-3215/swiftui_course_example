//
//  GetMovieDetailUseCase.swift
//  SwiftUICourseExample
//
//  Created by le.hong.van on 29/7/26.
//

import Foundation

protocol GetMovieDetailUseCaseProtocol {
    func callAsFunction(id: Int) async -> Result<Movie, Error>
}

final class GetMovieDetailUseCase: GetMovieDetailUseCaseProtocol {
    private let repository: MovieRepositoryProtocol
    
    init(repository: MovieRepositoryProtocol) {
        self.repository = repository
    }
    
    func callAsFunction(id: Int) async -> Result<Movie, Error> {
        guard id > 0 else {
            return .failure(MovieError.invalidID)
        }
        return await repository.fetchMovieDetail(id: id)
    }
}
