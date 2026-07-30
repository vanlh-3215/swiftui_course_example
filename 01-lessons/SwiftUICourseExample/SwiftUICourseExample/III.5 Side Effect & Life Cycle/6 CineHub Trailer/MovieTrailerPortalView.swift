//
//  MovieTrailerPortalView.swift
//  SwiftUICourseExample
//
//  Created by le.hong.van on 29/7/26.
//

import SwiftUI
import Observation

// ==========================================
// 1. VIEWMODEL QUẢN LÝ TIẾN TRÌNH @OBSERVABLE
// ==========================================
@Observable @MainActor
class MovieTrailerViewModel {
    var movieTitle: String = "Đang tải..."
    var movieOverview: String = ""
    var isFetching: Bool = false
    
    // Giả lập tiến trình mạng tải chi tiết phim TMDB
    func fetchMovieDetail(for id: Int) async {
        self.isFetching = true
        self.movieTitle = "Đang kết nối TMDB..."
        self.movieOverview = ""
        
        do {
            // Giả lập độ trễ mạng thực tế 1.5 giây
            // Lệnh Task.sleep này tự động hỗ trợ tự hủy nếu Task bị cancel giữa chừng
            try await Task.sleep(for: .seconds(1.5))
            
            // Cấu hình dữ liệu giả lập dựa trên ID phim
            switch id {
            case 101:
                self.movieTitle = "AVATAR: DÒNG CHẢY CỦA NƯỚC"
                self.movieOverview = "Jake Sully sống cùng gia đình mới trên Pandora. Khi mối đe dọa cũ quay lại, anh phải hợp tác với tộc Na'vi để bảo vệ quê hương."
            case 102:
                self.movieTitle = "OPPENHEIMER: KẺ HỦY DIỆT"
                self.movieOverview = "Câu chuyện về nhà vật lý J. Robert Oppenheimer trong dự án Manhattan chế tạo quả bom nguyên tử đầu tiên trên thế giới."
            case 103:
                self.movieTitle = "DUNE: HÀNH TINH CÁT 2"
                self.movieOverview = "Paul Atreides hội quân cùng tộc người Fremen để phát động cuộc chiến báo thù những kẻ đã hủy diệt gia tộc mình."
            default:
                self.movieTitle = "PHIM CHƯA CẬP NHẬT"
                self.movieOverview = "Thông tin bộ phim này đang được CineHub cập nhật từ máy chủ TMDB."
            }
        } catch {
            // Khi tiến trình bị hủy, Task.sleep sẽ ném lỗi CancellationError và nhảy vào đây
            print("CineHub: Tiến trình tải phim ID \(id) đã bị hủy bỏ thành công!")
        }
        
        self.isFetching = false
    }
}

// ==========================================
// 2. TẦNG PRESENTATION (SWIFTUI VIEW)
// ==========================================
struct MovieTrailerPortalView: View {
    @State private var viewModel = MovieTrailerViewModel()
    @State private var selectedMovieID: Int = 101 // ID phim đang chọn
    
    var body: some View {
        NavigationStack {
            VStack(spacing: 20) {
                // Bộ chọn phim TMDB nhanh
                Picker("Chọn Phim", selection: $selectedMovieID) {
                    Text("Avatar 2").tag(101)
                    Text("Oppenheimer").tag(102)
                    Text("Dune 2").tag(103)
                }
                .pickerStyle(.segmented)
                .padding(.horizontal)
                
                Divider()
                
                // Hiển thị trạng thái tải dữ liệu
                if viewModel.isFetching {
                    VStack(spacing: 12) {
                        ProgressView()
                            .scaleEffect(1.2)
                        Text("Đang tải dữ liệu từ TMDB...")
                            .font(.footnote)
                            .foregroundColor(.secondary)
                    }
                    .frame(maxHeight: .infinity)
                } else {
                    ScrollView {
                        VStack(alignment: .leading, spacing: 16) {
                            // Banner phim giả lập
                            RoundedRectangle(cornerRadius: 16)
                                .fill(LinearGradient(colors: [Color.black, Color.blue.opacity(0.8)], startPoint: .top, endPoint: .bottom))
                                .frame(height: 180)
                                .overlay(
                                    Image(systemName: "play.circle.fill")
                                        .font(.system(size: 60))
                                        .foregroundColor(.white.opacity(0.8))
                                )
                            
                            Text(viewModel.movieTitle)
                                .font(.title2)
                                .bold()
                                .foregroundColor(.primary)
                            
                            Text("TÓM TẮT PHIM")
                                .font(.caption)
                                .bold()
                                .foregroundColor(.secondary)
                            
                            Text(viewModel.movieOverview)
                                .font(.body)
                                .foregroundColor(.primary)
                                .lineSpacing(4)
                        }
                        .padding()
                    }
                }
            }
            .navigationTitle("CineHub Trailers")
            // ⚠️ ĐIỂM SẤN QUYẾT: Áp dụng .task(id:) để quản lý vòng đời luồng tự động
            .task(id: selectedMovieID) {
                // Mỗi khi selectedMovieID thay đổi, Task cũ đang tải dở sẽ tự động bị HỦY,
                // và Task mới được khởi tạo ngay lập tức mà không gây tốn tài nguyên mạng.
                await viewModel.fetchMovieDetail(for: selectedMovieID)
            }
            // Lắng nghe ghi nhận lịch sử duyệt phim của học viên
            .onChange(of: selectedMovieID) { oldValue, newValue in
                print("Lịch sử duyệt: Người dùng chuyển từ phim ID \(oldValue) sang phim ID \(newValue)")
            }
        }
    }
}

#Preview {
    MovieTrailerPortalView()
}
