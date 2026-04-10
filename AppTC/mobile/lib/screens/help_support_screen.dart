import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../theme.dart';

class HelpSupportScreen extends StatelessWidget {
  const HelpSupportScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    final bgColor = isDark ? const Color(0xFF1E1E1E) : const Color(0xFFF8F9FE);
    final cardColor = isDark ? const Color(0xFF2C2C2C) : Colors.white;
    final textColor = isDark ? Colors.white : const Color(0xFF2D3142);

    final List<Map<String, String>> faqs = [
      {
        'question': 'Làm thế nào để thêm một giao dịch chi tiêu mới?',
        'answer': 'Bạn có thể nhấn vào nút "+" màu xanh ở giữa thanh menu dưới cùng (nút "Thêm Chi") để nhập thông tin về số tiền, danh mục và ghi chú cho giao dịch.',
      },
      {
        'question': 'Làm thế nào để đổi sang chế độ ban đêm?',
        'answer': 'Vào trang "Cá nhân", tìm phần "Cài đặt ứng dụng" và gạt nút công tắc ở mục "Chế độ ban đêm" để thay đổi giao diện sáng/tối theo ý thích của bạn.',
      },
      {
        'question': 'Chức năng "Thông báo rớt ví" hoạt động như thế nào?',
        'answer': 'Chức năng này sẽ gửi cảnh báo đến điện thoại của bạn khi bạn chi tiêu vượt quá mức độ an toàn của giới hạn ngân sách đã thiết lập, giúp bạn kiểm soát tài chính tự động.',
      },
      {
        'question': 'Làm sao để thay đổi ngôn ngữ của ứng dụng?',
        'answer': 'Hiện tại ứng dụng chỉ hỗ trợ Tiếng Việt với mục tiêu mang đến trải nghiệm tốt nhất cho người dùng Việt Nam. Các ngôn ngữ khác sẽ được cập nhật trong tương lai.',
      },
      {
        'question': 'Các biểu đồ trong phần Thống kê hiển thị thông tin gì?',
        'answer': 'Biểu đồ hiển thị tổng quan thu chi của bạn theo Tuần, Tháng hoặc Năm. Giới hạn ngân sách và danh sách các khoản chi tiêu nhiều nhất cũng được thống kê chi tiết.',
      },
      {
        'question': 'Tôi có thể xem lại lịch sử các giao dịch bằng cách nào?',
        'answer': 'Ở Trang Chủ, hãy cuộn xuống phần "Giao dịch gần đây". Tại đây sẽ liệt kê danh sách các giao dịch thanh toán hoặc thu nhập bạn đã thực hiện.',
      },
      {
        'question': 'Điểm FinPoints và Pet dùng để làm gì?',
        'answer': 'Điểm FinPoints nhận được sau các giao dịch hoặc nhiệm vụ có thể sử dụng để tham gia các trò chơi tài chính trong tab "Trò chơi" giúp bạn vừa giải trí vừa làm giàu kiến thức.',
      },
      {
        'question': 'Làm thế nào để quét mã thanh toán QR?',
        'answer': 'Tại Trang Chủ, chọn tính năng "Quét mã". Sau khi camera quét mã thành công, ứng dụng sẽ hiện ra màn hình điền thông tin để bạn xác nhận thanh toán.',
      },
    ];

    return Scaffold(
      backgroundColor: bgColor,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: textColor),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          'Trợ Giúp & Hỗ Trợ',
          style: GoogleFonts.nunito(
            color: textColor,
            fontWeight: FontWeight.w800,
            fontSize: 22,
          ),
        ),
      ),
      body: ListView.builder(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
        itemCount: faqs.length,
        itemBuilder: (context, index) {
          return Container(
            margin: const EdgeInsets.only(bottom: 12),
            decoration: BoxDecoration(
              color: cardColor,
              borderRadius: BorderRadius.circular(16),
              boxShadow: [
                BoxShadow(
                  color: isDark ? Colors.black12 : Colors.grey.withValues(alpha: 0.1),
                  blurRadius: 10,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: ExpansionTile(
              shape: const Border(), // Xóa viền đen mặc định của ExpansionTile khi mở
              collapsedShape: const Border(),
              iconColor: AppTheme.primary,
              collapsedIconColor: isDark ? Colors.grey.shade400 : Colors.grey.shade600,
              title: Text(
                faqs[index]['question']!,
                style: GoogleFonts.nunito(
                  fontWeight: FontWeight.w700,
                  fontSize: 16,
                  color: textColor,
                ),
              ),
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 16.0, right: 16.0, bottom: 16.0),
                  child: Text(
                    faqs[index]['answer']!,
                    style: GoogleFonts.nunito(
                      height: 1.5,
                      fontSize: 15,
                      color: isDark ? Colors.grey.shade300 : Colors.grey.shade700,
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
