code = """import 'package:flutter/material.dart';
import '../theme.dart';
import 'package:google_fonts/google_fonts.dart';

class HomeScreen extends StatefulWidget {
  final VoidCallback onAcademyTap;

  const HomeScreen({super.key, required this.onAcademyTap});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _fadeAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 800),
    );
    _fadeAnimation = CurvedAnimation(parent: _controller, curve: Curves.easeIn);
    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8F9FE),
      body: SafeArea(
        bottom: false,
        child: SingleChildScrollView(
          padding: const EdgeInsets.only(bottom: 120), // Tránh bottom nav bar
          child: FadeTransition(
            opacity: _fadeAnimation,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildHeader(),
                const SizedBox(height: 24),
                _buildBalanceCard(),
                const SizedBox(height: 32),
                _buildQuickActions(),
                const SizedBox(height: 32),
                _buildRecentTransactions(),
                const SizedBox(height: 32),
                _buildBudgetWarning(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 16.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Chào buổi sáng,',
                style: GoogleFonts.nunito(
                  fontSize: 16,
                  color: Colors.grey.shade600,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                'Sinh Viên IT 🎓',
                style: GoogleFonts.nunito(
                  fontSize: 24,
                  fontWeight: FontWeight.w900,
                  color: const Color(0xFF2D3142),
                ),
              ),
            ],
          ),
          Container(
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              boxShadow: [
                BoxShadow(
                  color: Colors.blueAccent.withOpacity(0.2),
                  blurRadius: 10,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: CircleAvatar(
              radius: 28,
              backgroundColor: Colors.white,
              child: ClipOval(
                child: Image.network(
                  'https://api.dicebear.com/7.x/avataaars/png?seed=Felix&backgroundColor=b6e3f4',
                  width: 50,
                  height: 50,
                  fit: BoxFit.cover,
                ),
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget _buildBalanceCard() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 24.0),
      padding: const EdgeInsets.all(24.0),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [Color(0xFF3A7BD5), Color(0xFF3A6073)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(30),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFF3A7BD5).withOpacity(0.4),
            blurRadius: 20,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Tổng tiền hiện có',
                style: GoogleFonts.nunito(
                  fontSize: 16,
                  color: Colors.white70,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const Icon(Icons.account_balance_wallet, color: Colors.white70),
            ],
          ),
          const SizedBox(height: 12),
          Text(
            '1,250,000 đ',
            style: GoogleFonts.nunito(
              fontSize: 36,
              fontWeight: FontWeight.w900,
              color: Colors.white,
            ),
          ),
          const SizedBox(height: 24),
          Row(
            children: [
              Expanded(
                child: _buildIncomeExpenseItem(
                  icon: Icons.arrow_downward,
                  iconColor: Colors.greenAccent,
                  label: 'Thu nhập (Tháng)',
                  amount: '3,000,000',
                ),
              ),
              Container(width: 1, height: 40, color: Colors.white30),
              Expanded(
                child: _buildIncomeExpenseItem(
                  icon: Icons.arrow_upward,
                  iconColor: Colors.redAccent,
                  label: 'Đã chi',
                  amount: '1,750,000',
                ),
              ),
            ],
          )
        ],
      ),
    );
  }

  Widget _buildIncomeExpenseItem({
    required IconData icon,
    required Color iconColor,
    required String label,
    required String amount,
  }) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              padding: const EdgeInsets.all(4),
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.2),
                shape: BoxShape.circle,
              ),
              child: Icon(icon, color: iconColor, size: 16),
            ),
            const SizedBox(width: 8),
            Text(
              label,
              style: GoogleFonts.nunito(
                fontSize: 13,
                color: Colors.white70,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
        const SizedBox(height: 8),
        Text(
          '$amount đ',
          style: GoogleFonts.nunito(
            fontSize: 18,
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        )
      ],
    );
  }

  Widget _buildQuickActions() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          _buildActionBtn(icon: Icons.add, label: 'Thêm thu', color: Colors.green),
          _buildActionBtn(icon: Icons.remove, label: 'Thêm chi', color: Colors.redAccent),
          _buildActionBtn(icon: Icons.pie_chart, label: 'Ngân sách', color: Colors.orangeAccent),
          _buildActionBtn(icon: Icons.receipt_long, label: 'Hóa đơn', color: Colors.purpleAccent),
        ],
      ),
    );
  }

  Widget _buildActionBtn({required IconData icon, required String label, required Color color}) {
    return Column(
      children: [
        Container(
          width: 56,
          height: 56,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(20),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.15),
                blurRadius: 15,
                offset: const Offset(0, 8),
              ),
            ],
          ),
          child: Icon(icon, color: color, size: 28),
        ),
        const SizedBox(height: 12),
        Text(
          label,
          style: GoogleFonts.nunito(
            fontSize: 13,
            fontWeight: FontWeight.w700,
            color: const Color(0xFF4F5E7B),
          ),
        )
      ],
    );
  }

  Widget _buildRecentTransactions() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Giao dịch gần đây',
                style: GoogleFonts.nunito(
                  fontSize: 20,
                  fontWeight: FontWeight.w900,
                  color: const Color(0xFF2D3142),
                ),
              ),
              Text(
                'Xem tất cả',
                style: GoogleFonts.nunito(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  color: Colors.blueAccent,
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          _buildTransactionItem(
            icon: Icons.fastfood,
            iconColor: Colors.orange,
            title: 'Ăn trưa (Cơm tấm)',
            subtitle: 'Hôm nay, 12:30',
            amount: '-45,000 đ',
            isExpense: true,
          ),
          _buildTransactionItem(
            icon: Icons.local_cafe,
            iconColor: Colors.brown,
            title: 'Trà đá cổng trường',
            subtitle: 'Hôm nay, 09:15',
            amount: '-15,000 đ',
            isExpense: true,
          ),
          _buildTransactionItem(
            icon: Icons.attach_money,
            iconColor: Colors.green,
            title: 'Mẹ gửi tiền tiêu vặt',
            subtitle: 'Hôm qua',
            amount: '+2,000,000 đ',
            isExpense: false,
          ),
          _buildTransactionItem(
            icon: Icons.menu_book,
            iconColor: Colors.blue,
            title: 'Mua giáo trình C++',
            subtitle: '10 Tháng 4',
            amount: '-120,000 đ',
            isExpense: true,
          ),
        ],
      ),
    );
  }

  Widget _buildTransactionItem({
    required IconData icon,
    required Color iconColor,
    required String title,
    required String subtitle,
    required String amount,
    required bool isExpense,
  }) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.05),
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
              color: iconColor.withOpacity(0.15),
              borderRadius: BorderRadius.circular(16),
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
                    color: const Color(0xFF2D3142),
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  subtitle,
                  style: GoogleFonts.nunito(
                    fontSize: 13,
                    fontWeight: FontWeight.w600,
                    color: Colors.grey.shade500,
                  ),
                ),
              ],
            ),
          ),
          Text(
            amount,
            style: GoogleFonts.nunito(
              fontSize: 16,
              fontWeight: FontWeight.w900,
              color: isExpense ? Colors.redAccent : Colors.green,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBudgetWarning() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 24.0),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: const Color(0xFFFFF4E5),
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: Colors.orange.withOpacity(0.5)),
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(10),
            decoration: const BoxDecoration(
              color: Colors.orange,
              shape: BoxShape.circle,
            ),
            child: const Icon(Icons.warning_amber_rounded, color: Colors.white),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Cảnh báo ngân sách ăn uống',
                  style: GoogleFonts.nunito(
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                    color: Colors.orange.shade800,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  'Bạn đã tiêu 80% ngân sách ăn uống tháng này. Hãy tiết kiệm nhé!',
                  style: GoogleFonts.nunito(
                    fontSize: 13,
                    color: Colors.orange.shade800,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
"""

with open('lib/screens/home_screen.dart', 'w') as f:
    f.write(code)

