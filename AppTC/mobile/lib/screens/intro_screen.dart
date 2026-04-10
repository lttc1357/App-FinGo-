import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../main_screen.dart';
import 'login_screen.dart';

class IntroScreen extends StatelessWidget {
  const IntroScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    final bgColor = isDark ? const Color(0xFF1E1E1E) : const Color(0xFFF8F9FE);
    final textColor = isDark ? Colors.white : const Color(0xFF2D3142);
    final subTextColor = isDark ? Colors.grey.shade400 : Colors.grey.shade600;
    final cardColor = isDark ? const Color(0xFF2C2C2C) : Colors.white;

    return Scaffold(
      backgroundColor: bgColor,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 32),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(height: 20),
              // App Icon / Illustration (Placeholder for the gem icon)
              Container(
                width: 120,
                height: 120,
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [Color(0xFF8C9EFF), Color(0xFFC7B8EA)],
                  ),
                  borderRadius: BorderRadius.circular(32),
                  boxShadow: [
                    BoxShadow(
                      color: const Color(0xFF8C9EFF).withOpacity(0.3),
                      blurRadius: 20,
                      offset: const Offset(0, 10),
                    )
                  ],
                ),
                child: const Center(
                  child: Icon(Icons.diamond_outlined, size: 60, color: Colors.white),
                ),
              ),
              const SizedBox(height: 32),
              
              Text(
                'FinGo',
                style: GoogleFonts.nunito(
                  fontSize: 40,
                  fontWeight: FontWeight.w900,
                  color: const Color(0xFF5A78FF),
                  letterSpacing: 1.5,
                ),
              ),
              const SizedBox(height: 24),
              
              Text(
                'Biến mỗi giao dịch\nthành một cuộc chơi \uD83C\uDFAE',
                textAlign: TextAlign.center,
                style: GoogleFonts.nunito(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: textColor,
                  height: 1.3,
                ),
              ),
              const SizedBox(height: 16),
              
              Text(
                'FinGo mô phỏng hệ thống thanh toán điện tử đơn giản, kết hợp Gamification giúp bạn quản lý tài chính chuẩn, vừa trải nghiệm những trò chơi thú vị!',
                textAlign: TextAlign.center,
                style: GoogleFonts.nunito(
                  fontSize: 16,
                  color: subTextColor,
                  height: 1.5,
                ),
              ),
              const SizedBox(height: 48),

              // Feature List
              _buildFeatureItem(
                icon: Icons.account_balance_wallet,
                iconBgColor: const Color(0xFFFFE0B2),
                iconColor: const Color(0xFFF57C00),
                title: 'Quản lý tài chính',
                desc: 'Theo dõi chi tiêu 1 cách dễ dàng',
                cardColor: cardColor,
                textColor: textColor,
                subTextColor: subTextColor,
              ),
              _buildFeatureItem(
                icon: Icons.sports_esports,
                iconBgColor: const Color(0xFFE0E0E0), // Adjust to match
                iconColor: const Color(0xFF424242),
                title: 'Chơi game vui nhộn',
                desc: 'Học khi chơi, chơi khi học',
                cardColor: cardColor,
                textColor: textColor,
                subTextColor: subTextColor,
              ),
              _buildFeatureItem(
                icon: Icons.star_border,
                iconBgColor: const Color(0xFFFFECB3),
                iconColor: const Color(0xFFF57C00),
                title: 'Nhận phần thưởng',
                desc: 'Kiếm điểm & nâng cấp dần',
                cardColor: cardColor,
                textColor: textColor,
                subTextColor: subTextColor,
              ),
              
              const SizedBox(height: 32),

              // Buttons
              SizedBox(
                width: double.infinity,
                height: 56,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const LoginScreen()),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF5A78FF),
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                    elevation: 5,
                    shadowColor: const Color(0xFF5A78FF).withOpacity(0.5),
                  ),
                  child: Text(
                    'Bắt đầu trải nghiệm',
                    style: GoogleFonts.nunito(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 16),
              
              SizedBox(
                width: double.infinity,
                height: 56,
                child: OutlinedButton(
                  onPressed: () {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(builder: (context) => const MainScreen()),
                    );
                  },
                  style: OutlinedButton.styleFrom(
                    side: const BorderSide(color: Color(0xFF5A78FF), width: 2),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(Icons.touch_app_outlined, color: Color(0xFF5A78FF)),
                      const SizedBox(width: 8),
                      Text(
                        'Chơi thử FinGo',
                        style: GoogleFonts.nunito(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: const Color(0xFF5A78FF),
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

  Widget _buildFeatureItem({
    required IconData icon,
    required Color iconBgColor,
    required Color iconColor,
    required String title,
    required String desc,
    required Color cardColor,
    required Color textColor,
    required Color subTextColor,
  }) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: cardColor,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: iconBgColor,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(icon, color: iconColor),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: GoogleFonts.nunito(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: textColor,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  desc,
                  style: GoogleFonts.nunito(
                    fontSize: 14,
                    color: subTextColor,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
