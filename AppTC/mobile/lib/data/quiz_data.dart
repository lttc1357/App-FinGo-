import 'package:flutter/material.dart';
import '../theme.dart';

class Question {
  final String text;
  final List<String> answers;
  final int correctAnswerIndex;

  const Question({
    required this.text,
    required this.answers,
    required this.correctAnswerIndex,
  });
}

class LessonData {
  final String title;
  final String durationText;
  final IconData icon;
  final Color bgColor;
  final Color iconColor;
  final List<Question> questions;

  const LessonData({
    required this.title,
    required this.durationText,
    required this.icon,
    required this.bgColor,
    required this.iconColor,
    required this.questions,
  });
}

final List<LessonData> academyLessons = [
  LessonData(
    title: 'Tiết kiệm 101:\nQuy tắc\n50/30/20',
    durationText: '30 GIÂY',
    icon: Icons.savings,
    bgColor: AppTheme.primary.withValues(alpha: 0.1),
    iconColor: AppTheme.primary,
    questions: const [
      Question(
        text: 'Trong quy tắc 50/30/20, con số 50 đại diện cho nhóm chi phí nào?',
        answers: ['Nhu cầu thiết yếu (Needs)', 'Sở thích cá nhân (Wants)', 'Tiết kiệm và đầu tư (Savings)', 'Trả nợ ngân hàng'],
        correctAnswerIndex: 0,
      ),
      Question(
        text: 'Chi phí nào sau đây được xếp vào nhóm 30% (Sở thích)?',
        answers: ['Tiền thuê nhà và điện nước', 'Đi xem phim và ăn hàng', 'Gửi tiền vào quỹ hưu trí', 'Học phí chính quy'],
        correctAnswerIndex: 1,
      ),
      Question(
        text: 'Nhóm 20% trong quy tắc này nên được ưu tiên sử dụng cho mục đích gì?',
        answers: ['Mua sắm quần áo mới', 'Nâng cấp gói internet', 'Xây dựng quỹ khẩn cấp', 'Chi trả bảo hiểm y tế'],
        correctAnswerIndex: 2,
      ),
      Question(
        text: 'Quy tắc 50/30/20 nên được áp dụng trên mức thu nhập nào?',
        answers: ['Thu nhập trước thuế (Gross Income)', 'Tổng doanh thu kinh doanh', 'Thu nhập sau thuế (Take-home pay)', 'Thu nhập cộng cả tiền vay'],
        correctAnswerIndex: 2,
      ),
      Question(
        text: 'Nếu chi phí thiết yếu của bạn chiếm tới 70% thu nhập, hành động nào đúng nhất theo tinh thần quy tắc này?',
        answers: ['Cắt giảm tối đa nhóm 30% sở thích', 'Vay thêm tiền để đủ 20% tiết kiệm', 'Bỏ qua luôn việc tiết kiệm', 'Tăng chi tiêu sở thích lên 40%'],
        correctAnswerIndex: 0,
      ),
      Question(
        text: 'Nếu bạn nhận được một khoản tiền thưởng đột xuất (Bonus), theo quy tắc 50/30/20, bạn nên ưu tiên làm gì?',
        answers: ['Dùng 50% số tiền đó để nâng cấp đồ gia dụng trong nhà', 'Dùng 100% để mua sắm món đồ mình thích từ lâu', 'Phân bổ theo tỷ lệ cũ hoặc ưu tiên dồn vào nhóm 20% (Tiết kiệm/Trả nợ)', 'Giữ toàn bộ tiền mặt trong ví để chi tiêu dần'],
        correctAnswerIndex: 2,
      ),
      Question(
        text: 'Việc trả phí đăng ký các dịch vụ giải trí hàng tháng (Netflix, Spotify, Gym) thuộc nhóm nào?',
        answers: ['Nhu cầu thiết yếu (50%)', 'Sở thích cá nhân (30%)', 'Tiết kiệm (20%)', 'Đầu tư cho tương lai'],
        correctAnswerIndex: 1,
      ),
      Question(
        text: 'Tại sao quy tắc 50/30/20 lại được coi là "linh hoạt" đối với người mới bắt đầu?',
        answers: ['Vì bạn có thể bỏ qua nhóm tiết kiệm nếu thấy khó khăn', 'Vì nó giúp bạn phân biệt rõ ràng giữa "Cần" (Needs) và "Muốn" (Wants)', 'Vì nó cho phép bạn vay tiền để bù vào các nhóm chi tiêu', 'Vì tỷ lệ này bắt buộc phải giống nhau cho tất cả mọi người trên thế giới'],
        correctAnswerIndex: 1,
      ),
      Question(
        text: 'Trong nhóm 20% (Tiết kiệm), hành động nào nên được thực hiện đầu tiên nếu bạn đang có nợ xấu lãi suất cao?',
        answers: ['Gửi tiết kiệm ngân hàng lấy lãi hàng tháng', 'Đầu tư vào thị trường chứng khoán ngay lập tức', 'Ưu tiên trả dứt điểm các khoản nợ có lãi suất cao (như thẻ tín dụng)', 'Mua bảo hiểm nhân thọ cho cả gia đình'],
        correctAnswerIndex: 2,
      ),
      Question(
        text: '"Bẫy chi tiêu" lớn nhất khiến mọi người thất bại khi áp dụng quy tắc 50/30/20 là gì?',
        answers: ['Để nhóm Nhu cầu (50%) lấn sang các nhóm khác do lối sống quá xa xỉ', 'Tiết kiệm quá nhiều dẫn đến không có tiền chi tiêu hàng ngày', 'Không có tài khoản ngân hàng để chuyển tiền vào', 'Giá xăng dầu giảm mạnh khiến việc tính toán bị sai lệch'],
        correctAnswerIndex: 0,
      ),
    ],
  ),
  LessonData(
    title: 'Lạm phát là gì?\nVì sao giá\ntăng?',
    durationText: '45 GIÂY',
    icon: Icons.trending_up,
    bgColor: AppTheme.error.withValues(alpha: 0.12),
    iconColor: AppTheme.error,
    questions: const [
      Question(
        text: 'Hiểu một cách đơn giản nhất, lạm phát là gì?',
        answers: ['Sự giảm giá liên tục của hàng hóa thiết yếu', 'Sự tăng mức giá chung một cách liên tục của hàng hóa, dịch vụ', 'Chính phủ thắt chặt chi tiêu công', 'Tình trạng đổ xô mua vàng và ngoại tệ'],
        correctAnswerIndex: 1,
      ),
      Question(
        text: '"Lạm phát do cầu kéo" thường xảy ra khi nào?',
        answers: ['Chi phí nguyên liệu đầu vào tăng đột ngột', 'Người dân thắt chặt chi tiêu', 'Nhu cầu mua hàng vượt quá khả năng cung ứng', 'Chính phủ giảm lương cơ bản'],
        correctAnswerIndex: 2,
      ),
      Question(
        text: 'Hiện tượng giá cả tăng lên do chi phí sản xuất (lương, xăng dầu...) tăng được gọi là gì?',
        answers: ['Lạm phát cầu kéo', 'Lạm phát do tiền tệ', 'Lạm phát chi phí đẩy', 'Giảm phát'],
        correctAnswerIndex: 2,
      ),
      Question(
        text: 'Khi lạm phát xảy ra, giá trị đồng tiền (sức mua) của bạn sẽ thay đổi như thế nào?',
        answers: ['Sức mua tăng lên', 'Sức mua không đổi', 'Sức mua giảm xuống', 'Chỉ thay đổi với hàng nhập khẩu'],
        correctAnswerIndex: 2,
      ),
      Question(
        text: 'Ngân hàng Trung ương thường dùng công cụ nào để kiềm chế lạm phát?',
        answers: ['Giảm lãi suất ngân hàng', 'In thêm tiền cho người dân', 'Tăng lãi suất để giảm lượng tiền lưu thông', 'Khuyến khích vay nợ nhiều hơn'],
        correctAnswerIndex: 2,
      ),
      Question(
        text: 'Tại sao việc đứt gãy chuỗi cung ứng toàn cầu lại gây ra lạm phát?',
        answers: ['Vì hàng hóa khan hiếm trong khi nhu cầu giữ nguyên hoặc tăng', 'Vì công ty vận chuyển giảm giá cước', 'Vì nhà máy sản xuất quá nhiều hàng hóa', 'Vì người tiêu dùng không quan tâm hàng ngoại'],
        correctAnswerIndex: 0,
      ),
      Question(
        text: '"Lạm phát kỳ vọng" (Expected Inflation) có thể tự gây ra lạm phát thực tế vì lý do gì?',
        answers: ['Vì người dân sẽ chi tiêu ít đi để tiết kiệm tiền', 'Vì các doanh nghiệp chủ động tăng giá bán và công nhân đòi tăng lương sớm để dự phòng mất giá', 'Vì chính phủ sẽ giảm thuế để hỗ trợ người dân', 'Vì các ngân hàng sẽ ngừng cho vay vốn'],
        correctAnswerIndex: 1,
      ),
      Question(
        text: 'Hiện tượng "Siêu lạm phát" (Hyperinflation) thường được định nghĩa khi mức giá tăng bao nhiêu phần trăm mỗi tháng?',
        answers: ['Trên 5%', 'Trên 10%', 'Trên 50%', 'Trên 100%'],
        correctAnswerIndex: 2,
      ),
      Question(
        text: 'Trong điều kiện lạm phát cao, nhóm đối tượng nào thường được hưởng lợi "ngầm"?',
        answers: ['Người gửi tiết kiệm ngân hàng lãi suất cố định', 'Người đi vay nợ với lãi suất cố định từ trước', 'Những người có thu nhập thấp và cố định', 'Các nhà đầu tư giữ tiền mặt trong két sắt'],
        correctAnswerIndex: 1,
      ),
      Question(
        text: 'Mối quan hệ giữa lạm phát và tỷ giá hối đoái thường diễn ra như thế nào?',
        answers: ['Lạm phát cao thường khiến đồng nội tệ mất giá so với ngoại tệ', 'Lạm phát cao giúp đồng nội tệ mạnh lên', 'Tỷ giá hối đoái không bao giờ bị ảnh hưởng bởi lạm phát', 'Lạm phát càng cao thì xuất khẩu càng có lãi vì tiền có giá'],
        correctAnswerIndex: 0,
      ),
      Question(
        text: 'Tại sao một chút lạm phát (thường là khoảng 2%) lại được coi là dấu hiệu của một nền kinh tế khỏe mạnh?',
        answers: ['Để chính phủ có lý do thu thêm thuế', 'Để khuyến khích người dân chi tiêu và đầu tư thay vì tích trữ tiền mặt, thúc đẩy sản xuất', 'Để giúp các cửa hàng bán được hàng với giá đắt hơn', 'Để làm giảm giá trị các khoản nợ công của quốc gia'],
        correctAnswerIndex: 1,
      ),
    ],
  ),
  LessonData(
    title: 'Thanh toán nợ:\nTuyết lăn hay Ưu\ntiên?',
    durationText: '60 GIÂY',
    icon: Icons.account_balance_wallet,
    bgColor: AppTheme.tertiaryContainer.withValues(alpha: 0.2),
    iconColor: AppTheme.tertiary,
    questions: const [
      Question(
        text: 'Phương pháp "Nợ tuyết lăn" (Debt Snowball) tập trung vào việc trả dứt điểm khoản nợ nào đầu tiên?',
        answers: ['Khoản nợ có lãi suất cao nhất', 'Khoản nợ có số dư nhỏ nhất', 'Khoản nợ có thời gian vay lâu nhất', 'Khoản nợ vay từ người thân'],
        correctAnswerIndex: 1,
      ),
      Question(
        text: 'Ưu điểm lớn nhất của phương pháp "Nợ tuyết lăn" là gì?',
        answers: ['Tiết kiệm được nhiều tiền lãi nhất', 'Rút ngắn thời gian trả nợ tối đa', 'Tạo động lực tâm lý lớn', 'Được giảm lãi suất ưu đãi'],
        correctAnswerIndex: 2,
      ),
      Question(
        text: 'Phương pháp "Nợ ưu tiên" (Debt Avalanche) yêu cầu bạn thanh toán khoản nợ nào trước?',
        answers: ['Khoản nợ có số dư lớn nhất', 'Khoản nợ có lãi suất cao nhất', 'Khoản nợ sắp đến hạn nhất', 'Khoản nợ có phí phạt cao nhất'],
        correctAnswerIndex: 1,
      ),
      Question(
        text: 'Về mặt toán học, phương pháp nào giúp bạn tốn ít tiền lãi nhất trong suốt quá trình trả nợ?',
        answers: ['Nợ tuyết lăn (Snowball)', 'Trả nợ ngẫu nhiên', 'Nợ ưu tiên (Avalanche)', 'Chỉ trả mức tối thiểu'],
        correctAnswerIndex: 2,
      ),
      Question(
        text: 'Với các khoản nợ còn lại (ngoài khoản đang ưu tiên), bạn phải làm gì?',
        answers: ['Tạm dừng không trả', 'Chỉ trả khi có thông báo nhắc nợ', 'Duy trì trả mức tối thiểu (Minimum payment)', 'Đợi đến khi trả xong khoản ưu tiên mới tính tiếp'],
        correctAnswerIndex: 2,
      ),
      Question(
        text: 'Nếu dễ nản lòng và cần "chiến thắng nhỏ" để duy trì động lực, phương pháp nào phù hợp với bạn?',
        answers: ['Nợ ưu tiên (Avalanche)', 'Nợ tuyết lăn (Snowball)', 'Vay thêm nợ mới để đảo nợ', 'Ngẫu nhiên tùy tháng'],
        correctAnswerIndex: 1,
      ),
      Question(
        text: 'Nợ Thẻ tín dụng (lãi 25%), Nợ mua xe (lãi 8%), Nợ bạn bè (lãi 0%). Nếu dùng Debt Avalanche, thứ tự ưu tiên là gì?',
        answers: ['Bạn bè -> Xe -> Thẻ tín dụng', 'Thẻ tín dụng -> Xe -> Bạn bè', 'Xe -> Thẻ tín dụng -> Bạn bè', 'Trả đều 3 khoản'],
        correctAnswerIndex: 1,
      ),
      Question(
        text: 'Bước quan trọng nhất cần thực hiện TRƯỚC KHI bắt đầu trả nợ quyết liệt là gì?',
        answers: ['Khóa thẻ tín dụng và ngừng vay thêm', 'Đi vay khoản lớn hơn để trả', 'Mua sắm tự thưởng trước khi "khổ cực"', 'Đợi thu nhập tăng gấp đôi'],
        correctAnswerIndex: 0,
      ),
      Question(
        text: 'Khi áp dụng phương pháp Nợ ưu tiên (Avalanche), nếu hai khoản nợ có lãi suất bằng nhau, bạn nên ưu tiên khoản nào?',
        answers: ['Khoản nợ có số dư nhỏ hơn để kết thúc nhanh một đầu mục', 'Khoản nợ có số dư lớn hơn để giảm nợ gốc nhanh', 'Khoản nợ vay từ ngân hàng thay vì vay người thân', 'Không cần ưu tiên, trả khoản nào trước cũng được'],
        correctAnswerIndex: 0,
      ),
      Question(
        text: 'Điểm yếu lớn nhất của phương pháp Nợ ưu tiên (Avalanche) là gì?',
        answers: ['Tốn nhiều tiền trả lãi hơn so với Tuyết lăn', 'Thời gian để xóa sổ khoản nợ đầu tiên có thể rất lâu nếu đó là khoản nợ lớn, dễ gây nản lòng', 'Làm giảm điểm tín dụng của người vay', 'Không thể áp dụng nếu có quá 3 khoản nợ'],
        correctAnswerIndex: 1,
      ),
      Question(
        text: 'Trong phương pháp Nợ tuyết lăn (Snowball), sau khi trả xong khoản nợ nhỏ nhất, số tiền đó sẽ được dùng làm gì?',
        answers: ['Dùng để tự thưởng cho bản thân vì đã nỗ lực', 'Gửi vào tài khoản tiết kiệm để lấy lãi', 'Cộng dồn vào số tiền trả cho khoản nợ nhỏ kế tiếp', 'Giảm bớt cường độ làm việc vì gánh nặng đã nhẹ đi'],
        correctAnswerIndex: 2,
      ),
      Question(
        text: 'Thuật ngữ "Đảo nợ" (Debt Consolidation) thường được kết hợp với phương pháp nào để tối ưu hóa?',
        answers: ['Chỉ dùng được với Nợ tuyết lăn', 'Chỉ dùng được với Nợ ưu tiên', 'Có thể dùng với cả hai để gom nhiều khoản nợ lãi cao thành một khoản lãi thấp hơn', 'Không liên quan gì đến hai phương pháp này'],
        correctAnswerIndex: 2,
      ),
      Question(
        text: 'Nếu một khoản nợ có phí phạt chậm trả cực cao, bạn nên xử lý nó thế nào trong kế hoạch trả nợ?',
        answers: ['Xếp nó vào nhóm 30% sở thích', 'Luôn ưu tiên trả đúng hạn để tránh phát sinh chi phí ngoài ý muốn, bất kể đang theo phương pháp nào', 'Đợi đến khi trả xong các khoản nợ nhỏ mới xử lý phí phạt', 'Lờ đi vì phí phạt không tính vào lãi suất chính thức'],
        correctAnswerIndex: 1,
      ),
      Question(
        text: 'Tại sao việc liệt kê tất cả các khoản nợ kèm lãi suất và số dư là bước bắt buộc trước khi chọn phương pháp?',
        answers: ['Để khoe với bạn bè về tình hình tài chính', 'Để có cái nhìn tổng quan và chọn ra phương pháp phù hợp nhất với tâm lý và ngân sách cá nhân', 'Để ngân hàng thấy bạn là người có kế hoạch', 'Chỉ để cho biết mình đang nợ bao nhiêu tiền'],
        correctAnswerIndex: 1,
      ),
      Question(
        text: 'Theo các chuyên gia tài chính, yếu tố nào quyết định sự thành công của cả hai phương pháp này?',
        answers: ['Số tiền bạn nợ là bao nhiêu', 'Bạn chọn phương pháp nào trong hai cái', 'Sự kỷ luật và kiên trì duy trì kế hoạch hàng tháng', 'Sự biến động của thị trường chứng khoán'],
        correctAnswerIndex: 2,
      ),
      Question(
        text: 'Một người chọn Nợ tuyết lăn dù biết sẽ tốn thêm một ít tiền lãi so với Nợ ưu tiên, hành động này được gọi là gì?',
        answers: ['Sai lầm tài chính ngớ ngẩn', 'Đánh đổi chi phí lấy động lực tâm lý (Psychological Win)', 'Lãng phí tiền bạc không cần thiết', 'Không hiểu biết về toán học'],
        correctAnswerIndex: 1,
      ),
    ],
  ),
  LessonData(
    title: 'Chứng khoán:\nMua gì đầu tiên?',
    durationText: '50 GIÂY',
    icon: Icons.show_chart,
    bgColor: const Color(0xFFFFC697).withValues(alpha: 0.2),
    iconColor: const Color(0xFF8A4C00),
    questions: const [
      Question(
        text: 'Đối với người mới bắt đầu (F0), lựa chọn nào thường được khuyên dùng để an toàn hơn?',
        answers: ['Tất tay vào cổ phiếu vừa lên sàn', 'Quỹ chỉ số (ETF) hoặc Quỹ mở', 'Mua theo "phím hàng" trên mạng', 'Vay Margin để đầu cơ'],
        correctAnswerIndex: 1,
      ),
      Question(
        text: '"Cổ phiếu Blue-chip" dùng để chỉ nhóm cổ phiếu nào?',
        answers: ['Cổ phiếu rủi ro cực cao', 'Công ty lớn, uy tín và tài chính vững mạnh', 'Mức giá rẻ nhất thị trường', 'Mới niêm yết trong 1 tuần'],
        correctAnswerIndex: 1,
      ),
      Question(
        text: 'Hành động quan trọng nhất TRƯỚC KHI bạn đặt lệnh mua cổ phiếu đầu tiên là gì?',
        answers: ['Tìm hiểu doanh nghiệp và mô hình kinh doanh', 'Xem dự báo thời tiết', 'Chọn logo công ty đẹp', 'Chuẩn bị tâm lý giàu sau 1 đêm'],
        correctAnswerIndex: 0,
      ),
      Question(
        text: 'Quỹ ETF (Exchange Traded Fund) giúp nhà đầu tư thực hiện điều gì?',
        answers: ['Mua toàn bộ cổ phiếu toàn cầu', 'Đa dạng hóa danh mục chỉ với một lệnh mua', 'Đảm bảo lợi nhuận 100%', 'Nhận tiền lãi ngay lập tức'],
        correctAnswerIndex: 1,
      ),
      Question(
        text: 'Tại sao không nên dùng tiền vay mượn (Margin) ở những giao dịch đầu tiên?',
        answers: ['Ngân hàng sẽ lấy hết tiền lãi', 'Áp lực tâm lý và rủi ro mất trắng vốn nhanh hơn', 'Margin chỉ cho người đầu tư 10 năm', 'Pháp luật cấm'],
        correctAnswerIndex: 1,
      ),
      Question(
        text: 'Chỉ số P/E (Price-to-Earnings) thường dùng để đo lường điều gì?',
        answers: ['Tốc độ tăng trưởng doanh thu', 'Số lượng nhân viên', 'Mối quan hệ giữa giá thị trường và thu nhập trên mỗi cổ phiếu', 'Uy tín ban lãnh đạo'],
        correctAnswerIndex: 2,
      ),
      Question(
        text: 'Chiến lược "Trung bình giá" (DCA) nghĩa là gì?',
        answers: ['Chỉ mua ở mức đỉnh', 'Chia nhỏ vốn đầu tư định kỳ bất kể giá nào', 'Đợi giảm 50% mới mua', 'Bán hết ngay khi có lãi nhẹ'],
        correctAnswerIndex: 1,
      ),
      Question(
        text: 'Tại sao việc xác định "Khẩu vị rủi ro" lại quan trọng khi mới bắt đầu?',
        answers: ['Để biết mình nên đầu tư vào vàng hay bất động sản', 'Để chọn chiến lược đầu tư phù hợp với tâm lý và khả năng tài chính cá nhân', 'Để dự đoán chính xác ngày thị trường sẽ giảm điểm', 'Để được miễn phí thuế giao dịch chứng khoán'],
        correctAnswerIndex: 1,
      ),
      Question(
        text: 'Cổ phiếu "Penny" thường có đặc điểm gì mà người mới nên thận trọng?',
        answers: ['Giá rất thấp nhưng biến động cực mạnh và rủi ro cao', 'Luôn mang lại lợi nhuận gấp đôi trong thời gian ngắn', 'Là cổ phiếu của các tập đoàn đa quốc gia', 'Được chính phủ bảo đảm không bao giờ giảm giá'],
        correctAnswerIndex: 0,
      ),
      Question(
        text: 'Lợi nhuận từ việc đầu tư cổ phiếu thường đến từ hai nguồn nào?',
        answers: ['Tiền lãi ngân hàng và quà tặng từ công ty', 'Sự chênh lệch giá (mua thấp bán cao) và cổ tức', 'Tiền thưởng từ sàn giao dịch và phí môi giới', 'Chỉ duy nhất từ việc bán lại cổ phiếu với giá cao hơn'],
        correctAnswerIndex: 1,
      ),
      Question(
        text: 'Tại sao nhà đầu tư nên quan tâm đến "Lợi thế cạnh tranh" (Economic Moat) của doanh nghiệp?',
        answers: ['Vì những công ty này thường có trụ sở rất đẹp', 'Vì họ có khả năng duy trì lợi nhuận và vị thế trước các đối thủ lâu dài', 'Vì cổ phiếu của họ luôn rẻ nhất thị trường', 'Vì họ không bao giờ nợ ngân hàng'],
        correctAnswerIndex: 1,
      ),
      Question(
        text: 'Trong chứng khoán, việc "Cắt lỗ" (Stop-loss) được hiểu là gì?',
        answers: ['Mua thêm cổ phiếu khi giá đang giảm sâu', 'Chấp nhận bán cổ phiếu ở mức giá thấp hơn giá mua để bảo vệ vốn còn lại', 'Yêu cầu công ty trả lại tiền vì cổ phiếu giảm giá', 'Đợi đến khi giá hồi phục mới bán'],
        correctAnswerIndex: 1,
      ),
      Question(
        text: 'Bảng nào cho bạn biết Tài sản và Nợ của công ty tại một thời điểm nhất định?',
        answers: ['Báo cáo kết quả hoạt động kinh doanh', 'Bảng cân đối kế toán', 'Báo cáo lưu chuyển tiền tệ', 'Thuyết minh báo cáo tài chính'],
        correctAnswerIndex: 1,
      ),
      Question(
        text: 'Sai lầm nào thường khiến người mới mất tiền nhanh nhất trên thị trường?',
        answers: ['Mua cổ phiếu của các công ty có lợi nhuận tăng trưởng đều', 'Đầu tư theo phong trào (FOMO) mà không hiểu về doanh nghiệp', 'Dành thời gian nghiên cứu kỹ biểu đồ kỹ thuật', 'Chỉ đầu tư vào các quỹ chỉ số (ETF) an toàn'],
        correctAnswerIndex: 1,
      ),
    ],
  ),
];

final List<Question> weeklyChallengeQuestionsPool = [
  const Question(
    text: '"Lãi suất kép" (Compound Interest) được Albert Einstein gọi là kỳ quan thứ 8 của thế giới vì lý do gì?',
    answers: [
      'Vì nó giúp xóa nợ ngay lập tức',
      'Vì tiền lãi được tính trên cả vốn gốc lẫn tiền lãi đã tích lũy',
      'Vì nó chỉ xuất hiện ở các ngân hàng lớn nhất thế giới',
      'Vì lãi suất này không bao giờ thay đổi'
    ],
    correctAnswerIndex: 1,
  ),
  const Question(
    text: 'Một "Danh mục đầu tư đa dạng" (Diversified Portfolio) có mục đích chính là gì?',
    answers: ['Tối đa hóa lợi nhuận trong thời gian ngắn', 'Giảm thiểu rủi ro bằng cách không dồn hết tiền vào một tài sản', 'Giúp nhà đầu tư không đóng thuế', 'Làm đẹp bảng theo dõi chứng khoán'],
    correctAnswerIndex: 1,
  ),
  const Question(
    text: 'Thuật ngữ "Thanh khoản" (Liquidity) của một tài sản dùng để chỉ điều gì?',
    answers: ['Độ bền của tài sản theo năm tháng', 'Khả năng chuyển đổi thành tiền mặt nhanh chóng không mất giá', 'Mức độ nổi tiếng của công ty phát hành', 'Tỷ lệ lợi nhuận hàng năm'],
    correctAnswerIndex: 1,
  ),
  const Question(
    text: '"Quỹ khẩn cấp" (Emergency Fund) nên có số tiền tương đương bao nhiêu tháng chi phí sinh hoạt?',
    answers: ['1 tháng', 'Từ 3 đến 6 tháng', 'Ít nhất là 2 năm', 'Không cần nếu có thẻ tín dụng'],
    correctAnswerIndex: 1,
  ),
  const Question(
    text: 'Trong tài chính, "Tài sản" (Assets) khác "Tiêu sản" (Liabilities) ở điểm cốt lõi nào?',
    answers: ['Tài sản đắt tiền, tiêu sản rẻ tiền', 'Tài sản bỏ tiền vào túi bạn, tiêu sản lấy tiền từ túi bạn ra', 'Tài sản là đồ cũ, tiêu sản đồ mới mua', 'Giống nhau về giá trị'],
    correctAnswerIndex: 1,
  ),
  const Question(
    text: '"Lạm phát" có tác động trực tiếp nhất đến đối tượng nào sau đây?',
    answers: ['Người nợ ngân hàng lãi suất cố định', 'Người giữ toàn bộ tài sản bằng tiền mặt dưới gối', 'Doanh nghiệp xuất khẩu', 'Người đầu tư vàng bất động sản'],
    correctAnswerIndex: 1,
  ),
  const Question(
    text: 'Chỉ số GDP của một quốc gia dùng để đo lường điều gì?',
    answers: ['Lượng tiền mặt lưu thông trong dân', 'Tổng giá trị thị trường hàng hóa/dịch vụ cuối cùng được sản xuất', 'Tổng nợ chính phủ vay nước ngoài', 'Mức độ hạnh phúc người dân'],
    correctAnswerIndex: 1,
  ),
  const Question(
    text: 'Khi một cổ phiếu được gọi là "Định giá thấp" (Under-valued), điều đó có nghĩa là gì?',
    answers: ['Giá thị trường đang thấp hơn giá trị thực tế của doanh nghiệp', 'Công ty sắp phá sản', 'Không ai muốn mua cổ phiếu đó', 'Giá cổ phiếu thấp hơn 10.000 đồng'],
    correctAnswerIndex: 0,
  ),
  const Question(
    text: '"Bẫy thu nhập trung bình" thường dùng để mô tả trạng thái nào của nền kinh tế?',
    answers: ['Người dân chỉ làm bán thời gian', 'Quốc gia đạt mức thu nhập nhất định nhưng không thể thành nước phát triển', 'Lương công nhân bằng nhau', 'Giá hàng hóa tăng nhanh hơn lương'],
    correctAnswerIndex: 1,
  ),
  const Question(
    text: 'Quy tắc "72" trong tài chính dùng để tính toán nhanh điều gì?',
    answers: ['Số tiền thuế phải nộp hàng năm', 'Số năm cần thiết để khoản đầu tư tăng gấp đôi với lãi suất cố định', 'Độ tuổi nghỉ hưu trung bình', 'Tỷ lệ lạm phát 1 thập kỷ'],
    correctAnswerIndex: 1,
  ),
];

