import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../global_theme_notifier.dart';
import 'help_support_screen.dart';
import 'terms_conditions_screen.dart';
import 'login_screen.dart';

class AcademyScreen extends StatefulWidget {
  const AcademyScreen({super.key});

  @override
  State<AcademyScreen> createState() => _AcademyScreenState();
}

class _AcademyScreenState extends State<AcademyScreen> {
  bool isNotificationEnabled = true;

  bool get isDarkMode => isDarkModeGlobal.value;

  @override
  Widget build(BuildContext context) {
    final isDarkMode = isDarkModeGlobal.value;
    final bgColor = isDarkMode ? const Color(0xFF1E1E1E) : const Color(0xFFF8F9FE);
    final cardColor = isDarkMode ? const Color(0xFF2C2C2C) : Colors.white;
    final textColor = isDarkMode ? Colors.white : const Color(0xFF2D3142);
    final subTextColor = isDarkMode ? Colors.grey.shade400 : Colors.grey.shade600;
    final shadowColor = isDarkMode ? Colors.black.withValues(alpha: 0.3) : Colors.grey.shade100;
    
    return Scaffold(
      backgroundColor: bgColor,
      body: SafeArea(
        bottom: false,
        child: SingleChildScrollView(
          padding: const EdgeInsets.only(bottom: 120),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildHeader(textColor),
              const SizedBox(height: 24),
              _buildProfileCard(cardColor, shadowColor, textColor, subTextColor),
              const SizedBox(height: 24),
              _buildSectionTitle('Cài Đặt Ứng Dụng'),
              _buildSettingsList(cardColor, shadowColor, textColor),
              const SizedBox(height: 24),
              _buildSectionTitle('Thông Tin'),
              _buildAboutList(cardColor, shadowColor, textColor),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHeader(Color textColor) {
    return Padding(
      padding: const EdgeInsets.only(top: 16, left: 24, right: 24),
      child: Text(
        'Cá Nhân',
        style: GoogleFonts.nunito(
          fontSize: 28,
          fontWeight: FontWeight.w900,
          color: textColor,
        ),
      ),
    );
  }

  Widget _buildProfileCard(Color cardColor, Color shadowColor, Color textColor, Color subTextColor) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 24),
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: cardColor,
        borderRadius: BorderRadius.circular(30),
        boxShadow: [
          BoxShadow(
            color: shadowColor,
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
                border: Border.all(color: Colors.blueAccent.withValues(alpha: 0.3), width: 3),
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
                Text('Sinh viên TMĐT \uD83C\uDF93', style: GoogleFonts.nunito(fontSize: 20, fontWeight: FontWeight.w900, color: textColor)),
                const SizedBox(height: 4),
                Text('Khoa Thương Mại Điện Tử', style: GoogleFonts.nunito(fontSize: 14, color: subTextColor, fontWeight: FontWeight.w600)),
                const SizedBox(height: 10),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                  decoration: BoxDecoration(color: Colors.green.withValues(alpha: 0.1), borderRadius: BorderRadius.circular(10)),
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

  Widget _buildSettingsList(Color cardColor, Color shadowColor, Color textColor) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 24),
      decoration: BoxDecoration(
        color: cardColor,
        borderRadius: BorderRadius.circular(24),
        boxShadow: [
          BoxShadow(
            color: shadowColor,
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        children: [
          _buildListTile(
            Icons.dark_mode,
            Colors.deepPurple,
            'Chế độ ban đêm',
            textColor,
            trailing: Switch(
              value: isDarkMode,
              onChanged: (v) {
                isDarkModeGlobal.value = v;
                  setState(() {});
              },
              activeThumbColor: Colors.deepPurple,
            ),
          ),
          Divider(height: 0, indent: 20, endIndent: 20, color: isDarkMode ? Colors.grey.shade800 : Colors.grey.shade200),
          _buildListTile(
            Icons.language, 
            Colors.blue, 
            'Ngôn ngữ', 
            textColor, 
            trailing: Text('Tiếng Việt', style: GoogleFonts.nunito(color: Colors.grey, fontWeight: FontWeight.bold, fontSize: 14)),
            onTap: () {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text('Tiếng Việt đang là ngôn ngữ mặc định.', style: GoogleFonts.nunito(fontWeight: FontWeight.bold)),
                  backgroundColor: Colors.blueAccent,
                ),
              );
            },
          ),
          Divider(height: 0, indent: 20, endIndent: 20, color: isDarkMode ? Colors.grey.shade800 : Colors.grey.shade200),
          _buildListTile(
            Icons.notifications_active,
            Colors.orange,
            'Thông báo rớt ví',
            textColor,
            trailing: Switch(
              value: isNotificationEnabled,
              onChanged: (v) {
                setState(() => isNotificationEnabled = v);
              },
              activeThumbColor: Colors.orange,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAboutList(Color cardColor, Color shadowColor, Color textColor) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 24),
      decoration: BoxDecoration(
        color: cardColor,
        borderRadius: BorderRadius.circular(24),
        boxShadow: [
          BoxShadow(
            color: shadowColor,
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        children: [
            _buildListTile(Icons.help_outline, Colors.teal, 'Trợ giúp & Hỗ trợ', textColor, onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const HelpSupportScreen()),
              );
            }),
          Divider(height: 0, indent: 20, endIndent: 20, color: isDarkMode ? Colors.grey.shade800 : Colors.grey.shade200),
            _buildListTile(Icons.assignment, Colors.blueGrey, 'Điều khoản & Quy định', textColor, onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const TermsConditionsScreen()),
              );
            }),
          Divider(height: 0, indent: 20, endIndent: 20, color: isDarkMode ? Colors.grey.shade800 : Colors.grey.shade200),
            _buildListTile(Icons.logout, Colors.redAccent, 'Đăng xuất', textColor, titleColor: Colors.redAccent, onTap: () {
              showDialog(
                context: context,
                builder: (BuildContext dialogContext) {
                  return AlertDialog(
                    title: Text('Xác nhận đăng xuất', style: GoogleFonts.nunito(fontWeight: FontWeight.bold)),
                    content: Text('Bạn có chắc chắn muốn đăng xuất không?', style: GoogleFonts.nunito()),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                    actions: [
                      TextButton(
                        onPressed: () {
                          Navigator.pop(dialogContext); // Đóng dialog
                        },
                        child: Text('Không', style: GoogleFonts.nunito(color: Colors.grey, fontWeight: FontWeight.bold)),
                      ),
                      TextButton(
                        onPressed: () {
                          Navigator.pop(dialogContext); // Đóng dialog
                          Navigator.pushAndRemoveUntil(
                            context,
                            MaterialPageRoute(builder: (context) => const LoginScreen()),
                            (route) => false, // Xóa hết lịch sử các màn hình trước
                          );
                        },
                        child: Text('Có', style: GoogleFonts.nunito(color: Colors.redAccent, fontWeight: FontWeight.bold)),
                      ),
                    ],
                  );
                },
              );
            }),
          ],
        ),
      );
    }

  Widget _buildListTile(IconData icon, Color iconColor, String title, Color defaultTextColor, {Widget? trailing, Color? titleColor, VoidCallback? onTap}) {
    return ListTile(
      contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
      leading: Container(
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: iconColor.withValues(alpha: 0.15),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Icon(icon, color: iconColor, size: 20),
      ),
      title: Text(
        title,
        style: GoogleFonts.nunito(
          fontSize: 16,
          fontWeight: FontWeight.w700,
          color: titleColor ?? defaultTextColor,
        ),
      ),
      trailing: trailing ?? const Icon(Icons.chevron_right, color: Colors.grey),
      onTap: onTap ?? () {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Đang phát triển tính năng: $title', 
                style: GoogleFonts.nunito(fontWeight: FontWeight.bold)),
            behavior: SnackBarBehavior.floating,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          ),
        );
      },
    );
  }
}
