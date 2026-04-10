// ignore_for_file: deprecated_member_use
import 'dart:async';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CatRacingGame extends StatefulWidget {
  const CatRacingGame({super.key});

  @override
  State<CatRacingGame> createState() => _CatRacingGameState();
}

class _CatRacingGameState extends State<CatRacingGame> {
  int catLane = 0; // -1 (Trái), 0 (Giữa), 1 (Phải)
  double gameSpeed = 0.05;
  int score = 0;
  int coins = 0;
  bool isPlaying = false;
  bool isGameOver = false;

  Timer? gameTimer;
  Timer? objectSpawner;
  
  List<Map<String, dynamic>> objects = [];
  final Random random = Random();

  void startGame() {
    setState(() {
      isPlaying = true;
      isGameOver = false;
      score = 0;
      coins = 0;
      catLane = 0;
      gameSpeed = 0.02;
      objects.clear();
    });

    gameTimer = Timer.periodic(const Duration(milliseconds: 30), (timer) {
      if (!isPlaying) return;
      
      setState(() {
        score++;
        if (score % 200 == 0) {
          gameSpeed += 0.002;
        }

        for (int i = objects.length - 1; i >= 0; i--) {
          objects[i]['y'] += gameSpeed;
          
          if (objects[i]['y'] > 0.75 && objects[i]['y'] < 0.90 && objects[i]['lane'] == catLane) {
            if (objects[i]['type'] == 'coin') {
              coins += 5;
              objects.removeAt(i);
            } else if (objects[i]['type'] == 'obstacle') {
              gameOver();
              return;
            }
          } 
          else if (objects[i]['y'] > 1.2) {
            objects.removeAt(i);
          }
        }
      });
    });

    objectSpawner = Timer.periodic(const Duration(milliseconds: 600), (timer) {
      if (!isPlaying) return;
      int lane = random.nextInt(3) - 1;
      String type = random.nextDouble() > 0.6 ? 'coin' : 'obstacle';
      objects.add({
        'lane': lane,
        'y': -0.2, // Bắt đầu xa hơn trên cùng
        'type': type,
      });
    });
  }

  void gameOver() {
    setState(() {
      isPlaying = false;
      isGameOver = true;
    });
    gameTimer?.cancel();
    objectSpawner?.cancel();
    _showGameOverDialog();
  }

  void _showGameOverDialog() {
    int earnedXp = score ~/ 50;
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => Dialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24), side: const BorderSide(color: Color(0xFF0D47A1), width: 4)),
        backgroundColor: const Color(0xFF1976D2),
        child: Container(
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Stack(
                children: [
                   Text('ĐỤNG XE!', style: GoogleFonts.plusJakartaSans(fontSize: 32, fontWeight: FontWeight.w900, foreground: Paint()..style = PaintingStyle.stroke..strokeWidth = 6..color = const Color(0xFF0D47A1))),
                   Text('ĐỤNG XE!', style: GoogleFonts.plusJakartaSans(fontSize: 32, fontWeight: FontWeight.w900, color: Colors.white)),
                ],
              ),
              const SizedBox(height: 20),
              Container(
                padding: const EdgeInsets.all(15),
                decoration: BoxDecoration(color: const Color(0xFF0D47A1), borderRadius: BorderRadius.circular(15)),
                child: Column(
                  children: [
                     _buildPill('$score m', Icons.straighten, Colors.blue.shade800, Colors.white, width: 150),
                     const SizedBox(height: 8),
                     _buildPill('+$coins Coin', Icons.monetization_on, Colors.amber.shade800, Colors.yellow, width: 150),
                     const SizedBox(height: 8),
                     _buildPill('+$earnedXp XP', Icons.bolt, Colors.green.shade800, Colors.lightGreenAccent, width: 150),
                  ],
                ),
              ),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  TextButton(
                    onPressed: () {
                      Navigator.pop(context); // Tắt Dialog
                      Navigator.pop(context, score); // THOÁT GAME và TRẢ VỀ SCORE
                    },
                    child: Text('QUIT', style: GoogleFonts.plusJakartaSans(color: Colors.white, fontSize: 18, fontWeight: FontWeight.w800)),
                  ),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.orangeAccent.shade700,
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20), side: const BorderSide(color: Colors.white, width: 2)),
                    ),
                    onPressed: () {
                      Navigator.pop(context); // Tắt Dialog
                      objects.clear(); 
                      startGame();
                    },
                    child: Text('RETRY', style: GoogleFonts.plusJakartaSans(fontSize: 18, fontWeight: FontWeight.w800, color: Colors.white)),
                  ),
                ],
              )
            ],
          ),
        ),
      )
    );
  }

  Widget _buildPill(String text, IconData? icon, Color bgColor, Color iconColor, {double? width}) {
    return Container(
      width: width,
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: const Color(0xFF0A2A5A), width: 3), 
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          if (icon != null) ...[
            Icon(icon, color: iconColor, size: 18),
            const SizedBox(width: 4),
          ],
          Text(text, style: GoogleFonts.plusJakartaSans(color: Colors.white, fontSize: 15, fontWeight: FontWeight.bold)),
        ],
      ),
    );
  }

  void moveLeft() {
    if (catLane > -1 && isPlaying) setState(() => catLane--);
  }

  void moveRight() {
    if (catLane < 1 && isPlaying) setState(() => catLane++);
  }

  Future<bool> _onWillPop() async {
    Navigator.pop(context, score);
    return false;
  }

  @override
  void dispose() {
    gameTimer?.cancel();
    objectSpawner?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: _onWillPop,
      child: Scaffold(
        extendBodyBehindAppBar: true,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          leading: IconButton(
            icon: const Icon(Icons.arrow_back, color: Colors.white),
            onPressed: () {
              // Bấm back => trả về điểm kỉ lục cho quest
              if (isGameOver) {
                  Navigator.pop(context, score);
              } else {
                  Navigator.pop(context, score);
              }
            }
          ),
        ),
        body: GestureDetector(
          onHorizontalDragEnd: (details) {
            if (details.primaryVelocity! < 0) {
              moveLeft();
            } else if (details.primaryVelocity! > 0) { moveRight(); }
          },
          child: Container(
            width: double.infinity,
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [Color(0xFF81D4FA), Color(0xFF4FC3F7), Color(0xFFE0E0E0), Color(0xFF757575)], 
                stops: [0.0, 0.4, 0.41, 1.0], 
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              )
            ),
            child: SafeArea(
              child: Stack(
                children: [
                   // (Giữ nguyên toàn bộ nội dung của màn hình đua xe ở đây)
                  Positioned(
                    top: MediaQuery.of(context).size.height * 0.2, 
                    left: 0, right: 0,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Container(width: 50, height: 80, decoration: const BoxDecoration(color: Color(0xFF81C784), borderRadius: BorderRadius.vertical(top: Radius.circular(8)))),
                        Container(width: 70, height: 120, decoration: const BoxDecoration(color: Color(0xFF4DD0E1), borderRadius: BorderRadius.vertical(top: Radius.circular(8)))),
                        Container(width: 60, height: 90, decoration: const BoxDecoration(color: Color(0xFF81C784), borderRadius: BorderRadius.vertical(top: Radius.circular(8)))),
                        Container(width: 80, height: 150, decoration: const BoxDecoration(color: Color(0xFF4DD0E1), borderRadius: BorderRadius.vertical(top: Radius.circular(8)))),
                      ],
                    ),
                  ),

                  Positioned.fill(
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: Padding(
                        padding: EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.4),
                        child: Container(width: 15, decoration: const BoxDecoration(gradient: LinearGradient(colors: [Colors.red, Colors.white], stops: [0.5,0.5], begin: Alignment.topCenter, end: Alignment.bottomCenter, tileMode: TileMode.repeated))),
                      ),
                    ),
                  ),
                  Positioned.fill(
                    child: Align(
                      alignment: Alignment.centerRight,
                      child: Padding(
                        padding: EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.4),
                        child: Container(width: 15, decoration: const BoxDecoration(gradient: LinearGradient(colors: [Colors.red, Colors.white], stops: [0.5,0.5], begin: Alignment.topCenter, end: Alignment.bottomCenter, tileMode: TileMode.repeated))),
                      ),
                    ),
                  ),

                  Positioned.fill(
                    child: Padding(
                      padding: EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.4), 
                      child: Stack(
                        children: [
                          Align(alignment: const Alignment(-0.33, 0), child: _BuildDashedLine()),
                          Align(alignment: const Alignment(0.33, 0), child: _BuildDashedLine()),
                        ]
                      )
                    )
                  ),

                  Positioned(
                    top: 10, left: 16, right: 16,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                         _buildPill('Năng lượng', null, Colors.orangeAccent.shade700, Colors.white, width: 100),
                         Stack(
                            children: [
                               Text('Mèo Đua Xe', style: GoogleFonts.plusJakartaSans(fontSize: 28, fontWeight: FontWeight.w900, foreground: Paint()..style = PaintingStyle.stroke..strokeWidth = 6..color = const Color(0xFF0A2A5A))),
                               Text('Mèo Đua Xe', style: GoogleFonts.plusJakartaSans(fontSize: 28, fontWeight: FontWeight.w900, color: Colors.yellowAccent)),
                            ],
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                                _buildPill('$score m', Icons.straighten, const Color(0xFF1565C0), Colors.white),
                                const SizedBox(height: 4),
                                _buildPill('$coins', Icons.monetization_on, const Color(0xFF1565C0), Colors.yellow),
                            ]
                          )
                      ],
                    ),
                  ),

                  ...objects.map((obj) {
                    double alignX = obj['lane'] == -1 ? -0.8 : (obj['lane'] == 1 ? 0.8 : 0.0);
                    double visualY = (obj['y'] * 2) - 1; 
                    return Align(
                      alignment: Alignment(alignX, visualY),
                      child: obj['type'] == 'coin'
                          ? Container(
                              decoration: const BoxDecoration(
                                shape: BoxShape.circle,
                                boxShadow: [BoxShadow(color: Colors.yellowAccent, blurRadius: 10)]
                              ),
                              child: const Icon(Icons.monetization_on, color: Colors.amber, size: 45)
                            )
                          : Container(
                              width: 60, height: 60,
                              decoration: BoxDecoration(
                                color: Colors.orange.shade800,
                                borderRadius: const BorderRadius.only(topLeft: Radius.circular(30), topRight: Radius.circular(30)),
                                border: Border.all(color: Colors.white, width: 4) 
                              ),
                              child: const Icon(Icons.warning_amber_rounded, color: Colors.white, size: 30)
                            ),
                    );
                  }),

                  Align(
                    alignment: Alignment(catLane == -1 ? -0.8 : (catLane == 1 ? 0.8 : 0.0), 0.85),
                    child: Container(
                      width: 80, height: 110,
                      decoration: BoxDecoration(
                        color: Colors.redAccent.shade700,
                        borderRadius: const BorderRadius.vertical(top: Radius.circular(40), bottom: Radius.circular(15)),
                        border: Border.all(color: Colors.white, width: 3),
                        boxShadow: const [BoxShadow(color: Colors.black45, offset: Offset(0, 10), blurRadius: 10)]
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Icon(Icons.pets, color: Colors.white, size: 36),
                          Container(width: 40, height: 15, decoration: BoxDecoration(color: Colors.orangeAccent, borderRadius: BorderRadius.circular(5))),
                          const Text('1', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 16))
                        ],
                      ),
                    ),
                  ),

                  if (!isPlaying)
                    Center(
                       child: ElevatedButton(
                         style: ElevatedButton.styleFrom(
                           backgroundColor: Colors.orangeAccent.shade700,
                           padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 15),
                           shape: RoundedRectangleBorder(
                             borderRadius: BorderRadius.circular(30),
                             side: const BorderSide(color: Colors.white, width: 4)
                           ),
                           elevation: 8
                         ),
                         onPressed: startGame,
                         child: Stack(
                           children: [
                             Text('BẮT ĐẦU!', style: GoogleFonts.plusJakartaSans(fontSize: 24, fontWeight: FontWeight.w900, foreground: Paint()..style = PaintingStyle.stroke..strokeWidth = 4..color = const Color(0xFF0A2A5A))),
                             Text('BẮT ĐẦU!', style: GoogleFonts.plusJakartaSans(fontSize: 24, fontWeight: FontWeight.w900, color: Colors.white)),
                           ],
                         ),
                       ),
                     ),
                     
                  if(isPlaying)
                    Positioned(
                      bottom: 20, left: 20,
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 8),
                        decoration: BoxDecoration(color: const Color(0xFF0A2A5A), borderRadius: BorderRadius.circular(12), border: Border.all(color: Colors.white, width: 2)),
                        child: Column(
                          children: [
                            Text('TỐC ĐỘ', style: GoogleFonts.plusJakartaSans(color: Colors.white70, fontSize: 12, fontWeight: FontWeight.bold)),
                            Text('${(gameSpeed * 2000).toInt()}', style: GoogleFonts.plusJakartaSans(color: Colors.white, fontSize: 24, fontWeight: FontWeight.w900)),
                          ]
                        )
                      )
                    )
                ],
              ),
            ),
          ),
        ),
      )
    );
  }
}

class _BuildDashedLine extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        return Flex(
          direction: Axis.vertical,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: List.generate(
            15,
            (_) => Container(width: 4, height: 15, color: Colors.white54)
          ),
        );
      },
    );
  }
}
