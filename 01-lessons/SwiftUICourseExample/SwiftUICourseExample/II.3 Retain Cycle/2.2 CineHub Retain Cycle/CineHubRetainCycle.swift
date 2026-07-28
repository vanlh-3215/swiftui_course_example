//
//  CineHubRetainCycle.swift
//  SwiftUICourseExample
//
//  Created by le.hong.van on 27/7/26.
//

import SwiftUI

class User {
    let name: String
    var wallet: CineWallet? // Tham chiếu mạnh mặc định
    
    init(name: String) {
        self.name = name
        print("Người dùng \(name) được khởi tạo bộ nhớ.")
    }
    
    deinit {
        print("Người dùng \(name) đã giải phóng hoàn toàn bộ nhớ!")
    }
}

class CineWallet {
    let walletID: String
    var owner: User? // Tham chiếu mạnh mặc định
    
    init(walletID: String) {
        self.walletID = walletID
        print("Ví CineWallet \(walletID) được khởi tạo bộ nhớ.")
    }
    
    deinit {
        print("Ví CineWallet \(walletID) đã giải phóng hoàn toàn bộ nhớ!")
    }
}

struct CineHubRetainCycleView: View {
    @State private var didRunMemoryTest = false
    
    var body: some View {
        VStack(spacing: 20) {
            Text("CineHub Retain Cycle")
                .font(.title2)
                .fontWeight(.bold)
            
            Text("Nhấn nút để chạy runMemoryTest() và xem log trong console.")
                .multilineTextAlignment(.center)
                .foregroundStyle(.secondary)
            
            Button("Chạy Memory Test") {
                runMemoryTest()
                didRunMemoryTest = true
            }
            .buttonStyle(.borderedProminent)
            
            if didRunMemoryTest {
                Text("Đã chạy memory test. Kiểm tra console để thấy retain cycle.")
                    .font(.footnote)
                    .foregroundStyle(.green)
                    .multilineTextAlignment(.center)
            }
        }
        .padding()
    }
}

func runMemoryTest() {
    // 1. Khởi tạo 2 đối tượng (Reference Count của mỗi đối tượng = 1)
    var john: User? = User(name: "John")
    var wallet101: CineWallet? = CineWallet(walletID: "CW-101")
    
    // 2. Tạo mối quan hệ sở hữu lẫn nhau (Retain Cycle bắt đầu)
    john?.wallet = wallet101       // Reference Count của wallet101 tăng lên 2
    wallet101?.owner = john        // Reference Count của john tăng lên 2
    
    // 3. Hủy biến tham chiếu gốc ngoài scope
    print("--- Tiến hành gán nil ---")
    john = nil
    wallet101 = nil
    
    // Đáng lý ra bộ nhớ phải được giải phóng, nhưng hàm deinit không hề chạy!
}

#Preview {
    CineHubRetainCycleView()
}
