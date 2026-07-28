//
//  CineHubAppDelegate.swift
//  SwiftUICourseExample
//
//  Created by le.hong.van on 27/7/26.
//

import SwiftUI

// 1.3 - 1. Khai báo một Delegate thích ứng UIKit truyền thống để xử lý các dịch vụ sâu
class CineHubAppDelegate: NSObject, UIApplicationDelegate {
    func application(
        _ application: UIApplication,
        didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]? = nil
    ) -> Bool {
        // Đây là nơi hoàn hảo để cấu hình SDK bên thứ ba ngay khi hệ thống vừa khởi chạy xong
        print("[AppDelegate]: Đã cấu hình Firebase SDK và hệ thống Push Notification thành công cho CineHub!")
        return true
    }
    
    func application(
        _ application: UIApplication,
        didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data
    ) {
        print("[AppDelegate]: Đã nhận Device Token cho Push Notification.")
    }
}

// 1.3 - 2. Nhúng Adaptor vào cấu trúc khởi chạy SwiftUI hiện đại
// Lưu ý: Chỉ thêm @main khi đây là App entry point duy nhất của project.
struct CineHubApp: App {
    // 1.3 - 3. Kết nối AppDelegate cũ vào trong cấu trúc App mới
    @UIApplicationDelegateAdaptor(CineHubAppDelegate.self) var appDelegate
    
    // 3.2 - 1. Khai báo biến môi trường lắng nghe trạng thái của Scene
    @Environment(\.scenePhase) private var currentPhase

    
    var body: some Scene {
        WindowGroup {
            ContentView()
            // 3.2 - 2. Lắng nghe sự thay đổi của currentPhase (Cú pháp hiện đại iOS 17+)
            .onChange(of: currentPhase) { oldPhase, newPhase in
                switch newPhase {
                case .active:
                    print("App CineHub đang hoạt động: Làm mới dữ liệu phim từ TMDB, kết nối lại Socket.")
                case .inactive:
                    print("App CineHub tạm dừng tương tác: Giảm bớt các hiệu ứng chuyển động trailer để tiết kiệm pin.")
                case .background:
                    print("App CineHub đã vào nền: Lưu trạng thái đặt vé, đóng luồng ghi file/database để tránh mất dữ liệu.")
                @unknown default:
                    print("Trạng thái hệ thống mới xuất hiện trong tương lai.")
                }
            }
        }
    }
}
