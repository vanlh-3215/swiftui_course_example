//
//  TicketTimerView.swift
//  SwiftUICourseExample
//
//  Created by le.hong.van on 27/7/26.
//

import SwiftUI

struct TicketTimerView: View {
    @State private var remainingSeconds: Double = 600.0 // 10 phút giữ ghế thanh toán vé
    @State private var countdownTimer: Timer? = nil
    
    var body: some View {
        VStack(spacing: 20) {
            Text("Thời gian hoàn tất đặt vé CineHub:")
                .font(.headline)
            
            Text(String(format: "%.0f giây", remainingSeconds))
                .font(.system(size: 40, weight: .bold, design: .monospaced))
                .foregroundColor(.red)
                .padding()
        }
        // Kích hoạt khi màn hình TicketTimerView xuất hiện trước mắt người dùng
        .onAppear {
            print("Màn hình thanh toán vé hiển thị. Bắt đầu đếm ngược giữ ghế.")
            startCountdown()
        }
        // Kích hoạt khi người dùng quay lại màn hình trước hoặc đóng tab này đi
        .onDisappear {
            print("Màn hình đã bị ẩn đi. Dừng đếm ngược để giải phóng CPU và Pin.")
            stopCountdown()
        }
    }
    
    private func startCountdown() {
        // Cứ mỗi 1 giây giảm thời gian giữ ghế xuống 1 đơn vị
        countdownTimer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { _ in
            if remainingSeconds > 0 {
                remainingSeconds -= 1.0
                print("Đang đếm ngược giữ ghế đặt vé: \(remainingSeconds) giây")
            } else {
                stopCountdown()
            }
        }
    }
    
    private func stopCountdown() {
        countdownTimer?.invalidate()
        countdownTimer = nil
    }
}
