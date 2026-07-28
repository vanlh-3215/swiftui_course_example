//
//  CineHubStoreView.swift
//  SwiftUICourseExample
//
//  Created by le.hong.van on 28/7/26.
//

import SwiftUI
import Observation

// ==========================================
// 1. LỚP QUẢN TRỊ @OBSERVABLE (Truy vết vi sai cấp thuộc tính)
// ==========================================
@Observable
class CineBookingManager {
    var selectedTickets: [String] = []
    
    var totalPrice: Int {
        return selectedTickets.count * 120000 // Đơn giá cố định: 120.000đ
    }
    
    func addTicket(for movieTitle: String) {
        selectedTickets.append(movieTitle)
        print("CineHub: Ghi nhận đặt vé cho phim: \(movieTitle)")
    }
    
    func clearAllTickets() {
        selectedTickets.removeAll()
    }
}

// ==========================================
// 2. CẤU PHẦN SUBVIEW (Tương tác Action theo luồng UDF)
// ==========================================
struct MovieRowComponent: View {
    let movieTitle: String
    var onAddAction: () -> Void // Đường ống phát lệnh Action lên cha
    
    var body: some View {
        HStack {
            VStack(alignment: .leading, spacing: 4) {
                Text(movieTitle)
                    .font(.headline)
                    .foregroundColor(.primary)
                Text("120.000 đ")
                    .font(.subheadline)
                    .foregroundColor(.secondary)
            }
            
            Spacer()
            
            Button(action: onAddAction) {
                HStack(spacing: 6) {
                    Image(systemName: "ticket.fill")
                    Text("Đặt vé")
                }
                .font(.subheadline)
                .bold()
                .foregroundColor(.white)
                .padding(.horizontal, 14)
                .padding(.vertical, 8)
                .background(Color.blue)
                .cornerRadius(8)
            }
        }
        .padding()
        .background(Color(.systemBackground))
        .cornerRadius(12)
        .shadow(color: Color.black.opacity(0.03), radius: 4, x: 0, y: 2)
    }
}

// ==========================================
// 3. VIEW TỔNG HỢP GIỎ HÀNG (Kéo dữ liệu trực tiếp từ Environment)
// ==========================================
struct BookingCartSummaryView: View {
    @Environment(CineBookingManager.self) private var bookingManager
    
    var body: some View {
        VStack(spacing: 16) {
            Text("THÔNG TIN GIỎ VÉ CỦA BẠN")
                .font(.caption)
                .bold()
                .foregroundColor(.secondary)
                .frame(maxWidth: .infinity, alignment: .leading)
            
            if bookingManager.selectedTickets.isEmpty {
                Text("Hiện tại chưa có vé nào được chọn.")
                    .font(.subheadline)
                    .foregroundColor(.secondary)
                    .padding(.vertical, 15)
            } else {
                VStack(alignment: .leading, spacing: 8) {
                    ForEach(bookingManager.selectedTickets, id: \.self) { ticket in
                        HStack {
                            Image(systemName: "checkmark.circle.fill")
                                .foregroundColor(.green)
                            Text(ticket)
                                .font(.subheadline)
                        }
                    }
                }
            }
            
            Divider()
            
            HStack {
                Text("Thành tiền:")
                    .font(.subheadline)
                    .bold()
                Spacer()
                Text("\(bookingManager.totalPrice) đ")
                    .font(.title3)
                    .fontWeight(.heavy)
                    .foregroundColor(.blue)
            }
            
            Button(action: { bookingManager.clearAllTickets() }) {
                Text("LÀM TRỐNG GIỎ VÉ")
                    .font(.caption)
                    .bold()
                    .foregroundColor(.white)
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(bookingManager.selectedTickets.isEmpty ? Color.gray.opacity(0.3) : Color.red)
                    .cornerRadius(10)
            }
            .disabled(bookingManager.selectedTickets.isEmpty)
        }
        .padding()
        .background(Color(.systemGray6))
        .cornerRadius(16)
    }
}

// ==========================================
// 4. MÀN HÌNH ORCHESTRATOR: ĐIỀU PHỐI TOÀN BỘ HỆ THỐNG CINEHUB"
// ==========================================
enum FocusField {
    case email
}

struct CineHubStoreView: View {
    @AppStorage("hasSeenOnboarding") private var hasSeenOnboarding: Bool = false
    @AppStorage("saved_user_email") private var savedEmail: String = ""
    
    @State private var bookingManager = CineBookingManager()
    @State private var showWelcomeAlert = false
    @FocusState private var activeField: FocusField?
    
    let movieList = [
        "Avatar: Dòng Chảy Của Nước",
        "Oppenheimer: Kẻ Hủy Diệt Thế Giới",
        "Dune: Hành Tinh Cát - Phần 2"
    ]
    
    var body: some View {
        NavigationStack {
            VStack {
                Form {
                    Section(header: Text("Thông tin định danh")) {
                        TextField("Nhập địa chỉ Email", text: $savedEmail)
                            .keyboardType(.emailAddress)
                            .focused($activeField, equals: .email)
                    }
                    
                    Section(header: Text("Sự kiện phim ảnh nổi bật")) {
                        ForEach(movieList, id: \.self) { movieTitle in
                            MovieRowComponent(movieTitle: movieTitle) {
                                withAnimation(.spring()) {
                                    bookingManager.addTicket(for: movieTitle)
                                }
                            }
                        }
                    }
                    .listRowBackground(Color.clear)
                    
                    Section {
                        BookingCartSummaryView()
                    }
                    .listRowBackground(Color.clear)
                }
            }
            .navigationTitle("CineHub Booking")
            .environment(bookingManager) // Phủ sóng dữ liệu xuống toàn cây View
            .onAppear {
                if !hasSeenOnboarding {
                    showWelcomeAlert = true
                    hasSeenOnboarding = true
                }
                
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.6) {
                    activeField = .email
                }
            }
            .alert("Chào mừng bạn đến với CineHub!", isPresented: $showWelcomeAlert) {
                Button("Bắt đầu đặt vé", role: .cancel) { }
            } message: {
                Text("Quy trình quản lý dữ liệu chuẩn UDF đã sẵn sàng đồng hành cùng bạn.")
            }
        }
    }
}

#Preview {
    CineHubStoreView()
}
