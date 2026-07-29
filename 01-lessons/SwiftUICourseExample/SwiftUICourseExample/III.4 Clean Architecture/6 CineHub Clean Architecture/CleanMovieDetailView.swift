//
//  CleanMovieDetailView.swift
//  SwiftUICourseExample
//
//  Created by le.hong.van on 29/7/26.
//

import SwiftUI

struct CleanMovieDetailView: View {
    // COMPOSITION ROOT PATTERN: Khởi tạo chuỗi đồ thị phụ thuộc ngay tại điểm gốc của cấu trúc View
    @State private var viewModel = MovieDetailViewModel(
        getMovieDetailUseCase: GetMovieDetailUseCase(
            repository: MovieRepository()
        )
    )
    @State private var inputMovieIDText: String = "101"
    
    var body: some View {
        NavigationStack {
            VStack(spacing: 25) {
                HStack(spacing: 12) {
                    TextField("Mã phim TMDB ID (Ví dụ: 101, 102, 103)", text: $inputMovieIDText)
                        .textFieldStyle(.roundedBorder)
                        .fontDesign(.rounded)
                        .keyboardType(.numberPad)
                    
                    Button(action: {
                        if let id = Int(inputMovieIDText) {
                            Task {
                                await viewModel.loadMovieMetrics(id: id)
                            }
                        }
                    }) {
                        Text("TRUY VẤN")
                            .bold()
                            .padding(.horizontal, 18)
                            .padding(.vertical, 10)
                            .background(Color.blue)
                            .foregroundColor(.white)
                            .cornerRadius(10)
                    }
                }
                .padding(.horizontal)
                
                Divider()
                
                // KIỂM TRA MÁY TRẠNG THÁI RẼ NHÁNH HIỂN THỊ
                if viewModel.isFetchingData {
                    Spacer()
                    ProgressView("Đang liên kết dữ liệu hệ thống CineHub...")
                    Spacer()
                } else if let errorString = viewModel.errorMessageLog {
                    Spacer()
                    ContentUnavailableView(
                        "Xảy ra lỗi nghiệp vụ",
                        systemImage: "exclamationmark.shield.fill",
                        description: Text(errorString)
                    )
                    Spacer()
                } else if let movie = viewModel.displayedMovie {
                    VStack(spacing: 16) {
                        Text("PHIM ĐANG TRUY VẤN - CINEHUB PORTAL")
                            .font(.caption)
                            .bold()
                            .foregroundColor(.secondary)
                        
                        Text(movie.title)
                            .font(.system(size: 24, weight: .black, design: .rounded))
                            .foregroundColor(.blue)
                            .multilineTextAlignment(.center)
                        
                        Text(movie.overview)
                            .font(.body)
                            .foregroundColor(.primary)
                            .multilineTextAlignment(.leading)
                            .padding(.vertical, 8)
                        
                        HStack(spacing: 8) {
                            Image(systemName: "star.fill")
                                .foregroundColor(.yellow)
                            Text(String(format: "%.1f / 10", movie.voteAverage))
                                .font(.system(size: 18, weight: .bold, design: .monospaced))
                                .foregroundColor(.green)
                        }
                        
                        if let releaseDate = movie.releaseDate {
                            Text("Khởi chiếu: \(releaseDate.formatted(date: .abbreviated, time: .omitted))")
                                .font(.caption2)
                                .foregroundColor(.secondary)
                        }
                    }
                    .padding(24)
                    .frame(maxWidth: .infinity)
                    .background(Color(.systemGray6))
                    .cornerRadius(20)
                    .padding(.horizontal)
                    Spacer()
                } else {
                    Spacer()
                    Image(systemName: "film.stack")
                        .font(.system(size: 40))
                        .foregroundColor(.gray.opacity(0.5))
                    Text("Vui lòng nhập mã phim ID để thực thi quét trạng thái thông tin.")
                        .font(.footnote)
                        .foregroundColor(.secondary)
                        .padding(.horizontal, 50)
                        .multilineTextAlignment(.center)
                    Spacer()
                }
            }
            .padding(.top)
            .navigationTitle("CineHub Clean Arch")
            .task {
                if let id = Int(inputMovieIDText) {
                    await viewModel.loadMovieMetrics(id: id)
                }
            }
        }
    }
}

#Preview {
    CleanMovieDetailView()
}
