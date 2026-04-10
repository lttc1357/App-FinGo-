import 'package:flutter/foundation.dart';
import 'gamification_engine.dart';

class LearningLesson {
  final String id;
  final String title;
  final String content;
  final int rewardXP;

  LearningLesson({
    required this.id,
    required this.title,
    required this.content,
    required this.rewardXP,
  });
}

class Quiz {
  final String id;
  final String question;
  final String correctAnswer;
  final int rewardXP;

  Quiz({
    required this.id,
    required this.question,
    required this.correctAnswer,
    required this.rewardXP,
  });
}

class LearningRewardModule {
  final GamificationEngine gamificationEngine;
  List<LearningLesson> completedLessons = [];

  LearningRewardModule(this.gamificationEngine);

  void completeLesson(LearningLesson lesson) {
    if (!completedLessons.contains(lesson)) {
      debugPrint("Bạn đã hoàn thành bài học: ${lesson.title}");
      completedLessons.add(lesson);
      gamificationEngine.addXP(lesson.rewardXP);
    } else {
      debugPrint("Bài học này bạn đã hoàn thành rồi!");
    }
  }

  bool submitQuiz(Quiz quiz, String userAnswer) {
    bool isCorrect = quiz.correctAnswer.toLowerCase() == userAnswer.toLowerCase();
    
    if (isCorrect) {
      debugPrint("Trả lời chính xác! Bạn được cộng điểm thưởng.");
      gamificationEngine.addXP(quiz.rewardXP);
    } else {
      debugPrint("Câu trả lời chưa đúng. Hãy thử lại!");
    }

    return isCorrect;
  }
}
