//
//  TMDBNetworkService.swift
//  SwiftUICourseExample
//
//  Created by le.hong.van on 27/7/26.
//

import Foundation

class TMDBNetworkService {
    private var completionHandler: (([String]) -> Void)?
    
    func request(completion: @escaping ([String]) -> Void) {
        print("TMDBNetworkService bắt đầu giả lập gọi API lấy danh sách phim.")
        
        // Giả lập service giữ lại closure để chạy sau khi API trả kết quả.
        // Nếu closure capture mạnh self, ViewModel -> Service -> Closure -> ViewModel sẽ tạo retain cycle.
        completionHandler = completion
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) { [weak self] in
            self?.completionHandler?([
                "Avatar: Dòng Chảy Của Nước",
                "Dune: Part Two",
                "Inside Out 2"
            ])
        }
    }
    
    deinit {
        print("TMDBNetworkService giải phóng bộ nhớ!")
    }
}
