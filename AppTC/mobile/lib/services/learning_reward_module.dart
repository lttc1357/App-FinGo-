import 'package:flutter/foundation.dart';
import 'gamification_engine.dart';

class LearningRewardModule {
  final GamificationEngine gamificationEngine;

  LearningRewardModule({required this.gamificationEngine});

  // Quản lý nội dung bài học ngắn (Ví dụ)
  List<Map<String, dynamic>> getShortLessons() {
    return [
      {"id": "L1", "title": "Quản lý chi tiêu cá nhân", "xpReward": 50},
      {
        "id": "L2",
        "title": "Cách thiết lập ngân sách thông minh",
        "xpReward": 60,
      },
      {"id": "L3", "title": "Cạm bẫy chi tiêu bốc đồng", "xpReward": 50},
    ];
  }

  // Quản lý câu hỏi Quiz
  List<Map<String, dynamic>> getQuizQuestions(String lessonId) {
    // Trả về dạng JSON tuỳ theo lessonId truyền vào
    return [
      {
        "question": "Trong quy tắc phân bổ 50/30/20, 50% thuộc về khoản nào?",
        "options": [
          "Đầu tư và Tiết kiệm",
          "Nhu cầu thiết yếu",
          "Mong muốn cá nhân",
        ],
        "correctIndex": 1,
      },
      {
        "question":
            "Tính năng thanh toán bằng cách quét mã QR hoạt động như thế nào?",
        "options": [
          "Nhập số tài khoản bằng tay",
          "Sử dụng camera quét mã tĩnh/động",
          "Gửi tiền qua thẻ tín dụng",
        ],
        "correctIndex": 1,
      },
    ];
  }

  // Cơ chế phần thưởng khi người dùng hoàn thành nhiệm vụ học tập
  void completeLessonReward(String lessonId, int rewardXp) {
    debugPrint("Bài học '$lessonId' đã hoàn thành! Bạn nhận được $rewardXp XP.");
    gamificationEngine.addPetXP(rewardXp);
  }

  // Cơ chế thưởng tự động ngẫu nhiên khi người dùng hoàn thành Quiz xuất sắc
  void completeQuizReward(int userScore, int totalQuestions) {
    if (userScore == totalQuestions) {
      debugPrint(
        "Chúc mừng bạn trả lời đúng toàn bộ Quiz! Bạn được cộng thêm Pet XP...",
      );
      gamificationEngine.addPetXP(100);

      // Thưởng ngẫu nhiên do trả lời đúng 100%
      gamificationEngine.generateRandomReward();
    } else if (userScore >= totalQuestions / 2) {
      debugPrint("Bạn đã trả lời ở mức khá! Cộng thêm thẻ điểm rèn luyện.");
      gamificationEngine.addPetXP(30);
    } else {
      debugPrint("Cố gắng hơn nữa ở lần tới nhé! Thú cưng đang cổ vũ bạn.");
    }
  }
}
