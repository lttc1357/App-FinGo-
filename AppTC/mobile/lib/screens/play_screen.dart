import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'games/cat_racing_game.dart';
import 'games/platform_jump_game.dart';
import 'games/fishing_cat_game.dart';
import 'games/cat_ball_throw_game.dart';
import 'quiz_list_screen.dart';

class PlayScreen extends StatefulWidget {
  const PlayScreen({super.key});

  @override
  State<PlayScreen> createState() => _PlayScreenState();
}

class _PlayScreenState extends State<PlayScreen> {
  int totalCoins = 3500;

  void _playGame(BuildContext context, Widget gameScreen) async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => gameScreen),
    );
    if (result != null && result is int) {
      if (context.mounted) {
        setState(() {
          totalCoins += result;
        });
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Thưởng +$result xu \uD83D\uDCB0 từ trò chơi!', 
              style: GoogleFonts.nunito(fontWeight: FontWeight.bold)),
            behavior: SnackBarBehavior.floating,
            backgroundColor: Colors.green,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          )
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      
      body: SafeArea(
        bottom: false,
        child: SingleChildScrollView(
          padding: const EdgeInsets.only(bottom: 120, top: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildHeader(),
              const SizedBox(height: 24),
              _buildHeroBanner(),
              const SizedBox(height: 24),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: Text(
                  'Danh sách trò chơi',
                  style: GoogleFonts.nunito(fontSize: 20, fontWeight: FontWeight.w900, color: Theme.of(context).colorScheme.onSurface),
                ),
              ),
              const SizedBox(height: 16),
              _buildGameList(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Góc Giải Trí \uD83C\uDFAE',
                  style: GoogleFonts.nunito(fontSize: 28, fontWeight: FontWeight.w900, color: Theme.of(context).colorScheme.onSurface),
                ),
                Text(
                  'Xả stress sau những giờ code',
                  style: GoogleFonts.nunito(fontSize: 14, color: Theme.of(context).colorScheme.onSurfaceVariant, fontWeight: FontWeight.w600),
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
          const SizedBox(width: 12),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
            decoration: BoxDecoration(
              color: Colors.amber.shade100,
              borderRadius: BorderRadius.circular(20),
            ),
            child: Row(
              children: [
                const Icon(Icons.monetization_on, color: Colors.amber, size: 20),
                const SizedBox(width: 4),
                Text(
                  '$totalCoins',
                  style: GoogleFonts.nunito(fontSize: 16, fontWeight: FontWeight.w900, color: Colors.amber.shade900),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget _buildHeroBanner() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 24),
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [Color(0xFF667EEA), Color(0xFF764BA2)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(30),
        boxShadow: [BoxShadow(color: const Color(0xFF764BA2).withValues(alpha: 0.3), blurRadius: 15, offset: const Offset(0, 10))],
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                  decoration: BoxDecoration(color: Theme.of(context).cardColor.withValues(alpha: 0.2), borderRadius: BorderRadius.circular(10)),
                  child: Text('HOT \uD83D\uDD25', style: GoogleFonts.nunito(color: Colors.white, fontSize: 12, fontWeight: FontWeight.bold)),
                ),
                const SizedBox(height: 12),
                Text(
                  'Siêu Mèo Ném Bóng',
                  style: GoogleFonts.nunito(fontSize: 22, fontWeight: FontWeight.w900, color: Colors.white),
                ),
                const SizedBox(height: 8),
                Text(
                  'Cày game để kiếm thêm xu nhé!',
                  style: GoogleFonts.nunito(fontSize: 13, color: Colors.white.withValues(alpha: 0.8)),
                ),
                const SizedBox(height: 16),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                     backgroundColor: Colors.white,
                     foregroundColor: const Color(0xFF764BA2),
                     shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                  ),
                  onPressed: () => _playGame(context, CatBallThrowGame()),
                  child: Text('CHƠI NGAY', style: GoogleFonts.nunito(fontWeight: FontWeight.w900)),
                )
              ],
            ),
          ),
          const SizedBox(width: 16),
          const Icon(Icons.sports_basketball, size: 80, color: Colors.white70),
        ],
      ),
    );
  }

  Widget _buildGameList() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: Column(
        children: [
          _buildGameCard(
            title: 'Khóa học Giải đố',
            desc: 'Trả lời trắc nghiệm tài chính',
            icon: Icons.school,
            color: Colors.indigoAccent,
            onTap: () => _playGame(context, const QuizListScreen()),
          ),
          const SizedBox(height: 16),
          _buildGameCard(
            title: 'Mèo bay nhảy',
            desc: 'Nhảy qua các bậc thềm để nhặt xu',
            icon: Icons.rocket_launch,
            color: Colors.pinkAccent,
            onTap: () => _playGame(context, PlatformJumpGame()),
          ),
          const SizedBox(height: 16),
          _buildGameCard(
            title: 'Mèo bắt cá',
            desc: 'Thả cần đúng lúc để câu cá',
            icon: Icons.phishing,
            color: Colors.teal,
            onTap: () => _playGame(context, FishingCatGame()),
          ),
          const SizedBox(height: 16),
          _buildGameCard(
            title: 'Mèo đua xe',
            desc: 'Điều khiển né chướng ngại vật',
            icon: Icons.sports_motorsports,
            color: Colors.orangeAccent,
            onTap: () => _playGame(context, CatRacingGame()),
          ),
        ],
      ),
    );
  }

  Widget _buildGameCard({required String title, required String desc, required IconData icon, required Color color, required VoidCallback onTap}) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
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
              decoration: BoxDecoration(color: color.withValues(alpha: 0.15), borderRadius: BorderRadius.circular(16)),
              child: Icon(icon, color: color, size: 30),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(title, style: GoogleFonts.nunito(fontSize: 18, fontWeight: FontWeight.bold, color: Theme.of(context).colorScheme.onSurface)),
                  const SizedBox(height: 4),
                  Text(desc, style: GoogleFonts.nunito(fontSize: 13, color: Theme.of(context).colorScheme.onSurfaceVariant, fontWeight: FontWeight.w600)),
                ],
              ),
            ),
            Icon(Icons.chevron_right, color: Colors.grey.shade400),
          ],
        ),
      ),
    );
  }
}
