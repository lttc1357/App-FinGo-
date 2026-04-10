import 'package:flutter/foundation.dart';
import 'dart:math';
import '../models/app_models.dart';

class GamificationEngine {
  final VirtualPet pet;
  int streakDays = 0;
  DateTime? lastActiveDate;

  GamificationEngine(this.pet);

  void updateStreak() {
    final now = DateTime.now();
    if (lastActiveDate == null) {
      streakDays = 1;
    } else {
      final difference = now.difference(lastActiveDate!).inDays;
      if (difference == 1) {
        streakDays++;
        debugPrint("Tăng streak! Hiện tại là $streakDays ngày.");
        addXP(5 * streakDays); // Thưởng thêm XP khi giữ được streak
      } else if (difference > 1) {
        streakDays = 1; // Mất streak
        debugPrint("Đã mất streak. Streak quay lại 1.");
      }
    }
    lastActiveDate = now;
  }

  void addXP(int amount) {
    pet.xp += amount;
    debugPrint("Pet nhận được $amount XP! (Tổng: ${pet.xp})");
    _checkLevelUp();
    _randomReward();
  }

  void changePetState(PetState newState) {
    pet.state = newState;
    debugPrint("Trạng thái của Pet đã đổi thành: ${newState.name}");
  }

  void _checkLevelUp() {
    int xpThreshhold = pet.level * 100;
    if (pet.xp >= xpThreshhold) {
      pet.level++;
      pet.xp -= xpThreshhold;
      changePetState(PetState.evolved);
      debugPrint("Tuyệt vời! Pet của bạn đã lên cấp độ ${pet.level}!");
    }
  }

  void _randomReward() {
    final random = Random();
    if (random.nextDouble() > 0.8) { // 20% cơ hội rơi ra phần thưởng
      debugPrint("🎁 Bất ngờ! Bạn nhận được phần thưởng ngẫu nhiên!");
      // Logic add phần thưởng vào kho của người dùng
    }
  }
}
