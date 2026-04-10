import 'package:flutter/foundation.dart';
import 'budget_monitoring_module.dart';

class PaymentProcessingModule {
  double walletBalance = 5000000.0; // 5 triệu đồng cho ví ảo
  List<Map<String, dynamic>> transactionHistory = [];
  final BudgetMonitoringModule budgetModule;

  PaymentProcessingModule({required this.budgetModule});

  // Kiểm tra dữ liệu mã QR
  bool validateQR(String qrData) {
    if (qrData.isEmpty) return false;
    // Giả định định dạng QR chuẩn nội bộ bắt đầu bằng "FINGO_PAY_"
    return qrData.startsWith('FINGO_PAY_');
  }

  // Kiểm tra số dư ví ảo
  bool checkBalance(double amount) {
    return walletBalance >= amount;
  }

  // Xử lý giao dịch thanh toán QR
  bool processQRPayment(String qrData, double amount, String description) {
    try {
      // 1. Kiểm tra dữ liệu mã QR
      if (!validateQR(qrData)) {
        debugPrint("Lỗi: Mã QR không hợp lệ.");
        return false;
      }

      // 2. Xác thực và kiểm tra số dư ví ảo
      if (!checkBalance(amount)) {
        debugPrint("Lỗi: Số dư ví ảo không đủ.");
        return false;
      }

      // 3. Trừ tiền khi giao dịch hợp lệ
      walletBalance -= amount;

      // 4. Ghi nhận lịch sử thanh toán
      recordTransaction(amount, description);

      // 5. Cập nhật sang Budget Monitoring Module
      budgetModule.recordExpense(amount);

      debugPrint("Thanh toán thành công $amount VNĐ! Số dư mới: $walletBalance");
      return true;
    } catch (e) {
      debugPrint("❌ Giao dịch thất bại do lỗi hệ thống: \$e");
      return false;
    }
  }

  // Ghi nhận lịch sử giao dịch
  void recordTransaction(double amount, String description) {
    transactionHistory.add({
      'txId': 'TXN_${DateTime.now().millisecondsSinceEpoch}',
      'amount': amount,
      'description': description,
      'status': 'SUCCESS',
      'createdAt': DateTime.now(),
    });
  }
}
