import 'dart:async';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class FishingCatGame extends StatefulWidget {
  const FishingCatGame({super.key});

  @override
  State<FishingCatGame> createState() => _FishingCatGameState();
}

class Entity {
  double x, y, radius;
  int weight, score, direction;
  String type;
  Color color;
  bool isCaught;

  Entity({
    required this.x, required this.y, required this.radius,
    required this.weight, required this.score, required this.type,
    required this.color, this.isCaught = false, required this.direction
  });
}

class Bubble {
  double x, y, size, speed;
  Bubble(this.x, this.y, this.size, this.speed);
}

class _FishingCatGameState extends State<FishingCatGame> with TickerProviderStateMixin {
  int timeRemaining = 60, score = 0;
  bool isPlaying = false, isGameOver = false;

  Timer? gameTimer, swingTimer, fishMoveTimer, envTimer;

  double hookAngle = 0.0, hookLength = 0.15;
  bool hookSwingingRight = true, isReeling = false, isShooting = false;
  
  final double maxAngle = pi / 3.5, swingSpeed = 0.03, shootSpeed = 0.02, reelSpeedBase = 0.015;

  List<Entity> entities = [];
  List<Bubble> bubbles = [];
  Entity? caughtEntity;
  final Random random = Random();

  @override
  void initState() {
    super.initState();
    for(int i=0; i<20; i++) {
       bubbles.add(Bubble(random.nextDouble(), random.nextDouble(), random.nextDouble() * 5 + 2, random.nextDouble() * 0.005 + 0.002));
    }
  }

  void startGame() {
    setState(() {
      isPlaying = true; isGameOver = false; score = 0; timeRemaining = 60;
      isReeling = false; isShooting = false; hookAngle = 0.0; hookLength = 0.15;
      caughtEntity = null;
      generateEntities();
    });

    gameTimer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if(timeRemaining > 0) {
        setState(() => timeRemaining--);
      } else {
        gameOver();
      }
    });

    swingTimer = Timer.periodic(const Duration(milliseconds: 30), (timer) {
      if(!isPlaying) return;
      setState(() {
        if(!isShooting && !isReeling) {
          if(hookSwingingRight) {
            hookAngle += swingSpeed;
            if(hookAngle >= maxAngle) hookSwingingRight = false;
          } else {
            hookAngle -= swingSpeed;
            if(hookAngle <= -maxAngle) hookSwingingRight = true;
          }
        } else if (isShooting) {
           hookLength += shootSpeed;
           checkCollision();
           if(hookLength >= 1.0) { isShooting = false; isReeling = true; }
        } else if (isReeling) {
           double currentReelSpeed = caughtEntity != null ? reelSpeedBase / caughtEntity!.weight : reelSpeedBase;
           hookLength -= currentReelSpeed;
           if(hookLength <= 0.15) {
             isReeling = false; hookLength = 0.15;
             if(caughtEntity != null) {
                score += caughtEntity!.score;
                entities.remove(caughtEntity);
                caughtEntity = null;
             }
           }
        }
      });
    });

    fishMoveTimer = Timer.periodic(const Duration(milliseconds: 100), (timer) {
       if(!isPlaying) return;
       setState(() {
         for(var e in entities) {
           if(!e.isCaught && (e.type == 'fish' || e.type == 'rare_fish' || e.type == 'jellyfish')) {
              e.x += (0.01 * e.direction);
              if (e.type == 'jellyfish') { e.y += sin(DateTime.now().millisecondsSinceEpoch / 500) * 0.01; }
              if(e.x > 1.0) {
                e.direction = -1;
              } else if (e.x < 0.0) { e.direction = 1; }
           }
         }
       });
    });

    envTimer = Timer.periodic(const Duration(milliseconds: 50), (timer) {
      if(!isPlaying) return;
      setState(() {
         for(var b in bubbles) {
            b.y -= b.speed;
            b.x += sin(b.y * 20) * 0.001;
            if(b.y < 0.25) { b.y = 1.0; b.x = random.nextDouble(); }
         }
      });
    });
  }

  void generateEntities() {
    entities.clear();
    for(int i=0; i<5; i++) {
      entities.add(Entity(x: random.nextDouble() * 0.8 + 0.1, y: random.nextDouble() * 0.2 + 0.35, radius: 0.04, weight: 1, score: 10, type: 'fish', color: const Color(0xFFFF9800), direction: random.nextBool() ? 1:-1));
    }
    for(int i=0; i<3; i++) {
      entities.add(Entity(x: random.nextDouble() * 0.8 + 0.1, y: random.nextDouble() * 0.2 + 0.55, radius: 0.035, weight: 2, score: 30, type: 'rare_fish', color: const Color(0xFFE040FB), direction: random.nextBool() ? 1:-1));
    }
    for(int i=0; i<2; i++) {
      entities.add(Entity(x: random.nextDouble() * 0.8 + 0.1, y: random.nextDouble() * 0.2 + 0.45, radius: 0.045, weight: 2, score: 40, type: 'jellyfish', color: Colors.pinkAccent, direction: random.nextBool() ? 1:-1));
    }
    for(int i=0; i<3; i++) {
      entities.add(Entity(x: random.nextDouble() * 0.8 + 0.1, y: random.nextDouble() * 0.2 + 0.7, radius: 0.06, weight: 5, score: -10, type: 'rock', color: Colors.grey.shade800, direction: 0));
    }
    entities.add(Entity(x: random.nextDouble() * 0.8 + 0.1, y: random.nextDouble() * 0.1 + 0.85, radius: 0.05, weight: 4, score: 100, type: 'treasure', color: Colors.amberAccent, direction: 0));
  }

  void checkCollision() {
      double hookX = 0.5 + hookLength * sin(hookAngle);
      double hookY = 0.2 + hookLength * cos(hookAngle);
      for(var e in entities) {
        if(!e.isCaught && sqrt(pow(hookX - e.x, 2) + pow(hookY - e.y, 2)) < e.radius) {
           e.isCaught = true; caughtEntity = e; isShooting = false; isReeling = true; break;
        }
      }
  }

  void gameOver() {
    setState(() { isPlaying = false; isGameOver = true; });
    gameTimer?.cancel(); swingTimer?.cancel(); fishMoveTimer?.cancel(); envTimer?.cancel();
    _showGameOverDialog();
  }

  void _showGameOverDialog() {
    int earnedCoins = score > 0 ? score ~/ 2 : 0;
    showDialog(
      context: context, barrierDismissible: false,
      builder: (_) => Dialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24), side: const BorderSide(color: Color(0xFF0277BD), width: 4)),
        backgroundColor: const Color(0xFFE1F5FE),
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
               Text('HẾT GIỜ!', style: GoogleFonts.nunito(fontSize: 32, fontWeight: FontWeight.w900, color: const Color(0xFF01579B))),
               const SizedBox(height: 16),
               Container(
                 padding: const EdgeInsets.all(20),
                 decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(20), boxShadow: [BoxShadow(color: Colors.blue.withValues(alpha: 0.2), blurRadius: 15)]),
                 child: Column(
                   children: [
                       Text('ĐIỂM: $score', style: GoogleFonts.nunito(color: const Color(0xFF0277BD), fontSize: 26, fontWeight: FontWeight.bold)),
                       const SizedBox(height: 8),
                       Text('+$earnedCoins Xu vàng', style: GoogleFonts.nunito(color: Colors.orange.shade700, fontSize: 18, fontWeight: FontWeight.bold)),
                   ],
                 )
               ),
               const SizedBox(height: 24),
               Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  TextButton(
                    onPressed: () { Navigator.pop(context); Navigator.pop(context, score); },
                    child: Text('THOÁT', style: GoogleFonts.nunito(color: Colors.grey.shade700, fontSize: 18, fontWeight: FontWeight.w800)),
                  ),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF0288D1),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12)
                    ),
                    onPressed: () { Navigator.pop(context); startGame(); },
                    child: Text('CHƠI LẠI', style: GoogleFonts.nunito(fontSize: 18, fontWeight: FontWeight.w800, color: Colors.white)),
                  ),
                ],
              )
            ],
          )
        )
      )
    );
  }

  @override
  void dispose() {
    gameTimer?.cancel(); swingTimer?.cancel(); fishMoveTimer?.cancel(); envTimer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (didPop, result) { if (!didPop) Navigator.pop(context, score); },
      child: Scaffold(
        extendBodyBehindAppBar: true,
        appBar: AppBar(
          backgroundColor: Colors.transparent, elevation: 0,
          leading: IconButton(
            icon: const Icon(Icons.arrow_back_ios_new, color: Colors.white, size: 28),
            onPressed: () => Navigator.pop(context, score)
          ),
        ),
        body: GestureDetector(
          onTap: () { if(isPlaying && !isShooting && !isReeling) setState(() => isShooting = true); },
          child: Container(
            width: double.infinity,
            height: double.infinity,
            decoration: const BoxDecoration(
               gradient: LinearGradient(
                  colors: [Color(0xFF81D4FA), Color(0xFF29B6F6), Color(0xFF0277BD), Color(0xFF01579B)],
                  begin: Alignment.topCenter, end: Alignment.bottomCenter, stops: [0.1, 0.3, 0.6, 1.0]
               )
            ),
            child: Stack(
               children: [
                  Positioned(top: 40, right: 30, child: Icon(Icons.wb_sunny, color: Colors.yellow.shade200, size: 80)),
                  Positioned(top: 80, left: 40, child: Icon(Icons.cloud, color: Colors.white.withValues(alpha: 0.7), size: 70)),
                  Positioned(top: 60, right: 120, child: Icon(Icons.cloud, color: Colors.white.withValues(alpha: 0.5), size: 50)),
                  
                  Positioned(
                    top: MediaQuery.of(context).size.height * 0.22, left: 0, right: 0,
                    child: Container(height: 5, color: Colors.lightBlue.shade100.withValues(alpha: 0.5))
                  ),

                  Positioned.fill(
                    child: CustomPaint(painter: FishingPainter(hookAngle, hookLength, entities, bubbles, caughtEntity))
                  ),

                  SafeArea(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                            decoration: BoxDecoration(color: Colors.white.withValues(alpha: 0.9), borderRadius: BorderRadius.circular(16), boxShadow: const [BoxShadow(color: Colors.black26, blurRadius: 4)]),
                            child: Row(children: [const Icon(Icons.timer, color: Colors.blue), const SizedBox(width: 8), Text('$timeRemaining s', style: GoogleFonts.nunito(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.blue.shade800))]),
                          ),
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                            decoration: BoxDecoration(color: Colors.orange.shade400, borderRadius: BorderRadius.circular(16), boxShadow: const [BoxShadow(color: Colors.black26, blurRadius: 4)]),
                            child: Row(children: [const Icon(Icons.star, color: Colors.white), const SizedBox(width: 8), Text('$score', style: GoogleFonts.nunito(fontSize: 18, fontWeight: FontWeight.w900, color: Colors.white))]),
                          )
                        ],
                      ),
                    ),
                  ),

                  if(!isPlaying && !isGameOver)
                    Center(
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                           backgroundColor: Colors.orange.shade500,
                           padding: const EdgeInsets.symmetric(horizontal: 48, vertical: 16),
                           shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
                           elevation: 8
                        ),
                        onPressed: startGame,
                        child: Text('BẮT ĐẦU CÂU!', style: GoogleFonts.nunito(fontSize: 24, fontWeight: FontWeight.w900, color: Colors.white)),
                      )
                    )
               ],
            )
          )
        )
      )
    );
  }
}

class FishingPainter extends CustomPainter {
  final double hookAngle, hookLength;
  final List<Entity> entities;
  final List<Bubble> bubbles;
  final Entity? caughtEntity;

  FishingPainter(this.hookAngle, this.hookLength, this.entities, this.bubbles, this.caughtEntity);

  @override
  void paint(Canvas canvas, Size size) {
    double pivotX = size.width * 0.5, pivotY = size.height * 0.20;

    for(var b in bubbles) {
      canvas.drawCircle(Offset(b.x * size.width, b.y * size.height), b.size, Paint()..color = Colors.white.withValues(alpha: 0.4)..style = PaintingStyle.fill);
    }

    _drawBoatAndCat(canvas, Offset(pivotX, pivotY - 20), size.width * 0.35);

    double hookEndX = pivotX + (hookLength * size.height) * sin(hookAngle);
    double hookEndY = pivotY + (hookLength * size.height) * cos(hookAngle);

    canvas.drawLine(Offset(pivotX, pivotY), Offset(hookEndX, hookEndY), Paint()..color = Colors.white70..strokeWidth = 2);

    Path hookPath = Path()..moveTo(hookEndX, hookEndY)..lineTo(hookEndX, hookEndY + 12)..quadraticBezierTo(hookEndX, hookEndY + 25, hookEndX - 15, hookEndY + 20)..quadraticBezierTo(hookEndX - 20, hookEndY + 15, hookEndX - 10, hookEndY + 8)..lineTo(hookEndX - 8, hookEndY + 12);
    canvas.drawPath(hookPath, Paint()..color = Colors.grey.shade300..strokeWidth = 3..style = PaintingStyle.stroke..strokeCap = StrokeCap.round);

    for(var e in entities) {
       if(e.isCaught) continue;
       _drawEntity(canvas, e, Offset(e.x * size.width, e.y * size.height), size.width * e.radius);
    }

    if(caughtEntity != null) _drawEntity(canvas, caughtEntity!, Offset(hookEndX, hookEndY + 20), size.width * caughtEntity!.radius);
  }

  void _drawBoatAndCat(Canvas canvas, Offset center, double w) {
    Path boatPath = Path()..moveTo(center.dx - w/2, center.dy)..lineTo(center.dx + w/2, center.dy)..lineTo(center.dx + w*0.35, center.dy + w*0.25)..lineTo(center.dx - w*0.35, center.dy + w*0.25)..close();
    canvas.drawPath(boatPath, Paint()..color = const Color(0xFF6D4C41));
    canvas.drawPath(boatPath, Paint()..color = const Color(0xFF4E342E)..strokeWidth = 3..style = PaintingStyle.stroke);

    final catCol = Colors.orangeAccent.shade200;
    canvas.drawOval(Rect.fromCenter(center: Offset(center.dx + 25, center.dy - 15), width: 36, height: 40), Paint()..color = catCol); // body
    canvas.drawCircle(Offset(center.dx + 25, center.dy - 35), 22, Paint()..color = catCol); // head
    Path ear = Path()..moveTo(center.dx+8, center.dy-45)..lineTo(center.dx+15, -60+center.dy)..lineTo(center.dx+22, -45+center.dy)..moveTo(center.dx+42, -45+center.dy)..lineTo(center.dx+35, -60+center.dy)..lineTo(center.dx+28, -45+center.dy);
    canvas.drawPath(ear, Paint()..color = catCol);
    canvas.drawCircle(Offset(center.dx + 18, center.dy - 38), 4, Paint()..color = Colors.white);
    canvas.drawCircle(Offset(center.dx + 32, center.dy - 38), 4, Paint()..color = Colors.white);
    canvas.drawCircle(Offset(center.dx + 18, center.dy - 38), 2, Paint()..color = Colors.black);
    canvas.drawCircle(Offset(center.dx + 32, center.dy - 38), 2, Paint()..color = Colors.black);
    canvas.drawArc(Rect.fromCenter(center: Offset(center.dx + 25, center.dy - 30), width: 8, height: 6), 0, pi, false, Paint()..color = Colors.black..style = PaintingStyle.stroke..strokeWidth=2);
  }

  void _drawEntity(Canvas canvas, Entity e, Offset pos, double size) {
    canvas.save();
    canvas.translate(pos.dx, pos.dy);
    if(e.type == 'fish' || e.type == 'rare_fish') {
       if(e.direction == 1) canvas.scale(-1, 1);
       Path tail = Path()..moveTo(-size, 0)..lineTo(-size*1.8, -size)..lineTo(-size*1.4, 0)..lineTo(-size*1.8, size)..close();
       canvas.drawPath(tail, Paint()..color = e.color.withValues(alpha: 0.9));
       canvas.drawOval(Rect.fromCenter(center: Offset.zero, width: size*2.2, height: size*1.4), Paint()..color = e.color);
       canvas.drawCircle(Offset(size*0.5, -size*0.2), size*0.25, Paint()..color = Colors.white);
       canvas.drawCircle(Offset(size*0.6, -size*0.2), size*0.12, Paint()..color = Colors.black);
    } else if(e.type == 'jellyfish') {
       canvas.drawArc(Rect.fromCenter(center: Offset(0, -size*0.2), width: size*2, height: size*2), pi, pi, true, Paint()..color = e.color.withValues(alpha: 0.8));
       for(int i=0; i<4; i++) {
         canvas.drawLine(Offset(-size*0.6 + i*(size*0.4), 0), Offset(-size*0.6 + i*(size*0.4) + sin(e.x*50)*size*0.3, size*1.2), Paint()..color=e.color.withValues(alpha: 0.8)..strokeWidth=2);
       }
       canvas.drawCircle(Offset(-size*0.3, -size*0.4), size*0.15, Paint()..color = Colors.white);
       canvas.drawCircle(Offset(size*0.3, -size*0.4), size*0.15, Paint()..color = Colors.white);
    } else if(e.type == 'rock') {
       Path rock = Path()..moveTo(-size*0.8, size*0.5)..lineTo(-size, -size*0.2)..lineTo(-size*0.3, -size*0.8)..lineTo(size*0.5, -size*0.9)..lineTo(size*0.9, -size*0.1)..lineTo(size*0.7, size*0.6)..close();
       canvas.drawPath(rock, Paint()..color = e.color);
    } else if(e.type == 'treasure') {
       canvas.drawRect(Rect.fromCenter(center: Offset.zero, width: size*2, height: size*1.5), Paint()..color = e.color);
       canvas.drawRect(Rect.fromCenter(center: Offset(0, -size*0.75), width: size*2.2, height: size*0.5), Paint()..color = const Color(0xFFFF6D00));
       canvas.drawCircle(Offset.zero, size*0.3, Paint()..color = Colors.redAccent);
    }
    canvas.restore();
  }
  @override bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}
