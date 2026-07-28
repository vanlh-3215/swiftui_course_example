//
//  MovieCardView.swift
//  SwiftUICourseExample
//
//  Created by le.hong.van on 28/7/26.
//

import SwiftUI

struct MovieEventCardView: View {
    @State private var isBookmarked: Bool = false
    
    var body: some View {
        // TODO: Nhiệm vụ 1 - Xếp chồng Poster và Text theo chiều dọc
        VStack(alignment: .leading, spacing: 0) {
            ZStack(alignment: .topTrailing) {
                Rectangle()
                    .fill(LinearGradient(colors: [Color.black, Color.indigo], startPoint: .top, endPoint: .bottom))
                    .frame(height: 180)
                
                Image(systemName: "film.stack")
                    .font(.system(size: 60))
                    .foregroundColor(.white.opacity(0.12))
                    .offset(x: -110, y: 40)
                
                HStack {
                    HStack(spacing: 4) {
                        Image(systemName: "star.fill").foregroundColor(.yellow)
                        Text("8.5").fontWeight(.bold)
                    }
                    .font(.caption).foregroundColor(.white).padding(.horizontal, 10)
                    .padding(.vertical, 5).background(Color.black.opacity(0.6)).cornerRadius(8)
                    
                    Spacer()
                    
                    Button(action: {
                        // TODO: Nhiệm vụ 2 - Đảo trạng thái với animation mượt mà
                    }) {
                        // TODO: Nhiệm vụ 3 - Dùng toán tử 3 ngôi cho icon
                        Image(systemName: "bookmark")
                            .font(.system(size: 16, weight: .bold))
                        // TODO: Nhiệm vụ 4 - Sắp xếp Modifier (padding, background, clipShape)
                    }
                }.padding(12)
            }
            
            VStack(alignment: .leading, spacing: 8) {
                Text("AVATAR: DÒNG CHẢY CỦA NƯỚC")
                    .font(.headline).lineLimit(1)
                    // TODO: Nhiệm vụ 5 - Nâng độ ưu tiên hiển thị
                
                HStack {
                    Image(systemName: "popcorn.fill").foregroundColor(.orange)
                    Text("Khoa học viễn tưởng - 192 phút")
                        .font(.subheadline).foregroundColor(.secondary)
                    Spacer()
                    Text("Vé: 120k").font(.subheadline).fontWeight(.semibold).foregroundColor(.blue)
                }
            }.padding(16)
        }
        .background(Color(.systemBackground)).cornerRadius(16)
        .shadow(color: Color.black.opacity(0.1), radius: 8, x: 0, y: 4).padding()
    }
}

#Preview {
    MovieEventCardView()
}
