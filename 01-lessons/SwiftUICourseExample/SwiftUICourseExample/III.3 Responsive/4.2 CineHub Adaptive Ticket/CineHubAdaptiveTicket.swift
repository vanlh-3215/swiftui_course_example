//
//  CineHubAdaptiveTicket.swift
//  SwiftUICourseExample
//
//  Created by le.hong.van on 29/7/26.
//

import SwiftUI

struct CineAdaptiveTicketView: View {
    let movieTitle: String
    let showTime: String
    let ticketPrice: Double
    
    // 1. Quản lý co giãn kích thước hình học động đồng bộ theo cỡ chữ .body
    @ScaledMetric(relativeTo: .body) private var ticketIconSize: CGFloat = 20
    @ScaledMetric(relativeTo: .body) private var internalPadding: CGFloat = 16
    @ScaledMetric(relativeTo: .body) private var cornerRadiusSize: CGFloat = 16
    
    // Trạng thái yêu thích của vé để chạy hiệu ứng hoạt họa
    @State private var isFavorite = false
    
    var body: some View {
        ViewThatFits(in: .horizontal) {
            // Phương án A: Không gian rộng rãi -> Dàn hàng ngang mượt mà
            HStack(alignment: .center, spacing: internalPadding) {
                ticketInfoGroup
                Spacer()
                buyButtonView
            }
            
            // Phương án B: Không gian bị bóp hẹp (Chữ to / Màn hình nhỏ) -> Xếp dọc gọn gàng
            VStack(alignment: .leading, spacing: internalPadding) {
                ticketInfoGroup
                buyButtonView
            }
        }
        .padding(internalPadding)
        .background(Color(.systemGray6))
        .cornerRadius(cornerRadiusSize)
        .shadow(color: Color.black.opacity(0.05), radius: 8, x: 0, y: 4)
        .padding(.horizontal)
    }
    
    // Nhóm giao diện thông tin chi tiết vé
    private var ticketInfoGroup: some View {
        VStack(alignment: .leading, spacing: 8) {
            HStack(spacing: 6) {
                // Biểu tượng cuộn phim hoạt họa khi nhấn yêu thích
                Button(action: {
                    withAnimation(.spring(response: 0.3, dampingFraction: 0.5)) {
                        isFavorite.toggle()
                    }
                }) {
                    Image(systemName: isFavorite ? "heart.fill" : "heart")
                        .resizable()
                        .frame(width: ticketIconSize, height: ticketIconSize)
                        .foregroundColor(isFavorite ? .red : .gray)
                        .symbolEffect(.bounce, value: isFavorite) // Hoạt họa biểu tượng
                }
                
                Text("VÉ CÔNG CHIẾU ẢO")
                    .font(.caption)
                    .fontWeight(.bold)
                    .foregroundColor(.blue)
            }
            
            Text(movieTitle.uppercased())
                .font(.headline)
                .foregroundColor(.primary)
                .lineLimit(1)
            
            Text("Lịch chiếu: \(showTime)")
                .font(.subheadline)
                .foregroundColor(.secondary)
        }
    }
    
    // Nhóm giao diện nút bấm hành động thanh toán
    private var buyButtonView: some View {
        Button(action: {}) {
            HStack(spacing: 8) {
                Image(systemName: "creditcard.fill")
                    .resizable()
                    .frame(width: ticketIconSize, height: ticketIconSize * 0.7)
                Text("MUA \(ticketPrice, specifier: "%.0f") đ")
            }
            .font(.subheadline)
            .bold()
            .foregroundColor(.white)
            .padding(.horizontal, 16)
            .padding(.vertical, 10)
            .background(Color.blue)
            .cornerRadius(10)
        }
    }
}

// Preview hỗ trợ kiểm thử tính năng co giãn động trên Xcode Canvas
struct CineAdaptiveTicketView_Previews: PreviewProvider {
    static var previews: some View {
        VStack(spacing: 20) {
            Text("Màn hình mô phỏng responsive:")
                .font(.title3)
                .bold()
            
            // 1. Chế độ hiển thị bình thường (Phương án A - Ngang)
            CineAdaptiveTicketView(
                movieTitle: "Dune: Hành Tinh Cát 2",
                showTime: "20:00 - 24/12/2026",
                ticketPrice: 120000
            )
            
            // 2. Chế độ mô phỏng khung hình hẹp (Phương án B - Dọc)
            CineAdaptiveTicketView(
                movieTitle: "Oppenheimer: Kẻ Hủy Diệt Thế Giới",
                showTime: "18:00 - 25/12/2026",
                ticketPrice: 150000
            )
            .frame(width: 250) // Ép khung hiển thị cực hẹp để ép ViewThatFits chuyển sang VStack
        }
    }
}
