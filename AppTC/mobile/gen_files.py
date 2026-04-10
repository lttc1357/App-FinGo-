import urllib.request
import base64

play_code = """import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'games/cat_racing_game.dart';
import 'games/platform_jump_game.dart';
import 'games/fishing_cat_game.dart';
import 'games/cat_ball_throw_game.dart';

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
      if (mounted) {
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
      backgroundColor: const Color(0xFFF8F9FE),
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
                  style: GoogleFonts.nunito(fontSize: 20, fontWeight: FontWeight.w900, color: const Color(0xFF2D3142)),
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
                  style: GoogleFonts.nunito(fontSize: 28, fontWeight: FontWeight.w900, color: const Color(0xFF2D3142)),
                ),
                Text(
                  'Xả stress sau những giờ code',
                  style: GoogleFonts.nunito(fontSize: 14, color: Colors.grey.shade600, fontWeight: FontWeight.w600),
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
        boxShadow: [BoxShadow(color: const Color(0xFF764BA2).withOpacity(0.3), blurRadius: 15, offset: const Offset(0, 10))],
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                  decoration: BoxDecoration(color: Colors.white.withOpacity(0.2), borderRadius: BorderRadius.circular(10)),
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
                  style: GoogleFonts.nunito(fontSize: 13, color: Colors.white.withOpacity(0.8)),
                ),
                const SizedBox(height: 16),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                     backgroundColor: Colors.white,
                     foregroundColor: const Color(0xFF764BA2),
                     shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                  ),
                  onPressed: () => _playGame(context, const CatBallThrowGame()),
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
            title: 'Mèo bay nhảy',
            desc: 'Nhảy qua các bậc thềm để nhặt xu',
            icon: Icons.rocket_launch,
            color: Colors.pinkAccent,
            onTap: () => _playGame(context, const PlatformJumpGame()),
          ),
          const SizedBox(height: 16),
          _buildGameCard(
            title: 'Mèo bắt cá',
            desc: 'Thả cần đúng lúc để câu cá',
            icon: Icons.phishing,
            color: Colors.teal,
            onTap: () => _playGame(context, const FishingCatGame()),
          ),
          const SizedBox(height: 16),
          _buildGameCard(
            title: 'Mèo đua top',
            desc: 'Điều khiển né chướng ngại vật',
            icon: Icons.sports_motorsports,
            color: Colors.orangeAccent,
            onTap: () => _playGame(context, const CatRacingGame()),
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
          color: Colors.white,
          borderRadius: BorderRadius.circular(24),
          boxShadow: [BoxShadow(color: Colors.grey.shade100, blurRadius: 10, offset: const Offset(0, 4))],
        ),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(color: color.withOpacity(0.15), borderRadius: BorderRadius.circular(16)),
              child: Icon(icon, color: color, size: 30),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(title, style: GoogleFonts.nunito(fontSize: 18, fontWeight: FontWeight.bold, color: const Color(0xFF2D3142))),
                  const SizedBox(height: 4),
                  Text(desc, style: GoogleFonts.nunito(fontSize: 13, color: Colors.grey.shade500, fontWeight: FontWeight.w600)),
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
"""

academy_code = """import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AcademyScreen extends StatelessWidget {
  const AcademyScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8F9FE),
      body: SafeArea(
        bottom: false,
        child: SingleChildScrollView(
          padding: const EdgeInsets.only(bottom: 120),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildHeader(),
              const SizedBox(height: 24),
              _buildProfileCard(),
              const SizedBox(height: 24),
              _buildSectionTitle('Cài Đặt Ứng Dụng'),
              _buildSettingsList(),
              const SizedBox(height: 24),
              _buildSectionTitle('Thông Tin'),
              _buildAboutList(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Padding(
      padding: const EdgeInsets.only(top: 16, left: 24, right: 24),
      child: Text(
        'Cá Nhân',
        style: GoogleFonts.nunito(
          fontSize: 28,
          fontWeight: FontWeight.w900,
          color: const Color(0xFF2D3142),
        ),
      ),
    );
  }

  Widget _buildProfileCard() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 24),
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(30),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.shade100,
            blurRadius: 15,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Row(
        children: [
          Container(
             decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(color: Colors.blueAccent.withOpacity(0.3), width: 3),
             ),
             child: CircleAvatar(
              radius: 36,
              backgroundColor: Colors.blue.shade50,
              child: ClipOval(
                child: Image.network(
                  'https://api.dicebear.com/7.x/avataaars/png?seed=Alex&backgroundColor=b6e3f4',
                  width: 72,
                  height: 72,
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
          const SizedBox(width: 20),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Sinh viên TMĐT \uD83C\uDF93', style: GoogleFonts.nunito(fontSize: 20, fontWeight: FontWeight.w900, color: const Color(0xFF2D3142))),
                const SizedBox(height: 4),
                Text('Khoa Thương Mại Điện Tử', style: GoogleFonts.nunito(fontSize: 14, color: Colors.grey.shade600, fontWeight: FontWeight.w600)),
                const SizedBox(height: 10),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                  decoration: BoxDecoration(color: Colors.green.withOpacity(0.1), borderRadius: BorderRadius.circular(10)),
                  child: Text('Tài khoản Premium', style: GoogleFonts.nunito(color: Colors.green, fontSize: 12, fontWeight: FontWeight.bold)),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.only(left: 24, bottom: 12),
      child: Text(
        title,
        style: GoogleFonts.nunito(
          fontSize: 16,
          fontWeight: FontWeight.w900,
          color: Colors.grey.shade400,
          letterSpacing: 1.2,
        ),
      ),
    );
  }

  Widget _buildSettingsList() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 24),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(24),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.shade100,
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        children: [
          _buildListTile(Icons.dark_mode, Colors.deepPurple, 'Chế độ ban đêm', trailing: Switch(value: false, onChanged: (v) {}, activeColor: Colors.deepPurple)),
          const Divider(height: 0, indent: 20, endIndent: 20),
          _buildListTile(Icons.language, Colors.blue, 'Ngôn ngữ', trailing: Text('Tiếng Việt', style: GoogleFonts.nunito(color: Colors.grey, fontWeight: FontWeight.bold, fontSize: 14))),
          const Divider(height: 0, indent: 20, endIndent: 20),
          _buildListTile(Icons.notifications_active, Colors.orange, 'Thông báo rớt ví', trailing: Switch(value: true, onChanged: (v) {}, activeColor: Colors.orange)),
        ],
      ),
    );
  }

  Widget _buildAboutList() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 24),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(24),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.shade100,
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        children: [
          _buildListTile(Icons.help_outline, Colors.teal, 'Trợ giúp & Hỗ trợ'),
          const Divider(height: 0, indent: 20, endIndent: 20),
          _buildListTile(Icons.assignment, Colors.blueGrey, 'Điều khoản & Quy định'),
          const Divider(height: 0, indent: 20, endIndent: 20),
          _buildListTile(Icons.logout, Colors.redAccent, 'Đăng xuất', titleColor: Colors.redAccent),
        ],
      ),
    );
  }

  Widget _buildListTile(IconData icon, Color iconColor, String title, {Widget? trailing, Color? titleColor}) {
    return ListTile(
      contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
      leading: Container(
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: iconColor.withOpacity(0.15),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Icon(icon, color: iconColor, size: 20),
      ),
      title: Text(
        title,
        style: GoogleFonts.nunito(
          fontSize: 16,
          fontWeight: FontWeight.w700,
          color: titleColor ?? const Color(0xFF2D3142),
        ),
      ),
      trailing: trailing ?? const Icon(Icons.chevron_right, color: Colors.grey),
      onTap: () {},
    );
  }
}
"""

with open('lib/screens/play_screen.dart', 'w') as f:
    f.write(play_code)

with open('lib/screens/academy_screen.dart', 'w') as f:
    f.write(academy_code)

