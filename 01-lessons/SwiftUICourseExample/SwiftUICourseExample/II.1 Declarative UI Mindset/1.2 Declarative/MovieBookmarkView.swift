//
//  MovieBookmarkView.swift
//  SwiftUICourseExample
//
//  Created by le.hong.van on 27/7/26.
//

import SwiftUI

// Cách làm mới trong SwiftUI (Declarative)
struct MovieBookmarkView: View {
    @State private var isBookmarked = false // Đây là State
    
    var body: some View {
        VStack(spacing: 20) {
            // View tự động thay đổi dựa trên State isBookmarked
            Text(isBookmarked ? "Đã lưu" : "Chưa lưu")
                .foregroundColor(isBookmarked ? .green : .primary)
            
            if !isBookmarked {
                Button("Lưu phim") {
                    isBookmarked = true // Chỉ cần thay đổi State!
                }
            }
        }
    }
}

#Preview {
    MovieBookmarkView()
}
