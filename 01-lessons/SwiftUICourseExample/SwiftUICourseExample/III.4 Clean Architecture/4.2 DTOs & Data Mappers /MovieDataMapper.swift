//
//  MovieDataMapper.swift
//  SwiftUICourseExample
//
//  Created by le.hong.van on 29/7/26.
//

import Foundation

// 3. Bộ dịch thuật Data Mapper cách ly hoàn toàn biến động (Tầng Data)
struct MovieDataMapper {
    static func transformToDomain(dto: MovieDTO) -> Result<Movie, Error> {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        let parsedDate = formatter.date(from: dto.release_date)
        
        let tmdbBaseURL = "https://image.tmdb.org/t/p/w500"
        let posterURL = dto.poster_path.flatMap { URL(string: tmdbBaseURL + $0) }
        
        let cleanEntity = Movie(
            id: dto.id,
            title: dto.original_title.uppercased(),
            overview: dto.overview,
            posterURL: posterURL,
            voteAverage: dto.vote_average,
            releaseDate: parsedDate
        )
        return .success(cleanEntity)
    }
}
