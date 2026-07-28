//
//  MovieListView.swift
//  SwiftUICourseExample
//
//  Created by le.hong.van on 27/7/26.
//

import SwiftUI

struct MovieListView: View {
    @StateObject private var viewModel = MovieListViewModel()
    @State private var didRequestMovies = false
    
    var body: some View {
        VStack(spacing: 20) {
            Text("MovieList")
                .font(.title2)
                .fontWeight(.bold)
            
            Button("Fetch Movies") {
                didRequestMovies = true
                viewModel.fetchMovies()
            }
            .buttonStyle(.borderedProminent)
            
            if viewModel.movies.isEmpty {
                Text(didRequestMovies ? "Đang tải phim từ TMDBNetworkService..." : "Chưa có dữ liệu phim")
                    .foregroundStyle(.secondary)
            } else {
                List(viewModel.movies, id: \.self) { movie in
                    Label(movie, systemImage: "film")
                }
                .listStyle(.plain)
            }
        }
        .padding()
        .onAppear {
            print("MovieListView xuất hiện. ViewModel đang được giữ bởi @StateObject.")
        }
        .onDisappear {
            print("MovieListView biến mất. Nếu bị retain cycle, MovieListViewModel sẽ không chạy deinit.")
        }
    }
}

#Preview {
    MovieListView()
}
