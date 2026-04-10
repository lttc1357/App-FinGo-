import 'dart:async';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class PlatformJumpGame extends StatefulWidget {
  const PlatformJumpGame({super.key});

  @override
  State<PlatformJumpGame> createState() => _PlatformJumpGameState();
}

class PlatformObj {
  double x, y, width;
  int type;
  PlatformObj({
    required this.x,
    required this.y,
    required this.width,
    this.type = 0,
  });
}

class _PlatformJumpGameState extends State<PlatformJumpGame> {
  double catY = 0.5, catX = 0.0, verticalVelocity = 0.0;
  final double gravity = 0.04, jumpPower = -0.8;

  bool isPlaying = false, isGameOver = false;
  int score = 0;

  List<PlatformObj> platforms = [];
  Timer? gameTimer;
  final Random random = Random();

  void startGame() {
    setState(() {
      isPlaying = true;
      isGameOver = false;
      score = 0;
      catX = 0.0;
      catY = 0.7;
      verticalVelocity = jumpPower;
      platforms.clear();
      platforms.add(PlatformObj(x: 0.0, y: 0.9, width: 0.6, type: 1)); // Base
      for (int i = 1; i < 15; i++) {
        _addPlatform();
      }
    });
    gameTimer = Timer.periodic(
      const Duration(milliseconds: 30),
      (_) => _updatePhysics(),
    );
  }

  void _addPlatform() {
    double lastY = platforms.isEmpty ? 0.9 : platforms.last.y;
    double newY = lastY - (0.2 + random.nextDouble() * 0.15);
    double newX = (random.nextDouble() * 2) - 1.0;
    double width = 0.25 + random.nextDouble() * 0.25;
    platforms.add(
      PlatformObj(x: newX, y: newY, width: width, type: random.nextInt(3)),
    );
  }

  void _updatePhysics() {
    setState(() {
      verticalVelocity += gravity;
      catY += verticalVelocity * 0.05;

      if (verticalVelocity > 0) {
        for (var p in platforms) {
          if (catY + 0.05 >= p.y && catY - 0.05 <= p.y + 0.02) {
            if ((catX - p.x).abs() <= p.width / 2 + 0.1) {
              verticalVelocity = jumpPower;
              catY = p.y - 0.05;
              score++;
              if (platforms.length < 20) _addPlatform();
              break;
            }
          }
        }
      }

      if (catY < 0.4) {
        double delta = 0.4 - catY;
        catY = 0.4;
        for (var p in platforms) {
          p.y += delta;
        }
        platforms.removeWhere((p) => p.y > 1.2);
        score += (delta * 10).toInt();
      }

      if (catY > 1.1) gameOver();
    });
  }

  void gameOver() {
    setState(() {
      isPlaying = false;
      isGameOver = true;
    });
    gameTimer?.cancel();
    _showGameOverDialog();
  }

  void _showGameOverDialog() {
    int earnedCoins = score > 0 ? score ~/ 5 : 0;
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (_) => Dialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(24),
          side: const BorderSide(color: Color(0xFF4A148C), width: 4),
        ),
        backgroundColor: const Color(0xFFF3E5F5),
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                'GAME OVER',
                style: GoogleFonts.nunito(
                  fontSize: 32,
                  fontWeight: FontWeight.w900,
                  color: const Color(0xFF4A148C),
                ),
              ),
              const SizedBox(height: 16),
              Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.purple.withValues(alpha: 0.2),
                      blurRadius: 15,
                    ),
                  ],
                ),
                child: Column(
                  children: [
                    Text(
                      'SCORE: $score',
                      style: GoogleFonts.nunito(
                        color: const Color(0xFF6A1B9A),
                        fontSize: 26,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      '+$earnedCoins Xu vàng',
                      style: GoogleFonts.nunito(
                        color: Colors.orange.shade700,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 24),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  TextButton(
                    onPressed: () {
                      Navigator.pop(context);
                      Navigator.pop(context, score);
                    },
                    child: Text(
                      'THOÁT',
                      style: GoogleFonts.nunito(
                        color: Colors.grey.shade700,
                        fontSize: 18,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                  ),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF7B1FA2),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                      padding: const EdgeInsets.symmetric(
                        horizontal: 24,
                        vertical: 12,
                      ),
                    ),
                    onPressed: () {
                      Navigator.pop(context);
                      startGame();
                    },
                    child: Text(
                      'CHƠI LẠI',
                      style: GoogleFonts.nunito(
                        fontSize: 18,
                        fontWeight: FontWeight.w800,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    gameTimer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (didPop, result) {
        if (!didPop) Navigator.pop(context, score);
      },
      child: Scaffold(
        extendBodyBehindAppBar: true,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          leading: IconButton(
            icon: const Icon(
              Icons.arrow_back_ios_new,
              color: Colors.white,
              shadows: [Shadow(color: Colors.black45, blurRadius: 4)],
            ),
            onPressed: () => Navigator.pop(context, score),
          ),
        ),
        body: Container(
          width: double.infinity,
          height: double.infinity,
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Color(0xFF283593),
                Color(0xFF3949AB),
                Color(0xFF039BE5),
                Color(0xFFFFCC80),
              ],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              stops: [0.0, 0.4, 0.7, 1.0],
            ),
          ),
          child: Stack(
            children: [
              Positioned.fill(child: CustomPaint(painter: BackgroundPainter())),

              ...platforms
                  .map(
                    (p) => Align(
                      alignment: Alignment(p.x, (p.y * 2) - 1),
                      child: SizedBox(
                        width: MediaQuery.of(context).size.width * p.width / 2,
                        height: 20,
                        child: CustomPaint(painter: PlatformPainter(p.type)),
                      ),
                    ),
                  )
                  ,

              Align(
                alignment: Alignment(catX, (catY * 2) - 1),
                child: SizedBox(
                  width: 60,
                  height: 60,
                  child: CustomPaint(
                    painter: JumpingCatPainter(verticalVelocity),
                  ),
                ),
              ),

              if (isPlaying)
                Positioned.fill(
                  child: GestureDetector(
                    onPanUpdate: (details) {
                      setState(() {
                        catX += details.delta.dx * 0.006;
                        catX = catX.clamp(-1.0, 1.0);
                      });
                    },
                    child: Container(color: Colors.transparent),
                  ),
                ),

              if (isPlaying)
                SafeArea(
                  child: Align(
                    alignment: Alignment.topRight,
                    child: Padding(
                      padding: const EdgeInsets.all(16),
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 20,
                          vertical: 10,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.black.withValues(alpha: 0.4),
                          borderRadius: BorderRadius.circular(25),
                          border: Border.all(color: Colors.white24, width: 2),
                          boxShadow: const [
                            BoxShadow(color: Colors.black26, blurRadius: 8),
                          ],
                        ),
                        child: Text(
                          '🏆 $score',
                          style: GoogleFonts.nunito(
                            color: Colors.amberAccent,
                            fontSize: 22,
                            fontWeight: FontWeight.w900,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),

              if (!isPlaying && !isGameOver)
                Center(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.pinkAccent.shade400,
                          padding: const EdgeInsets.symmetric(
                            horizontal: 48,
                            vertical: 16,
                          ),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30),
                          ),
                          elevation: 10,
                          shadowColor: Colors.pink,
                        ),
                        onPressed: startGame,
                        child: Text(
                          'BAY NÀO!',
                          style: GoogleFonts.nunito(
                            fontSize: 28,
                            fontWeight: FontWeight.w900,
                            color: Colors.white,
                          ),
                        ),
                      ),
                      const SizedBox(height: 24),
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 20,
                          vertical: 12,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.black.withValues(alpha: 0.6),
                          borderRadius: BorderRadius.circular(20),
                          border: Border.all(color: Colors.white38),
                        ),
                        child: Text(
                          'Vuốt ngón tay ↔️ để điều khiển mèo',
                          style: GoogleFonts.nunito(
                            color: Colors.white,
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}

class BackgroundPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    Random r = Random(42);
    final starPaint = Paint()..color = Colors.white.withValues(alpha: 0.6);
    for (int i = 0; i < 30; i++) {
      canvas.drawCircle(
        Offset(r.nextDouble() * size.width, r.nextDouble() * size.height * 0.5),
        r.nextDouble() * 2 + 1,
        starPaint,
      );
    }

    final cloudPaint = Paint()..color = Colors.white.withValues(alpha: 0.15);
    canvas.drawCircle(
      Offset(size.width * 0.2, size.height * 0.6),
      40,
      cloudPaint,
    );
    canvas.drawCircle(
      Offset(size.width * 0.35, size.height * 0.62),
      60,
      cloudPaint,
    );
    canvas.drawCircle(
      Offset(size.width * 0.8, size.height * 0.7),
      50,
      cloudPaint,
    );
    canvas.drawCircle(
      Offset(size.width * 0.9, size.height * 0.75),
      70,
      cloudPaint,
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

class PlatformPainter extends CustomPainter {
  final int type;
  PlatformPainter(this.type);

  @override
  void paint(Canvas canvas, Size size) {
    Rect rect = Rect.fromLTWH(0, 0, size.width, size.height);
    RRect rrect = RRect.fromRectAndRadius(rect, const Radius.circular(8));

    Color baseColor = type == 0
        ? const Color(0xFF5D4037)
        : (type == 1 ? const Color(0xFF616161) : const Color(0xFF00796B));
    Color topColor = type == 0
        ? const Color(0xFF81C784)
        : (type == 1 ? const Color(0xFF9E9E9E) : const Color(0xFF4DB6AC));

    canvas.drawRRect(rrect, Paint()..color = baseColor);

    Path topPath = Path();
    topPath.addRRect(
      RRect.fromRectAndCorners(
        Rect.fromLTWH(0, 0, size.width, size.height * 0.4),
        topLeft: const Radius.circular(8),
        topRight: const Radius.circular(8),
      ),
    );

    for (double i = 10; i < size.width - 10; i += 15) {
      topPath.addOval(
        Rect.fromCenter(
          center: Offset(i, size.height * 0.35),
          width: 8,
          height: 10,
        ),
      );
    }
    canvas.drawPath(topPath, Paint()..color = topColor);
    canvas.drawRRect(
      rrect,
      Paint()
        ..color = Colors.black38
        ..style = PaintingStyle.stroke
        ..strokeWidth = 2,
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

class JumpingCatPainter extends CustomPainter {
  final double velocity;
  JumpingCatPainter(this.velocity);

  @override
  void paint(Canvas canvas, Size size) {
    double cx = size.width / 2;
    double cy = size.height / 2;
    bool isFalling = velocity > 0;

    final paintCat = Paint()..color = const Color(0xFFFF9800);
    final paintWhite = Paint()..color = Colors.white;
    final paintBlack = Paint()..color = Colors.black;

    Path tail = Path()
      ..moveTo(cx, cy + 15)
      ..quadraticBezierTo(
        cx + 20,
        cy + 30 + (isFalling ? -10 : 10),
        cx + 15,
        cy + 5,
      );
    canvas.drawPath(
      tail,
      Paint()
        ..color = Colors.deepOrange
        ..style = PaintingStyle.stroke
        ..strokeWidth = 6
        ..strokeCap = StrokeCap.round,
    );

    double stretchY = isFalling ? 5 : -5;
    canvas.drawOval(
      Rect.fromCenter(center: Offset(cx, cy + stretchY), width: 34, height: 28),
      paintCat,
    );

    canvas.drawCircle(Offset(cx, cy - 8), 16, paintCat);

    Path ears = Path()
      ..moveTo(cx - 14, cy - 12)
      ..lineTo(cx - 18, cy - 25)
      ..lineTo(cx - 6, cy - 20)
      ..moveTo(cx + 14, cy - 12)
      ..lineTo(cx + 18, cy - 25)
      ..lineTo(cx + 6, cy - 20);
    canvas.drawPath(ears, paintCat);

    Path innerEars = Path()
      ..moveTo(cx - 12, cy - 14)
      ..lineTo(cx - 15, cy - 21)
      ..lineTo(cx - 8, cy - 18)
      ..moveTo(cx + 12, cy - 14)
      ..lineTo(cx + 15, cy - 21)
      ..lineTo(cx + 8, cy - 18);
    canvas.drawPath(innerEars, Paint()..color = Colors.pink.shade200);

    canvas.drawCircle(Offset(cx - 6, cy - 10), 4, paintWhite);
    canvas.drawCircle(Offset(cx + 6, cy - 10), 4, paintWhite);
    double pupilY = isFalling ? -9 : -11;
    canvas.drawCircle(Offset(cx - 6, cy + pupilY), 2, paintBlack);
    canvas.drawCircle(Offset(cx + 6, cy + pupilY), 2, paintBlack);

    canvas.drawCircle(
      Offset(cx, cy - 6),
      1.5,
      Paint()..color = Colors.pinkAccent,
    );
    Path mouth = Path()
      ..moveTo(cx - 4, cy - 4)
      ..quadraticBezierTo(cx - 2, cy - 2, cx, cy - 4)
      ..quadraticBezierTo(cx + 2, cy - 2, cx + 4, cy - 4);
    canvas.drawPath(
      mouth,
      Paint()
        ..color = Colors.black
        ..style = PaintingStyle.stroke
        ..strokeWidth = 1,
    );

    double armY = isFalling ? -15 : -5;
    canvas.drawLine(
      Offset(cx - 10, cy + 5),
      Offset(cx - 22, cy + armY),
      Paint()
        ..color = paintCat.color
        ..style = PaintingStyle.stroke
        ..strokeWidth = 5
        ..strokeCap = StrokeCap.round,
    );
    canvas.drawLine(
      Offset(cx + 10, cy + 5),
      Offset(cx + 22, cy + armY),
      Paint()
        ..color = paintCat.color
        ..style = PaintingStyle.stroke
        ..strokeWidth = 5
        ..strokeCap = StrokeCap.round,
    );

    double legY = isFalling ? 10 : 20;
    canvas.drawLine(
      Offset(cx - 8, cy + 15),
      Offset(cx - 15, cy + 15 + legY),
      Paint()
        ..color = paintCat.color
        ..style = PaintingStyle.stroke
        ..strokeWidth = 5
        ..strokeCap = StrokeCap.round,
    );
    canvas.drawLine(
      Offset(cx + 8, cy + 15),
      Offset(cx + 15, cy + 15 + legY),
      Paint()
        ..color = paintCat.color
        ..style = PaintingStyle.stroke
        ..strokeWidth = 5
        ..strokeCap = StrokeCap.round,
    );
  }

  @override
  bool shouldRepaint(covariant JumpingCatPainter oldDelegate) =>
      oldDelegate.velocity != velocity;
}
