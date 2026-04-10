import 'package:flutter/foundation.dart';
import 'dart:math';

enum PetState { happy, normal, tired, hungry, angry }

class GamificationEngine {
  int currentStreak = 0;
  int petXp = 0;
  int petLevel = 1;
  PetState petState = PetState.happy;

  // Xử lý yếu tố chơi hóa: Duy trì streak
  void updateStreak(bool isActiveToday) {
    if (isActiveToday) {
      currentStreak++;
    } else {
      currentStreak = 0; // Mất streak
    }
  }

  // Cập nhật điểm kinh nghiệm cho Pet
  void addPetXP(int xp) {
    petXp += xp;
    int requiredXp = petLevel * 100;

    // Lên cấp
    while (petXp >= requiredXp) {
      petXp -= requiredXp;
      petLevel++;
      requiredXp = petLevel * 100;
    }
  }

  // Thay đổi trạng thái Pet
  void changePetStatus(PetState newState) {
    petState = newState;
    debugPrint("Trạng thái Pet đã thay đổi thành: ${petState.name}");
  }

  // Phát sinh phần thưởng ngẫu nhiên
  Map<String, dynamic> generateRandomReward() {
    final random = Random();
    final List<Map<String, dynamic>> rewardsPool = [
      {'type': 'coin', 'amount': 100},
      {'type': 'food', 'amount': 1},
      {'type': 'xp', 'amount': 50},
      {'type': 'ticket', 'amount': 1},
    ];

    // Random chọn 1 phần thưởng trong pool
    Map<String, dynamic> reward =
        rewardsPool[random.nextInt(rewardsPool.length)];
    debugPrint("Phần thưởng ngẫu nhiên: ${reward['amount']} ${reward['type']}");
    return reward;
  }
}
