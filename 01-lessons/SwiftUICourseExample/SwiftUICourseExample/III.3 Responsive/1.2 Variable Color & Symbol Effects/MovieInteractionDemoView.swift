//
//  MovieInteractionDemoView.swift
//  SwiftUICourseExample
//
//  Created by le.hong.van on 29/7/26.
//

import SwiftUI

struct MovieInteractionDemoView: View {
    @State private var isBookmarked = false
    @State private var ticketCount = 0
    
    var body: some View {
        VStack(spacing: 30) {
            // 1. Hiệu ứng Bounce (Nảy) khi người dùng lưu phim
            Button(action: { isBookmarked.toggle() }) {
                HStack {
                    Image(systemName: isBookmarked ? "bookmark.fill" : "bookmark")
                        // Tự động kích hoạt hiệu ứng nảy nhẹ khi giá trị isBookmarked thay đổi
                        .symbolEffect(.bounce, value: isBookmarked)
                        .foregroundColor(.yellow)
                    Text(isBookmarked ? "Đã lưu phim" : "Lưu vào thư viện")
                }
                .font(.headline)
            }
            
            // 2. Hiệu ứng Pulse (Xung nhịp) báo hiệu phòng chiếu đang trực tiếp (Live Stream)
            HStack(spacing: 8) {
                Image(systemName: "dot.radiowaves.left.and.right")
                    // Chạy hiệu ứng nhấp nháy vô tận để tạo cảm giác phát sóng trực tiếp
                    .symbolEffect(.pulse, options: .repeating)
                    .foregroundColor(.red)
                Text("PHÒNG CHIẾU LIVE ĐANG MỞ VÉ")
                    .font(.caption)
                    .fontWeight(.bold)
            }
            
            // 3. Hiệu ứng nảy dồn dập (Bounce.down) khi tăng số lượng vé đặt
            Button(action: { ticketCount += 1 }) {
                HStack {
                    Image(systemName: "ticket.fill")
                        .symbolEffect(.bounce.down, value: ticketCount)
                    Text("Đặt thêm vé ảo (\(ticketCount))")
                }
                .padding()
                .background(Color.blue)
                .foregroundColor(.white)
                .cornerRadius(10)
            }
        }
    }
}

#Preview {
    MovieInteractionDemoView()
}
