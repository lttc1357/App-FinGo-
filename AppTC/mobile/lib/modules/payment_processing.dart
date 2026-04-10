import 'package:flutter/foundation.dart';
import '../models/app_models.dart';
import 'budget_monitoring.dart';
import 'gamification_engine.dart';

class PaymentProcessingModule {
  final GamificationEngine gamificationEngine;
  final BudgetMonitoringModule budgetModule;

  PaymentProcessingModule({
    required this.gamificationEngine,
    required this.budgetModule,
  });

  bool processQRPayment(VirtualWallet wallet, String qrData, double amount) {
    if (!_validateQR(qrData)) {
      debugPrint("Mã QR không hợp lệ!");
      return false;
    }

    if (wallet.balance < amount) {
      debugPrint("Số dư không đủ để thực hiện giao dịch!");
      return false;
    }

    // Trừ tiền
    wallet.balance -= amount;

    // Ghi nhận lịch sử
    final record = TransactionRecord(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      amount: amount,
      timestamp: DateTime.now(),
      description: "Thanh toán qua QR: $qrData",
    );
    wallet.history = List.from(wallet.history)..add(record);

    debugPrint("Giao dịch thành công: -$amount VND");

    // Cập nhật budget & check chi tiêu
    budgetModule.monitorSpending(amount);

    // Xử lý Gamification (VD: có giao dịch sẽ được nhận XP)
    gamificationEngine.addXP(10);

    return true;
  }

  bool _validateQR(String qrData) {
    // Logic xác thực mã QR giả lập
    return qrData.isNotEmpty && qrData.startsWith("QR_");
  }
}
