import 'package:flutter/foundation.dart';
import 'gamification_engine.dart';

class BudgetMonitoringModule {
  double monthlyBudget = 2000000.0; // Mặc định: Ngân sách ảo 2 triệu
  double totalSpent = 0.0;

  final GamificationEngine gamificationEngine;

  BudgetMonitoringModule({required this.gamificationEngine});

  // Đặt lại ngân sách ảo
  void setBudget(double budget) {
    if (budget <= 0) return;
    monthlyBudget = budget;
    debugPrint("Ngân sách tháng đã được thiếp lập: $monthlyBudget");
  }

  // Theo dõi chi tiêu của người dùng
  void recordExpense(double amount) {
    totalSpent += amount;
    checkBudgetThreshold();
  }

  // Kiểm tra chi tiêu so với ngân sách đã thiết lập
  void checkBudgetThreshold() {
    double spendingRatio = totalSpent / monthlyBudget;

    // Đưa ra cảnh báo hoặc thay đổi trạng thái Pet khi vượt ngưỡng (70%, 90%)
    if (spendingRatio >= 0.9) {
      // Sắp cạn kiệt hoặc tiêu lố -> Pet lo lắng/tức giận
      gamificationEngine.changePetStatus(PetState.angry);
      issueWarning("Cảnh báo: Bạn đã chi tiêu quá 90% ngân sách tháng!");
    } else if (spendingRatio >= 0.7) {
      // Vượt 70% -> Pet mệt mỏi
      gamificationEngine.changePetStatus(PetState.tired);
      issueWarning(
        "Lưu ý: Ngân sách tháng sắp hết, hãy điều chỉnh chi tiêu hợp lý.",
      );
    } else {
      // Vẫn trong tầm kiểm soát an toàn -> Pet bình thường hoặc vui vẻ
      gamificationEngine.changePetStatus(PetState.happy);
    }
  }

  // Phát cảnh báo hệ thống (Logic đẩy Push Notification tới app)
  void issueWarning(String message) {
    debugPrint("⚠️ THÔNG BÁO BUDGET: $message");
  }
}
