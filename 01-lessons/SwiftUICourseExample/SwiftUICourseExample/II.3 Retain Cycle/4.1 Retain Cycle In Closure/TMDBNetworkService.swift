//
//  TMDBNetworkService.swift
//  SwiftUICourseExample
//
//  Created by le.hong.van on 27/7/26.
//

import Foundation

class TMDBNetworkService {
    var onDataLoaded: (([String]) -> Void)?
    
    func requestData() {
        // Giả lập sau 2 giây tải dữ liệu xong từ TMDB API
        DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
            self.onDataLoaded?(["Avatar", "Oppenheimer", "Dune"])
        }
    }

    
    deinit {
        print("TMDBNetworkService giải phóng bộ nhớ!")
    }
}
