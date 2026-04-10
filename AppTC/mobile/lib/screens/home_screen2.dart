import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: _buildAppBar(),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildProgressOverview(),
            const SizedBox(height: 16),
            _buildStreakAndRewards(),
            const SizedBox(height: 16),
            _buildVirtualPet(),
            const SizedBox(height: 16),
            _buildEventBanner(),
            const SizedBox(height: 16),
            _buildSmartRecommendation(),
            const SizedBox(height: 16),
            _buildMiniDashboard(),
            const SizedBox(height: 24),
            const Text('Nhiệm vụ hàng ngày', 
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            const SizedBox(height: 12),
            _buildDailyTasks(),
            const SizedBox(height: 24),
            _buildLeaderboardPreview(),
            const SizedBox(height: 30),
          ],
        ),
      ),
    );
  }

  // 7. Avatar / Hồ sơ nhanh
  AppBar _buildAppBar() {
    return AppBar(
      backgroundColor: Colors.white,
      elevation: 0,
      title: Row(
        children: [
          const CircleAvatar(
            backgroundColor: Colors.blueAccent,
            child: Icon(Icons.person, color: Colors.white),
          ),
          const SizedBox(width: 10),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: const [
              Text('Hi, User 👋', style: TextStyle(color: Colors.black, fontSize: 16, fontWeight: FontWeight.bold)),
              Text('Hạng: Bạc (Lv.5)',
                  style: TextStyle(color: Colors.grey, fontSize: 13)),
            ],
          ),
        ],
      ),
      actions: [
        IconButton(
          icon: const Icon(Icons.notifications_none, color: Colors.black),
          onPressed: () {},
        ),
      ],
    );
  }

  // 1. Tổng quan tiến trình (Progress Overview)
  Widget _buildProgressOverview() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(color: Colors.grey.withValues(alpha: 0.05), blurRadius: 10, spreadRadius: 1)
        ],
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: const [
              Text('Level 5', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16, color: Colors.blueAccent)),
              Text('1200 / 2000 XP', style: TextStyle(color: Colors.grey, fontSize: 14)),
            ],
          ),
          const SizedBox(height: 12),
          ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: const LinearProgressIndicator(
              value: 1200 / 2000,
              minHeight: 10,
              backgroundColor: Color(0xFFEEEEEE),
              color: Colors.blueAccent,
            ),
          ),
        ],
      ),
    );
  }

  // 3. Streak & 4. Reward
  Widget _buildStreakAndRewards() {
    return Row(
      children: [
        Expanded(
          child: Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: Colors.orange[50],
              borderRadius: BorderRadius.circular(16),
            ),
            child: Row(
              children: const [
                Icon(Icons.local_fire_department, color: Colors.orange, size: 28),
                SizedBox(width: 8),
                Expanded(
                  child: Text('5 Ngày Học\nLiên tiếp 🔥',
                      style: TextStyle(fontWeight: FontWeight.bold, color: Colors.deepOrange, fontSize: 13)),
                ),
              ],
            ),
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: Colors.yellow[50],
              borderRadius: BorderRadius.circular(16),
            ),
            child: Row(
              children: const [
                Icon(Icons.monetization_on, color: Colors.amber, size: 28),
                SizedBox(width: 8),
                Expanded(
                  child: Text('350 Coins\nNhận thưởng 🎁',
                      style: TextStyle(fontWeight: FontWeight.bold, color: Colors.orange, fontSize: 13)),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  // Pet (Mèo)
  Widget _buildVirtualPet() {
    return Center(
      child: Column(
        children: [
          Container(
            height: 140,
            width: 140,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.grey[200],
              border: Border.all(color: Colors.white, width: 4),
              boxShadow: [
                BoxShadow(color: Colors.grey.withValues(alpha: 0.2), blurRadius: 10)
              ]
            ),
            child: const Center(
              child: Icon(Icons.pets, size: 60, color: Colors.blueAccent),
            ),
          ),
          const SizedBox(height: 12),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            decoration: BoxDecoration(
              color: Colors.blue.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(20),
            ),
            child: const Text('Meo Meo! Cùng học tiếp nào!',
                style: TextStyle(fontStyle: FontStyle.italic, color: Colors.blueAccent, fontWeight: FontWeight.bold)),
          )
        ],
      ),
    );
  }

  // 9. Event / Challenge đặc biệt
  Widget _buildEventBanner() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: const LinearGradient(colors: [Color(0xFF8E2DE2), Color(0xFF4A00E0)]),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: const [
              Icon(Icons.stars, color: Colors.amber),
              SizedBox(width: 8),
              Text('Sự Kiện Tuần Này',
                style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 16)),
            ],
          ),
          const SizedBox(height: 8),
          const Text('Hoàn thành 10 tasks để nhận Thẻ quà tặng ngẫu nhiên!',
              style: TextStyle(color: Colors.white70, fontSize: 14)),
          const SizedBox(height: 16),
          ElevatedButton(
            onPressed: () {},
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.amber,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
            ),
            child: const Text('Tham gia ngay', style: TextStyle(color: Colors.black87, fontWeight: FontWeight.bold)),
          ),
        ],
      ),
    );
  }

  // 6. Gợi ý hành động tiếp theo
  Widget _buildSmartRecommendation() {
    return Card(
      elevation: 0,
      margin: EdgeInsets.zero,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: ListTile(
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        leading: Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: Colors.green.withValues(alpha: 0.1),
            shape: BoxShape.circle,
          ),
          child: const Icon(Icons.play_arrow, color: Colors.green),
        ),
        title: const Text('Gợi ý cho bạn', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14, color: Colors.grey)),
        subtitle: const Text('Tiếp tục bài học: Quản lý chi tiêu cá nhân', style: TextStyle(color: Colors.black87, fontWeight: FontWeight.w500)),
        trailing: const Icon(Icons.arrow_forward_ios, size: 16, color: Colors.grey),
        onTap: () {},
      ),
    );
  }

  // 8. Thống kê nhanh (Mini Dashboard)
  Widget _buildMiniDashboard() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        _buildStatItem('12', 'Tasks', Icons.task_alt, Colors.blue),
        _buildStatItem('24', 'Ngày HĐ', Icons.calendar_month, Colors.orange),
        _buildStatItem('4.5k', 'Tổng XP', Icons.speed, Colors.purple),
      ],
    );
  }

  Widget _buildStatItem(String value, String title, IconData icon, Color color) {
    return Container(
      width: 100,
      padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 8),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(color: Colors.grey.withValues(alpha: 0.05), blurRadius: 10, spreadRadius: 1)
        ],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, color: color, size: 28),
          const SizedBox(height: 8),
          Text(value, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
          Text(title, style: const TextStyle(color: Colors.grey, fontSize: 12)),
        ],
      ),
    );
  }

  // 2. Nhiệm vụ hàng ngày
  Widget _buildDailyTasks() {
    return Column(
      children: [
        _buildTaskItem('Điểm danh hằng ngày', '50 XP', true),
        _buildTaskItem('Hoàn thành 1 bài học', '100 XP', false),
        _buildTaskItem('Giữ chi tiêu dưới hạn mức', '200 XP', false),
      ],
    );
  }

  Widget _buildTaskItem(String title, String reward, bool isCompleted) {
    return Card(
      elevation: 0,
      margin: const EdgeInsets.only(bottom: 12),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
        side: BorderSide(color: isCompleted ? Colors.green.withValues(alpha: 0.3) : Colors.transparent),
      ),
      child: ListTile(
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
        leading: Icon(
          isCompleted ? Icons.check_circle : Icons.radio_button_unchecked,
          color: isCompleted ? Colors.green : Colors.grey[400],
          size: 28,
        ),
        title: Text(title,
            style: TextStyle(
                decoration: isCompleted ? TextDecoration.lineThrough : null,
                color: isCompleted ? Colors.grey : Colors.black87,
                fontWeight: FontWeight.w500)),
        trailing: Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
          decoration: BoxDecoration(
            color: Colors.amber.withValues(alpha: 0.1), 
            borderRadius: BorderRadius.circular(12)
          ),
          child: Text('+$reward', style: const TextStyle(color: Colors.amber, fontWeight: FontWeight.bold)),
        ),
      ),
    );
  }

  // 5. Leaderboard (Bảng xếp hạng) Preview
  Widget _buildLeaderboardPreview() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(color: Colors.grey.withValues(alpha: 0.05), blurRadius: 10, spreadRadius: 1)
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
               Row(
                 children: const [
                   Icon(Icons.emoji_events, color: Colors.amber),
                   SizedBox(width: 8),
                   Text('Bảng Xếp Hạng', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                 ],
               ),
              const Text('Xem tất cả', style: TextStyle(color: Colors.blueAccent, fontWeight: FontWeight.w500)),
            ],
          ),
          const SizedBox(height: 12),
          _buildLeaderboardItem('1', 'Hải Đăng', '5200 XP', Colors.amber),
          const Divider(height: 1),
          _buildLeaderboardItem('2', 'Ngọc Mai', '4900 XP', Colors.grey),
          const Divider(height: 1),
          Container(
            color: Colors.blue.withValues(alpha: 0.05),
            child: _buildLeaderboardItem('7', 'Bạn (User)', '4500 XP', Colors.blue, isUser: true),
          ),
        ],
      ),
    );
  }

  Widget _buildLeaderboardItem(String rank, String name, String xp, Color rankColor, {bool isUser = false}) {
    return ListTile(
      contentPadding: const EdgeInsets.symmetric(horizontal: 0),
      leading: Container(
        width: 30,
        alignment: Alignment.center,
        child: Text(rank, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18, color: rankColor)),
      ),
      title: Text(name, style: TextStyle(fontWeight: isUser ? FontWeight.bold : FontWeight.w500)),
      trailing: Text(xp, style: TextStyle(fontWeight: FontWeight.bold, color: isUser ? Colors.blueAccent : Colors.black87)),
    );
  }
}
