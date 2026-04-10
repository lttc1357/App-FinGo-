code = """import 'package:flutter/material.dart';
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

with open('lib/screens/academy_screen.dart', 'w') as f:
    f.write(code)

