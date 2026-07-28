//
//  CineHubPaymentView.swift
//  SwiftUICourseExample
//
//  Created by le.hong.van on 28/7/26.
//

import SwiftUI

// 1. SUBVIEW THÀNH PHẦN A (Nhập liệu thanh toán) - Sử dụng @Binding để đồng bộ hóa
struct TicketPaymentInputView: View {
    @Binding var paymentAmount: Double // Thiết lập "đường ống" kết nối trực tiếp về cha
    
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text("Định mức thanh toán vé:")
                .font(.subheadline)
                .foregroundColor(.secondary)
            
            HStack {
                Text("đ")
                    .fontWeight(.bold)
                    .foregroundColor(.blue)
                TextField("Nhập số tiền", value: $paymentAmount, format: .number)
                    .keyboardType(.decimalPad)
                    .textFieldStyle(.roundedBorder)
            }
        }
        .padding()
        .background(Color(.systemGray6))
        .cornerRadius(12)
    }
}

// 2. SUBVIEW THÀNH PHẦN B (Hiển thị số dư) - Chỉ tiếp nhận giá trị phái sinh (Read-only)
struct WalletBalanceDisplayView: View {
    let remainingBalance: Double // Nhận dữ liệu snapshot để hiển thị, không có quyền chỉnh sửa
    
    var body: some View {
        HStack {
            Text("Số dư ví CineWallet hiện tại:")
                .font(.subheadline)
                .foregroundColor(.secondary)
            Spacer()
            Text("\(remainingBalance, specifier: "%.0f") đ")
                .font(.headline)
                .foregroundColor(remainingBalance < 0 ? .red : .green)
        }
        .padding()
        .background(Color(.systemGray6))
        .cornerRadius(12)
    }
}

// 3. MÀN HÌNH ĐIỀU PHỐI (Payment Orchestrator) - Quản lý Nguồn sự thật gốc (Source of Truth)
struct CineHubPaymentView: View {
    // Khởi tạo trạng thái gốc an toàn trên Heap thông qua @State
    @State private var walletBalance: Double = 2000000 // Số dư khởi tạo: 2.000.000đ
    @State private var ticketPrice: Double = 0.0
    
    var body: some View {
        VStack(spacing: 20) {
            Text("QUY TRÌNH THANH TOÁN CINEHUB")
                .font(.title2)
                .fontWeight(.bold)
                .padding(.top)
            
            // Áp dụng kỹ thuật State Hoisting: Truyền giá trị tính toán xuống View B
            WalletBalanceDisplayView(remainingBalance: walletBalance - ticketPrice)
            
            // Thiết lập liên kết hai chiều ($) cho View A để cập nhật Mutation về cha
            TicketPaymentInputView(paymentAmount: $ticketPrice)
            
            Button(action: {
                withAnimation(.spring()) {
                    // Thực hiện Mutation thay đổi State gốc
                    walletBalance -= ticketPrice
                    ticketPrice = 0.0
                }
            }) {
                Text("XÁC NHẬN GIAO DỊCH")
                    .fontWeight(.bold)
                    .foregroundColor(.white)
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(Color.blue)
                    .cornerRadius(10)
            }
            .disabled(ticketPrice <= 0 || ticketPrice > walletBalance)
        }
        .padding()
        .background(Color(.systemBackground))
        .cornerRadius(16)
        .shadow(color: Color.black.opacity(0.05), radius: 8, x: 0, y: 4)
        .padding()
    }
}

#Preview {
    CineHubPaymentView()
}
