import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../data/quiz_data.dart';
import 'quiz_screen.dart';

class QuizListScreen extends StatelessWidget {
  const QuizListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    final textColor = isDark ? Colors.white : Colors.black;

    return Scaffold(
      
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: BackButton(color: textColor),
        title: Text('Giải Đố Tài Chính 📚', 
          style: GoogleFonts.nunito(fontWeight: FontWeight.w900, color: textColor)),
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(24),
        itemCount: academyLessons.length,
        itemBuilder: (context, index) {
          final lesson = academyLessons[index];
          int expectedCount = lesson.questions.length;
          if (lesson.title.contains('Tiết kiệm 101')) expectedCount = 5;
          else if (lesson.title.contains('Lạm phát là gì')) expectedCount = 5;
          else if (lesson.title.contains('Thanh toán nợ')) expectedCount = 8;
          else if (lesson.title.contains('Chứng khoán')) expectedCount = 7;

          return GestureDetector(
            onTap: () async {
              final randomQuestions = List<Question>.from(lesson.questions)..shuffle();
              final modifiedLesson = LessonData(
                title: lesson.title,
                durationText: lesson.durationText,
                icon: lesson.icon,
                bgColor: lesson.bgColor,
                iconColor: lesson.iconColor,
                questions: randomQuestions.take(expectedCount).toList(),
              );

              final result = await Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => QuizScreen(lessonData: modifiedLesson)),
              );
              if (result != null && result is int && result > 0 && context.mounted) {
                 Navigator.pop(context, result);
              }
            },
            child: Container(
              margin: const EdgeInsets.only(bottom: 16),
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Theme.of(context).cardColor,
                borderRadius: BorderRadius.circular(24),
                boxShadow: [BoxShadow(color: (Theme.of(context).brightness == Brightness.dark) ? Colors.black12 : Colors.grey.shade100, blurRadius: 10, offset: const Offset(0, 4))],
              ),
              child: Row(
                children: [
                   Container(
                     padding: const EdgeInsets.all(16),
                     decoration: BoxDecoration(color: lesson.bgColor, borderRadius: BorderRadius.circular(16)),
                     child: Icon(lesson.icon, color: lesson.iconColor, size: 30),
                   ),
                   const SizedBox(width: 16),
                   Expanded(
                     child: Column(
                       crossAxisAlignment: CrossAxisAlignment.start,
                       children: [
                         Text(lesson.title.replaceAll('\n', ' '), 
                           style: GoogleFonts.nunito(fontSize: 16, fontWeight: FontWeight.bold, color: Theme.of(context).colorScheme.onSurface)),
                         const SizedBox(height: 4),
                         Text('Thử thách: $expectedCount câu hỏi', 
                           style: GoogleFonts.nunito(fontSize: 13, color: Theme.of(context).colorScheme.onSurfaceVariant, fontWeight: FontWeight.w600)),
                       ],
                     ),
                   ),
                   Icon(Icons.chevron_right, color: Colors.grey.shade400),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
