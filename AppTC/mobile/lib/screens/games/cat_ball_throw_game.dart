import 'dart:math';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CatBallThrowGame extends StatefulWidget {
  const CatBallThrowGame({super.key});

  @override
  State<CatBallThrowGame> createState() => _CatBallThrowGameState();
}

class _CatBallThrowGameState extends State<CatBallThrowGame>
    with TickerProviderStateMixin {
  int score = 0;
  int combo = 0;
  int totalXp = 0;
  int totalCoin = 0;

  Offset dragOffset = Offset.zero;
  Offset currentBallOffset = Offset.zero;
  bool isDragging = false;

  late AnimationController _throwController;
  late Animation<Offset> _throwAnimation;
  late Animation<double> _scaleAnimation;
  late Animation<double> _rotateAnimation;

  @override
  void initState() {
    super.initState();
    _throwController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 700),
    );

    _throwAnimation = Tween<Offset>(
      begin: Offset.zero,
      end: Offset.zero,
    ).animate(_throwController);
    _scaleAnimation = Tween<double>(
      begin: 1.0,
      end: 1.0,
    ).animate(_throwController);
    _rotateAnimation = Tween<double>(
      begin: 0.0,
      end: 0.0,
    ).animate(_throwController);

    _throwController.addListener(() {
      setState(() {
        currentBallOffset = _throwAnimation.value;
      });
    });

    _throwController.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        _checkScore();
      }
    });
  }

  @override
  void dispose() {
    _throwController.dispose();
    super.dispose();
  }

  void _onPanStart(DragStartDetails details) {
    if (_throwController.isAnimating) return;
    setState(() {
      isDragging = true;
      dragOffset = Offset.zero;
      currentBallOffset = Offset.zero;
    });
  }

  void _onPanUpdate(DragUpdateDetails details) {
    if (!isDragging) return;
    setState(() {
      dragOffset += details.delta;
      if (dragOffset.dy < 0) dragOffset = Offset(dragOffset.dx, 0);
      currentBallOffset = dragOffset;
    });
  }

  void _onPanEnd(DragEndDetails details, double screenHeight) {
    if (!isDragging) return;
    setState(() {
      isDragging = false;
    });

    final throwMultiplier = 4.5;
    final throwVector = Offset(
      -dragOffset.dx * throwMultiplier,
      -dragOffset.dy * throwMultiplier,
    );

    _throwAnimation = Tween<Offset>(begin: currentBallOffset, end: throwVector)
        .animate(
          CurvedAnimation(parent: _throwController, curve: Curves.easeOutCubic),
        );

    _scaleAnimation = Tween<double>(begin: 1.0, end: 0.45).animate(
      CurvedAnimation(parent: _throwController, curve: Curves.easeInQuad),
    );

    _rotateAnimation = Tween<double>(
      begin: 0.0,
      end: 4 * pi * (throwVector.dx > 0 ? 1 : -1),
    ).animate(CurvedAnimation(parent: _throwController, curve: Curves.easeOut));

    _throwController.forward(from: 0);
  }

  void _checkScore() {
    final screenHeight = MediaQuery.of(context).size.height;

    final initialBallBottom = 120.0;
    final basketBottom = screenHeight * 0.78; // Tương đối vị trí rổ

    final finalBallYPos = initialBallBottom - currentBallOffset.dy;
    final finalBallXOffset = currentBallOffset.dx;

    final distanceX = (finalBallXOffset).abs();
    final distanceY = (finalBallYPos - basketBottom).abs();

    if (distanceX < 60 && distanceY < 120) {
      setState(() {
        score += 10;
        combo++;
        totalXp += 10;
        if (combo >= 3) {
          totalCoin += 5;
        }
      });
      _showSnack(
        'VÀO RỔ! +10 Điểm (Combo x$combo) 🔥',
        const Color(0xFF4CAF50),
      );
      _resetBall();
    } else {
      setState(() {
        combo = 0;
      });
      _showSnack('TRƯỢT RỒI! 😿', const Color(0xFFF44336));
      _resetBall();
    }
  }

  void _resetBall() {
    Future.delayed(const Duration(milliseconds: 600), () {
      if (mounted) {
        setState(() {
          currentBallOffset = Offset.zero;
          dragOffset = Offset.zero;
          _throwController.reset();
        });
      }
    });
  }

  void _showSnack(String msg, Color color) {
    ScaffoldMessenger.of(context).clearSnackBars();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (color == const Color(0xFF4CAF50))
              const Icon(Icons.sports_basketball, color: Colors.white),
            if (color == const Color(0xFFF44336))
              const Icon(Icons.cancel, color: Colors.white),
            const SizedBox(width: 10),
            Text(
              msg,
              style: GoogleFonts.nunito(
                fontWeight: FontWeight.bold,
                fontSize: 16,
                color: Colors.white,
              ),
            ),
          ],
        ),
        backgroundColor: color.withValues(alpha: 0.9),
        duration: const Duration(milliseconds: 1200),
        behavior: SnackBarBehavior.floating,
        margin: const EdgeInsets.only(bottom: 100, left: 20, right: 20),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        elevation: 10,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final screenH = MediaQuery.of(context).size.height;
    final screenW = MediaQuery.of(context).size.width;

    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (didPop, result) {
        if (!didPop) Navigator.pop(context, score ~/ 10);
      },
      child: Scaffold(
        extendBodyBehindAppBar: true,
        appBar: AppBar(
          title: Text(
            'Mèo Ném Bóng',
            style: GoogleFonts.nunito(
              color: Colors.white,
              fontWeight: FontWeight.w900,
              fontSize: 24,
              shadows: const [Shadow(blurRadius: 4, color: Colors.black54)],
            ),
          ),
          centerTitle: true,
          backgroundColor: Colors.transparent,
          elevation: 0,
          leading: IconButton(
            icon: const Icon(
              Icons.arrow_back_ios_new,
              color: Colors.white,
              shadows: [Shadow(blurRadius: 4, color: Colors.black54)],
            ),
            onPressed: () => Navigator.pop(context, score ~/ 10),
          ),
        ),
        body: Container(
          width: double.infinity,
          height: double.infinity,
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Color(0xFF1E1E2C),
                Color(0xFF3B2F4C),
                Color(0xFF5A4465),
                Color(0xFF9E768F),
              ],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              stops: [0.0, 0.3, 0.6, 1.0],
            ),
          ),
          child: Stack(
            alignment: Alignment.center,
            children: [
              // Background details
              Positioned.fill(child: CustomPaint(painter: BackgroundPainter())),

              // Basket Backboard
              Positioned(
                top: screenH * 0.15,
                child: CustomPaint(
                  size: const Size(180, 120),
                  painter: BackboardPainter(),
                ),
              ),

              // Basket Rim and Net
              Positioned(
                top: screenH * 0.15 + 90,
                child: CustomPaint(
                  size: const Size(90, 70),
                  painter: RimAndNetPainter(),
                ),
              ),

              // Score Card
              Positioned(
                top: screenH * 0.12,
                left: 16,
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 12,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.white.withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(color: Colors.white30, width: 1.5),
                    boxShadow: const [
                      BoxShadow(
                        color: Colors.black26,
                        blurRadius: 10,
                        spreadRadius: 1,
                      ),
                    ],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'ĐIỂM: $score',
                        style: GoogleFonts.nunito(
                          fontSize: 22,
                          fontWeight: FontWeight.w900,
                          color: Colors.white,
                        ),
                      ),
                      if (combo > 0)
                        Padding(
                          padding: const EdgeInsets.only(top: 4),
                          child: Text(
                            'Combo x$combo 🔥',
                            style: GoogleFonts.nunito(
                              fontSize: 16,
                              color: Colors.orangeAccent,
                              fontWeight: FontWeight.w900,
                            ),
                          ),
                        ),
                      const SizedBox(height: 8),
                      Row(
                        children: [
                          const Icon(
                            Icons.star_rounded,
                            color: Colors.yellowAccent,
                            size: 20,
                          ),
                          const SizedBox(width: 4),
                          Text(
                            '$totalXp XP',
                            style: GoogleFonts.nunito(
                              fontSize: 16,
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),

              // Trajectory Line
              if (isDragging)
                Positioned.fill(
                  child: CustomPaint(
                    painter: TrajectoryPainter(
                      dragOffset,
                      Offset(screenW / 2, screenH - 120 - 40),
                      screenH,
                    ),
                  ),
                ),

              // The Cat Ball
              Positioned(
                bottom: 120 - currentBallOffset.dy,
                left: screenW / 2 - 45 + currentBallOffset.dx,
                child: GestureDetector(
                  onPanStart: _onPanStart,
                  onPanUpdate: _onPanUpdate,
                  onPanEnd: (details) => _onPanEnd(details, screenH),
                  child: Transform.scale(
                    scale: _throwController.isAnimating
                        ? _scaleAnimation.value
                        : 1.0,
                    child: Transform.rotate(
                      angle: _throwController.isAnimating
                          ? _rotateAnimation.value
                          : 0.0,
                      child: SizedBox(
                        width: 90,
                        height: 90,
                        child: CustomPaint(
                          size: const Size(90, 90),
                          painter: CatBallPainter(),
                        ),
                      ),
                    ),
                  ),
                ),
              ),

              // Hint Text
              if (!_throwController.isAnimating && score == 0 && !isDragging)
                Positioned(
                  bottom: 40,
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 24,
                      vertical: 12,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.black45,
                      borderRadius: BorderRadius.circular(30),
                      border: Border.all(color: Colors.white24, width: 1.5),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Icon(Icons.touch_app, color: Colors.orangeAccent),
                        const SizedBox(width: 8),
                        Text(
                          'Kéo xuống & Thả để ném!',
                          style: GoogleFonts.nunito(
                            color: Colors.white,
                            fontWeight: FontWeight.w800,
                            fontSize: 16,
                          ),
                        ),
                      ],
                    ),
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
    Random r = Random(100);
    final paint = Paint()..color = Colors.white.withValues(alpha: 0.05);

    // Draw some subtle court lights / bokeh
    for (int i = 0; i < 15; i++) {
      double cx = r.nextDouble() * size.width;
      double cy = r.nextDouble() * size.height * 0.5;
      double radius = r.nextDouble() * 30 + 10;
      canvas.drawCircle(Offset(cx, cy), radius, paint);
    }

    // Draw floor lines
    final linePaint = Paint()
      ..color = Colors.white.withValues(alpha: 0.1)
      ..strokeWidth = 4
      ..style = PaintingStyle.stroke;

    Path floorPath = Path();
    floorPath.moveTo(0, size.height * 0.85);
    floorPath.quadraticBezierTo(
      size.width * 0.5,
      size.height * 0.8,
      size.width,
      size.height * 0.85,
    );
    canvas.drawPath(floorPath, linePaint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

class BackboardPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final rect = Rect.fromLTWH(0, 0, size.width, size.height);
    final rrect = RRect.fromRectAndRadius(rect, const Radius.circular(16));

    // Glass board
    canvas.drawRRect(rrect, Paint()..color = Colors.white.withValues(alpha: 0.85));
    canvas.drawRRect(
      rrect,
      Paint()
        ..color = Colors.grey.shade400
        ..style = PaintingStyle.stroke
        ..strokeWidth = 6,
    );

    // Inner red square
    final innerRect = Rect.fromLTWH(
      size.width / 2 - 35,
      size.height - 60,
      70,
      45,
    );
    canvas.drawRect(
      innerRect,
      Paint()
        ..color = Colors.redAccent
        ..style = PaintingStyle.stroke
        ..strokeWidth = 5,
    );

    // Base connector
    canvas.drawRect(
      Rect.fromLTWH(size.width / 2 - 15, size.height, 30, 20),
      Paint()..color = Colors.grey.shade800,
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

class RimAndNetPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    // Rim
    final rimRect = Rect.fromCenter(
      center: Offset(size.width / 2, 0),
      width: size.width,
      height: 25,
    );
    canvas.drawOval(
      rimRect,
      Paint()
        ..color = Colors.orange.shade800
        ..style = PaintingStyle.stroke
        ..strokeWidth = 6,
    );
    // Rim inner shadow
    canvas.drawOval(
      rimRect,
      Paint()
        ..color = Colors.deepOrange
        ..style = PaintingStyle.stroke
        ..strokeWidth = 2,
    );

    // Net
    final netPaint = Paint()
      ..color = Colors.white.withValues(alpha: 0.8)
      ..strokeWidth = 2
      ..style = PaintingStyle.stroke;

    Path netPath = Path();
    double netTop = 12.5;
    double netBottom = size.height;
    double netWidthTop = size.width * 0.9;
    double netWidthBottom = size.width * 0.6;

    for (int i = 0; i <= 5; i++) {
      double startX = (size.width - netWidthTop) / 2 + (netWidthTop / 5) * i;
      double endX =
          (size.width - netWidthBottom) / 2 + (netWidthBottom / 5) * i;
      netPath.moveTo(startX, netTop);
      netPath.lineTo(endX, netBottom);
    }

    for (int i = 0; i <= 3; i++) {
      double y = netTop + (netBottom - netTop) / 3 * i;
      double currentWidth =
          netWidthTop - ((netWidthTop - netWidthBottom) / 3 * i);
      double startX = (size.width - currentWidth) / 2;
      netPath.moveTo(startX, y);
      netPath.lineTo(startX + currentWidth, y);
    }

    canvas.drawPath(netPath, netPaint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

class TrajectoryPainter extends CustomPainter {
  final Offset dragOffset;
  final Offset startPos;
  final double screenHeight;

  TrajectoryPainter(this.dragOffset, this.startPos, this.screenHeight);

  @override
  void paint(Canvas canvas, Size size) {
    if (dragOffset == Offset.zero) return;

    final throwMultiplier = 4.5;
    final throwVector = Offset(
      -dragOffset.dx * throwMultiplier,
      -dragOffset.dy * throwMultiplier,
    );

    final paint = Paint()
      ..color = Colors.white.withValues(alpha: 0.5)
      ..strokeCap = StrokeCap.round
      ..strokeWidth = 6;

    final int numDots = 8;
    for (int i = 1; i <= numDots; i++) {
      final double t = i / numDots;
      final double dx = throwVector.dx * t;
      final double dy = throwVector.dy * t - 160 * (4 * t * (1 - t));

      double dotX = startPos.dx + dx;
      double dotY = startPos.dy + dy;

      // Decrease size of dots further away
      double radius = 6.0 * (1 - t * 0.5);
      canvas.drawCircle(Offset(dotX, dotY), radius, paint);
    }
  }

  @override
  bool shouldRepaint(covariant TrajectoryPainter oldDelegate) =>
      oldDelegate.dragOffset != dragOffset;
}

class CatBallPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    double cx = size.width / 2;
    double cy = size.height / 2;
    double r = size.width / 2;

    // Ball Base Color & Shadow
    final Rect ballRect = Rect.fromCircle(center: Offset(cx, cy), radius: r);
    final Paint ballPaint = Paint()
      ..shader = const RadialGradient(
        colors: [Color(0xFFFFB74D), Color(0xFFF57C00), Color(0xFFE65100)],
        center: Alignment(-0.3, -0.3),
        radius: 0.8,
      ).createShader(ballRect);

    canvas.drawCircle(Offset(cx, cy), r, ballPaint);

    // Basketball Lines
    final linePaint = Paint()
      ..color = Colors.black87
      ..strokeWidth = 2.5
      ..style = PaintingStyle.stroke;

    canvas.drawLine(Offset(cx, 0), Offset(cx, size.height), linePaint);
    canvas.drawLine(Offset(0, cy), Offset(size.width, cy), linePaint);

    canvas.drawArc(
      Rect.fromCircle(center: Offset(-10, cy), radius: r * 1.1),
      -pi / 2,
      pi,
      false,
      linePaint,
    );
    canvas.drawArc(
      Rect.fromCircle(center: Offset(size.width + 10, cy), radius: r * 1.1),
      pi / 2,
      pi,
      false,
      linePaint,
    );

    // Cat Face On The Ball
    final catColor = Paint()..color = Colors.white.withValues(alpha: 0.9);
    final shadowColor = Paint()..color = Colors.black45;

    // Ears
    Path ears = Path()
      ..moveTo(cx - 20, cy - r + 15)
      ..lineTo(cx - 30, cy - r + 0)
      ..lineTo(cx - 5, cy - r + 10)
      ..moveTo(cx + 20, cy - r + 15)
      ..lineTo(cx + 30, cy - r + 0)
      ..lineTo(cx + 5, cy - r + 10);
    // Draw ear shadow
    canvas.drawPath(ears.shift(const Offset(0, 2)), shadowColor);
    canvas.drawPath(ears, catColor);

    // Inner Ears
    Path innerEars = Path()
      ..moveTo(cx - 22, cy - r + 12)
      ..lineTo(cx - 26, cy - r + 4)
      ..lineTo(cx - 10, cy - r + 10)
      ..moveTo(cx + 22, cy - r + 12)
      ..lineTo(cx + 26, cy - r + 4)
      ..lineTo(cx + 10, cy - r + 10);
    canvas.drawPath(innerEars, Paint()..color = Colors.pinkAccent.shade100);

    // Eyes
    canvas.drawCircle(
      Offset(cx - 15, cy - 10),
      6,
      Paint()..color = Colors.black,
    );
    canvas.drawCircle(
      Offset(cx + 15, cy - 10),
      6,
      Paint()..color = Colors.black,
    );
    canvas.drawCircle(
      Offset(cx - 17, cy - 12),
      2,
      Paint()..color = Colors.white,
    );
    canvas.drawCircle(
      Offset(cx + 13, cy - 12),
      2,
      Paint()..color = Colors.white,
    );

    // Nose
    canvas.drawCircle(
      Offset(cx, cy - 2),
      3,
      Paint()..color = Colors.pinkAccent,
    );

    // Mouth
    Path mouth = Path()
      ..moveTo(cx - 8, cy + 2)
      ..quadraticBezierTo(cx - 4, cy + 6, cx, cy + 2)
      ..quadraticBezierTo(cx + 4, cy + 6, cx + 8, cy + 2);
    canvas.drawPath(
      mouth,
      Paint()
        ..color = Colors.black87
        ..style = PaintingStyle.stroke
        ..strokeWidth = 2,
    );

    // Whiskers
    final whiskerPaint = Paint()
      ..color = Colors.black87
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.5;
    canvas.drawLine(
      Offset(cx - 28, cy - 4),
      Offset(cx - 45, cy - 8),
      whiskerPaint,
    );
    canvas.drawLine(
      Offset(cx - 28, cy + 2),
      Offset(cx - 45, cy + 2),
      whiskerPaint,
    );
    canvas.drawLine(
      Offset(cx + 28, cy - 4),
      Offset(cx + 45, cy - 8),
      whiskerPaint,
    );
    canvas.drawLine(
      Offset(cx + 28, cy + 2),
      Offset(cx + 45, cy + 2),
      whiskerPaint,
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
