# 📱 App FinGo - Quản Lý Tài Chính & Thanh Toán Điện Tử

**FinGo** là một ứng dụng di động đa nền tảng được phát triển bằng **Flutter**, giúp người dùng quản lý tài chính cá nhân, mô phỏng thanh toán điện tử và biến việc ghi chép chi tiêu nhàm chán thành một trải nghiệm thú vị (Gamification).

## ✨ Tính năng nổi bật

*   🔐 **Xác thực người dùng:** Trải nghiệm thiết kế mượt mà với các màn hình Giới thiệu (Intro), Đăng nhập và Đăng ký.
*   💰 **Quản lý thu chi & Số dư:** 
    *   Ghi chép các khoản thu/chi dễ dàng.
    *   Hệ thống cảnh báo thông minh khi tiêu xài vượt quá số dư (bằng cửa sổ Pop-up giữa màn hình) hoặc khi số dư dưới mức an toàn (100.000đ).
*   🧾 **Thanh toán Hóa đơn:** Mô phỏng thanh toán các hóa đơn thực tế (Tiền trọ, điện nước) với thao tác một chạm, tự động trừ tiền trong ví.
*   📷 **Quét mã QR:** Mô phỏng tính năng quét mã tĩnh tiện lợi để thanh toán nhanh chóng.
*   📊 **Thống kê trực quan:** Tra cứu báo cáo thu chi theo Tuần/Tháng/Năm, thiết lập hạn mức ngân sách sinh hoạt an toàn.
*   🎮 **Học Viện Tài Chính (Gamification):** Tham gia giải đố các câu hỏi trắc nghiệm tài chính được chọn lọc ngẫu nhiên theo các chủ đề bổ ích, giúp nâng cao kiến thức quản lý tiền bạc.
*   ⚙️ **Cá nhân hóa:** Hỗ trợ tùy chỉnh giao diện Tối/Sáng (Dark mode), Cài đặt ngôn ngữ (mặc định Tiếng Việt), Điều khoản sử dụng và Trung tâm trợ giúp tiện lợi.

## 🛠 Công nghệ sử dụng

*   **Framework:** [Flutter](https://flutter.dev/)
*   **Ngôn ngữ lập trình:** [Dart](https://dart.dev/)
*   **Fonts/UI:** Material Design 3, Google Fonts (Nunito).

## 🚀 Hướng dẫn cài đặt

Làm theo các bước sau để khởi chạy dự án trên máy tính của bạn:

**1. Yêu cầu hệ thống:**
*   Cài đặt Flutter SDK phiên bản mới nhất.
*   Cài đặt sẵn tệp thiết lập SDK Android trên Android Studio (dành cho giả lập Android) hoặc Xcode (Dành cho iOS).

**2. Các lệnh khởi động:**

```bash
# Clone dự án về máy
git clone https://github.com/lttc1357/App-FinGo-.git

# Di chuyển vào thư mục chứa code Frontend
cd "App-FinGo-/AppTC/mobile"

# Tải các gói thư viện phụ thuộc (Dependencies)
flutter pub get

# Chạy ứng dụng (Đảm bảo đã kết nối máy ảo hoặc thiết bị thật)
flutter run
```

## 📌 Khuyến cáo dự án
*   Dự án được xây dựng dành cho đồ án môn học liên quan đến **Thanh toán điện tử**.
*   Mọi tính năng xử lý giao dịch, trừ tiền hoàn toàn được thiết kế dưới dạng giả lập, không liên kết với các thẻ ngân hàng thực.

---
⭐ *Nếu bạn thấy dự án hữu ích, hãy để lại 1 Star cho Repository này nhé!*