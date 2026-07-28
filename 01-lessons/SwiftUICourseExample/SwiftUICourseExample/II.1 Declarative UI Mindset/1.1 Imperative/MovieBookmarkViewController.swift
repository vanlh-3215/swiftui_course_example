//
//  MovieBookmarkViewController.swift
//  SwiftUICourseExample
//
//  Created by le.hong.van on 27/7/26.
//

import UIKit

// Cách làm cũ trong UIKit (Imperative)
class MovieBookmarkViewController: UIViewController {
    @IBOutlet weak var bookmarkLabel: UILabel!
    @IBOutlet weak var bookmarkButton: UIButton!
    
    @IBAction func bookmarkButtonTapped(_ sender: UIButton) {
        // Bước 1: Thay đổi dữ liệu trong đầu bạn (hoặc Model)
        let isBookmarked = true
        
        // Bước 2: Tự tay cập nhật từng thành phần UI tương ứng
        bookmarkLabel.text = "Đã lưu"
        bookmarkLabel.textColor = .green
        
        // Bước 3: Ẩn nút bấm đi
        bookmarkButton.isHidden = true
    }
}
