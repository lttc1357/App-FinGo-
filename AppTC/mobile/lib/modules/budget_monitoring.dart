import 'package:flutter/foundation.dart';
import '../models/app_models.dart';
import 'gamification_engine.dart';

class BudgetMonitoringModule {
  final BudgetPlan plan;
  final GamificationEngine gamificationEngine;

  BudgetMonitoringModule(this.plan, this.gamificationEngine);

  void monitorSpending(double amount) {
    plan.currentSpent += amount;
    debugPrint(
        "Chi tiêu hiện tại: ${plan.currentSpent} / Ngân sách: ${plan.limit}");
    
    _evaluateStatus();
  }

  void _evaluateStatus() {
    double usagePercentage = plan.currentSpent / plan.limit;

    if (usagePercentage >= 1.0) {
      _triggerAlert("CẢNH BÁO ĐỎ: BẠN ĐÃ VƯỢT NGÂN SÁCH!");
      gamificationEngine.changePetState(PetState.sick);
    } else if (usagePercentage >= 0.8) {
      _triggerAlert("Cảnh báo Vàng: Bạn đã dùng 80% ngân sách rồi.");
      gamificationEngine.changePetState(PetState.sad); 
    } else {
      gamificationEngine.changePetState(PetState.happy);
    }
  }

  void _triggerAlert(String message) {
    // Logic đẩy Push Notification / Dialog cho App
    debugPrint("ALERT: $message");
  }
}
