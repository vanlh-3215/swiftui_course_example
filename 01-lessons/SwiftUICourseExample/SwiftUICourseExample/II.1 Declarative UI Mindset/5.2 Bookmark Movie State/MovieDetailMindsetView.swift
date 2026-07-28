//
//  MovieDetailMindsetView.swift
//  SwiftUICourseExample
//
//  Created by le.hong.van on 27/7/26.
//

import SwiftUI

struct MovieDetailMindsetView: View {
    // Giả sử có 1 biến isBookmarked để lưu trạng thái bookmark của phim ở 1 nơi nào đó (Local Storage / API)
    // Trong ví dụ SwiftUI này, ta dùng @State để view tự cập nhật lại khi giá trị thay đổi.
    @State private var isBookmarked: Bool = false
    
    var body: some View {
        VStack(spacing: 20) {
            // Giả lập poster phim CineHub
            RoundedRectangle(cornerRadius: 15)
                .fill(Color.indigo)
                .frame(width: 200, height: 300)
                .overlay(
                    Image(systemName: "film")
                        .font(.system(size: 80))
                        .foregroundColor(.white.opacity(0.3))
                )
            
            Text("Avatar: Dòng Chảy Của Nước")
                .font(.title2)
                .fontWeight(.bold)
            
            // 2. Nút bấm tương tác phát action thay đổi lõi State
            Button(action: {
                // Với cơ chế Declarative, ta chỉ cần toggle giá trị State, UI sẽ tự vẽ lại
                withAnimation(.spring(response: 0.3, dampingFraction: 0.5)) {
                    isBookmarked.toggle()
                }
            }) {
                HStack {
                    Image(systemName: isBookmarked ? "heart.fill" : "heart")
                        .foregroundColor(isBookmarked ? .red : .gray)
                    Text(isBookmarked ? "Đã Thêm Vào Yêu Thích" : "Yêu Thích Phim")
                        .fontWeight(.semibold)
                }
                .padding()
                .background(isBookmarked ? Color.red.opacity(0.1) : Color.gray.opacity(0.1))
                .cornerRadius(10)
            }
        }
        .padding()
    }
}

#Preview {
    MovieDetailMindsetView()
}
