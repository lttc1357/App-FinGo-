import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class TermsConditionsScreen extends StatelessWidget {
  const TermsConditionsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    final bgColor = isDark ? const Color(0xFF1E1E1E) : const Color(0xFFF8F9FE);
    final textColor = isDark ? Colors.white : const Color(0xFF2D3142);
    final contentColor = isDark ? Colors.grey.shade300 : Colors.grey.shade700;

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
          'Điều khoản & Quy định',
          style: GoogleFonts.nunito(
            color: textColor,
            fontWeight: FontWeight.w800,
            fontSize: 22,
          ),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildSectionTitle('1. Giới thiệu chung', textColor),
            _buildSectionContent(
              'Chào mừng bạn đến với ứng dụng quản lý tài chính của chúng tôi. Việc bạn sử dụng ứng dụng đồng nghĩa với việc bạn đồng ý tuân thủ các điều khoản và quy định dưới đây. Vui lòng đọc kỹ trước khi sử dụng bất kỳ tính năng nào.',
              contentColor,
            ),
            const SizedBox(height: 20),
            
            _buildSectionTitle('2. Quy định sử dụng ứng dụng', textColor),
            _buildSectionContent(
              '• Người dùng cam kết cung cấp thông tin cá nhân chính xác và tự chịu trách nhiệm về các thông tin này.\n'
              '• Ứng dụng cung cấp các tính năng hỗ trợ ghi chép thu chi, lên ngân sách, và theo dõi tài chính cá nhân.\n'
              '• Tuyệt đối không được sử dụng ứng dụng vào các mục đích bất hợp pháp, lừa đảo, hoặc các hành vi gây hại đến hệ thống.',
              contentColor,
            ),
            const SizedBox(height: 20),

            _buildSectionTitle('3. Quy định khi chuyển tiền và giao dịch', textColor),
            _buildSectionContent(
              '• Khi thực hiện các thao tác chuyển khoản, thanh toán qua mã QR, người dùng cần kiểm tra kỹ lưỡng thông tin người nhận (tên, số điện thoại, số tài khoản, số tiền) TRƯỚC VÀ SAU KHI quét mã nhằm đảm bảo tính chính xác.\n'
              '• Ứng dụng không chịu trách nhiệm đối với các sai sót/mất mát do người dùng thao tác nhầm lẫn, nhập sai thông tin giao dịch.\n'
              '• Mọi giao dịch đã được xác nhận thành công sẽ phải tuân theo chính sách hoàn/hủy từ phía các đối tác trung gian xử lý thanh toán của bạn (ngân hàng, ví điện tử,...).',
              contentColor,
            ),
            const SizedBox(height: 20),

            _buildSectionTitle('4. Quyền riêng tư & Bảo mật dữ liệu', textColor),
            _buildSectionContent(
              '• Chúng tôi cam kết bảo vệ thông tin cá nhân và dữ liệu tài chính của bạn.\n'
              '• Dữ liệu của bạn được mã hóa và chỉ dùng cho mục đích cá nhân hóa cũng như đồng bộ hóa trải nghiệm trên ứng dụng.\n'
              '• Chúng tôi không mua bán hoặc chia sẻ dữ liệu của bạn cho bất kỳ bên thứ ba nào khi chưa có sự cho phép của bạn, trừ những trường hợp bắt buộc phải có theo yêu cầu của cơ quan pháp luật có thẩm quyền.',
              contentColor,
            ),
            const SizedBox(height: 20),

            _buildSectionTitle('5. Trách nhiệm của người dùng', textColor),
            _buildSectionContent(
              '• Bạn có trách nhiệm bảo mật an toàn tài khoản và mật khẩu/mã PIN của mình đang dùng để đăng nhập vào ứng dụng.\n'
              '• Trong trường hợp nghi ngờ hoặc phát hiện có truy cập trái phép, bạn cần tiến hành đăng xuất hoặc liên hệ bộ phận hỗ trợ ngay lập tức để có biện pháp can thiệp sớm nhất (khóa tài khoản).',
              contentColor,
            ),
            const SizedBox(height: 40),
            
            Center(
              child: Text(
                'Cập nhật lần cuối: Tháng 4, 2026',
                style: GoogleFonts.nunito(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  color: Colors.grey,
                  fontStyle: FontStyle.italic,
                ),
              ),
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  Widget _buildSectionTitle(String title, Color textColor) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: Text(
        title,
        style: GoogleFonts.nunito(
          fontSize: 18,
          fontWeight: FontWeight.w700,
          color: textColor,
        ),
      ),
    );
  }

  Widget _buildSectionContent(String content, Color contentColor) {
    return Text(
      content,
      style: GoogleFonts.nunito(
        fontSize: 15,
        height: 1.5,
        color: contentColor,
      ),
    );
  }
}