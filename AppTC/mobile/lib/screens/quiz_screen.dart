import 'dart:async';
import 'package:flutter/material.dart';
import '../theme.dart';
import '../data/quiz_data.dart';

class QuizScreen extends StatefulWidget {
  final LessonData lessonData;
  final bool isWeeklyChallenge;
  final void Function(bool isWon)? onWeeklyChallengeCompleted;
  final VoidCrossCallback? onQuickLessonCompleted;
  final int magnifyingGlassCount;
  final VoidCrossCallback? onMagnifyingGlassUsed;

  const QuizScreen({
    super.key,
    required this.lessonData,
    this.isWeeklyChallenge = false,
    this.onWeeklyChallengeCompleted,
    this.onQuickLessonCompleted,
    this.magnifyingGlassCount = 0,
    this.onMagnifyingGlassUsed,
  });

  @override
  State<QuizScreen> createState() => _QuizScreenState();
}

typedef VoidCrossCallback = void Function();

class _QuizScreenState extends State<QuizScreen> {
  int _currentIndex = 0;
  int? _selectedAnswerIndex;
  bool _isAnswered = false;
  int _score = 0;

  late int _timeLeft;
  Timer? _timer;
  
  bool _hasUsedMagnifyingGlass = false;
  late int _localMagnifyingGlassCount;

  @override
  void initState() {
    super.initState();
    _localMagnifyingGlassCount = widget.magnifyingGlassCount;
    _startTimer();
  }

  void _useMagnifyingGlass() {
    if (_hasUsedMagnifyingGlass || _localMagnifyingGlassCount <= 0 || _isAnswered) return;

    setState(() {
      _hasUsedMagnifyingGlass = true;
      _localMagnifyingGlassCount--;
      // Tìm vị trí đáp án đúng
      final correctIndex = widget.lessonData.questions[_currentIndex].correctAnswerIndex;
      _submitAnswer(correctIndex);
    });
    
    // Gọi callback để trừ kính lúp bên ngoài State
    widget.onMagnifyingGlassUsed?.call();
  }

  void _startTimer() {
    // Trích xuất số giây từ chuỗi (VD: "30 GIÂY" -> 30). Nếu lỗi, lấy mặc định 30s.
    final match = RegExp(r'\d+').firstMatch(widget.lessonData.durationText);
    _timeLeft = match != null ? int.parse(match.group(0)!) : 30;

    _timer?.cancel();
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (_timeLeft > 0) {
        setState(() {
          _timeLeft--;
        });
      } else {
        _timer?.cancel();
        if (!_isAnswered) {
          _submitAnswer(-1); // Hết giờ -> coi như trả lời sai
        }
      }
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  void _submitAnswer(int index) {
    if (_isAnswered) return;
    setState(() {
      _selectedAnswerIndex = index;
      _isAnswered = true;
      if (index == widget.lessonData.questions[_currentIndex].correctAnswerIndex) {
        _score++;
      }
    });
    _timer?.cancel();
  }

  void _nextQuestion() {
    if (_currentIndex < widget.lessonData.questions.length - 1) {
      setState(() {
        _currentIndex++;
        _selectedAnswerIndex = null;
        _isAnswered = false;
      });
      _startTimer();
    } else {
      _showResult();
    }
  }

  void _showResult() {
    final bool isWonWeekly = widget.isWeeklyChallenge && _score == widget.lessonData.questions.length;

    showModalBottomSheet(
      context: context,
      isDismissible: false,
      enableDrag: false,
      backgroundColor: Colors.transparent,
      builder: (context) => Container(
        padding: const EdgeInsets.all(32),
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(top: Radius.circular(32)),
        ),
        child: SafeArea(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                widget.isWeeklyChallenge ? Icons.auto_awesome : Icons.stars_rounded,
                size: 90,
                color: widget.isWeeklyChallenge ? (isWonWeekly ? const Color(0xFFE6A300) : AppTheme.primary) : AppTheme.tertiary,
              ),
              const SizedBox(height: 16),
              Text(
                widget.isWeeklyChallenge ? (isWonWeekly ? 'Chúc mừng!' : 'Hoàn thành!') : 'Bài học hoàn tất!',
                style: Theme.of(context).textTheme.displayMedium?.copyWith(
                      color: widget.isWeeklyChallenge ? (isWonWeekly ? const Color(0xFFE6A300) : AppTheme.primary) : AppTheme.primary,
                      fontSize: 28,
                    ),
              ),
              const SizedBox(height: 8),
              if (widget.isWeeklyChallenge)
                Text(
                  isWonWeekly ? 'Bạn đã nhận 1 Hạt dẻ vàng và 500 XP!' : 'Nhận 500 XP.\nĐúng hết tất cả để nhận Hạt dẻ vàng nhé!',
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.bodyLarge?.copyWith(fontSize: 16, color: AppTheme.onSurfaceVariant),
                )
              else
                Text(
                  'Bạn đã trả lời đúng',
                  style: Theme.of(context).textTheme.bodyLarge?.copyWith(fontSize: 16, color: AppTheme.onSurfaceVariant),
                ),
              const SizedBox(height: 4),
              Text(
                '$_score / ${widget.lessonData.questions.length}',
                style: Theme.of(context).textTheme.displayLarge?.copyWith(fontSize: 40, color: AppTheme.primary),
              ),
              const SizedBox(height: 32),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppTheme.primary,
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(vertical: 18),
                    elevation: 0,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(999)),
                  ),
                  onPressed: () {
                      if (widget.isWeeklyChallenge && widget.onWeeklyChallengeCompleted != null) {
                        widget.onWeeklyChallengeCompleted!(isWonWeekly);
                    } else if (!widget.isWeeklyChallenge && widget.onQuickLessonCompleted != null) {
                      widget.onQuickLessonCompleted!();
                    }
                    Navigator.of(context).pop(); // Đóng Modal
                    Navigator.of(context).pop(); // Thoát QuizScreen
                  },
                  child: Text(widget.isWeeklyChallenge ? 'Quay lại' : 'Nhận thưởng & Quay lại', style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    if (widget.lessonData.questions.isEmpty) return const Scaffold(body: Center(child: Text("Nội dung đang cập nhật...")));

    final question = widget.lessonData.questions[_currentIndex];

    return Scaffold(
      backgroundColor: AppTheme.surface,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.close, color: AppTheme.onSurface),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: ClipRRect(
          borderRadius: BorderRadius.circular(999),
          child: LinearProgressIndicator(
            value: (_currentIndex + 1) / widget.lessonData.questions.length,
            minHeight: 10,
            backgroundColor: AppTheme.surfaceVariant,
            color: widget.lessonData.iconColor,
          ),
        ),
        actions: [
          if (!widget.isWeeklyChallenge || widget.isWeeklyChallenge) // LUÔN HIỆN KÍNH LÚP (nếu có logic ấn định rõ ràng)
            Padding(
              padding: const EdgeInsets.only(right: 8),
              child: Center(
                child: ActionChip(
                  avatar: const Icon(Icons.search, size: 16),
                  label: Text('$_localMagnifyingGlassCount'),
                  onPressed: (_hasUsedMagnifyingGlass || _localMagnifyingGlassCount <= 0 || _isAnswered) 
                      ? null 
                      : _useMagnifyingGlass,
                  backgroundColor: (_hasUsedMagnifyingGlass || _localMagnifyingGlassCount <= 0 || _isAnswered) 
                      ? Colors.grey.withValues(alpha: 0.2) 
                      : AppTheme.tertiary.withValues(alpha: 0.2),
                  side: BorderSide.none,
                ),
              ),
            ),
          Padding(
            padding: const EdgeInsets.only(right: 20),
            child: Center(
              child: Text(
                '${_currentIndex + 1}/${widget.lessonData.questions.length}',
                style: Theme.of(context).textTheme.titleLarge?.copyWith(color: AppTheme.onSurfaceVariant),
              ),
            ),
          )
        ],
      ),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.fromLTRB(20, 16, 20, 24),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Icon(Icons.timer_outlined, color: _timeLeft <= 5 ? AppTheme.error : AppTheme.onSurfaceVariant),
                        const SizedBox(width: 8),
                        Text(
                          '00:${_timeLeft.toString().padLeft(2, '0')}',
                          style: Theme.of(context).textTheme.titleLarge?.copyWith(
                                color: _timeLeft <= 5 ? AppTheme.error : AppTheme.onSurfaceVariant,
                                fontSize: 18,
                              ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 24),
                    Text(
                      question.text,
                      style: Theme.of(context).textTheme.displayMedium?.copyWith(
                            fontSize: 24,
                            color: AppTheme.onSurface,
                            height: 1.3,
                          ),
                    ),
                    const SizedBox(height: 32),
                    ...List.generate(question.answers.length, (index) {
                      final isSelected = _selectedAnswerIndex == index;
                      final isCorrect = index == question.correctAnswerIndex;

                      Color bgColor = Colors.white;
                      Color borderColor = AppTheme.outline.withValues(alpha: 0.3);
                      Color textColor = AppTheme.onSurface;
                      IconData? trailingIcon;
                      Color iconColor = Colors.transparent;

                      if (_isAnswered) {
                        if (isCorrect) {
                          bgColor = const Color(0xFFE8F5E9);
                          borderColor = const Color(0xFF4CAF50);
                          textColor = const Color(0xFF2E7D32);
                          trailingIcon = Icons.check_circle;
                          iconColor = const Color(0xFF4CAF50);
                        } else if (isSelected) {
                          bgColor = const Color(0xFFFFEBEE);
                          borderColor = AppTheme.error;
                          textColor = const Color(0xFFC62828);
                          trailingIcon = Icons.cancel;
                          iconColor = AppTheme.error;
                        }
                      } else if (isSelected) {
                        bgColor = widget.lessonData.bgColor;
                        borderColor = widget.lessonData.iconColor;
                      }

                      return Padding(
                        padding: const EdgeInsets.only(bottom: 12),
                        child: InkWell(
                          onTap: () => _submitAnswer(index),
                          borderRadius: BorderRadius.circular(20),
                          child: AnimatedContainer(
                            duration: const Duration(milliseconds: 200),
                            padding: const EdgeInsets.all(20),
                            decoration: BoxDecoration(
                              color: bgColor,
                              borderRadius: BorderRadius.circular(20),
                              border: Border.all(color: borderColor, width: 2),
                            ),
                            child: Row(
                              children: [
                                Expanded(
                                  child: Text(
                                    question.answers[index],
                                    style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                                          fontSize: 16,
                                          color: textColor,
                                          fontWeight: isSelected || (_isAnswered && isCorrect)
                                              ? FontWeight.w600
                                              : FontWeight.normal,
                                        ),
                                  ),
                                ),
                                if (trailingIcon != null) ...[
                                  const SizedBox(width: 12),
                                  Icon(trailingIcon, color: iconColor),
                                ]
                              ],
                            ),
                          ),
                        ),
                      );
                    }),
                  ],
                ),
              ),
            ),
            if (_isAnswered)
              Container(
                padding: const EdgeInsets.fromLTRB(20, 20, 20, 20),
                decoration: BoxDecoration(
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(color: Colors.black.withValues(alpha: 0.05), blurRadius: 10, offset: const Offset(0, -4)),
                  ],
                ),
                child: SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: widget.lessonData.iconColor,
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(vertical: 18),
                      elevation: 0,
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(999)),
                    ),
                    onPressed: _nextQuestion,
                    child: Text(
                      _currentIndex < widget.lessonData.questions.length - 1 ? 'Câu tiếp theo' : 'Xem kết quả',
                      style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
