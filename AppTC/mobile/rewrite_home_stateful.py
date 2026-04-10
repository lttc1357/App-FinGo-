import re

code = """import 'dart:math';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Transaction {
  final String id;
  final String title;
  final double amount;
  final bool isExpense;
  final DateTime date;
  final IconData icon;
  final Color iconColor;

  Transaction({
    required this.id,
    required this.title,
    required this.amount,
    required this.isExpense,
    required this.date,
    required this.icon,
    required this.iconColor,
  });
}

class HomeScreen extends StatefulWidget {
  final VoidCallback onAcademyTap;

  const HomeScreen({super.key, required this.onAcademyTap});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _fadeAnimation;

  List<Transaction> transactions = [
    Transaction(
      id: '1',
      title: 'Ăn trưa cơm tấm',
      amount: 45000,
      isExpense: true,
      date: DateTime.now().subtract(const Duration(minutes: 30)),
      icon: Icons.fastfood,
      iconColor: Colors.orange,
    ),
    Transaction(
      id: '2',
      title: 'Trà đá cổng trường',
      amount: 15000,
      isExpense: true,
      date: DateTime.now().subtract(const Duration(hours: 2)),
      icon: Icons.local_cafe,
      iconColor: Colors.brown,
    ),
    Transaction(
      id: '3',
      title: 'Ba Mẹ gửi tiền tiêu',
      amount: 2000000,
      isExpense: false,
      date: DateTime.now().subtract(const Duration(days: 1)),
      icon: Icons.attach_money,
      iconColor: Colors.green,
    ),
    Transaction(
      id: '4',
      title: 'Đăng ký khóa học Marketing',
      amount: 350000,
      isExpense: true,
      date: DateTime.now().subtract(const Duration(days: 2)),
      icon: Icons.menu_book,
      iconColor: Colors.blue,
    ),
  ];

  double get totalIncome => transactions.where((t) => !t.isExpense).fold(0.0, (sum, item) => sum + item.amount);
  double get totalExpense => transactions.where((t) => t.isExpense).fold(0.0, (sum, item) => sum + item.amount);
  double get currentBalance => totalIncome - totalExpense;

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

  void _showAddTransactionDialog(bool isExpenseType) {
    String titleStr = '';
    String amountStr = '';
    final _formKey = GlobalKey<FormState>();

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      builder: (ctx) {
        return Padding(
          padding: EdgeInsets.only(
            bottom: MediaQuery.of(ctx).viewInsets.bottom,
            left: 24,
            right: 24,
            top: 24,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                isExpenseType ? 'Thêm khoản chi' : 'Thêm khoản thu',
                style: GoogleFonts.nunito(fontSize: 22, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 20),
              Form(
                key: _formKey,
                child: Column(
                  children: [
                    TextFormField(
                      decoration: InputDecoration(
                        labelText: 'Nội dung (Vd: Trà sữa, Nạp thẻ...)',
                        border: OutlineInputBorder(borderRadius: BorderRadius.circular(16)),
                      ),
                      validator: (val) => val == null || val.isEmpty ? 'Vui lòng nhập nội dung' : null,
                      onSaved: (val) => titleStr = val!,
                    ),
                    const SizedBox(height: 16),
                    TextFormField(
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                        labelText: 'Số tiền (VND)',
                        border: OutlineInputBorder(borderRadius: BorderRadius.circular(16)),
                        prefixIcon: const Icon(Icons.money),
                      ),
                      validator: (val) {
                        if (val == null || val.isEmpty) return 'Vui lòng nhập số tiền';
                        if (double.tryParse(val) == null) return 'Số tiền không hợp lệ';
                        return null;
                      },
                      onSaved: (val) => amountStr = val!,
                    ),
                    const SizedBox(height: 24),
                    SizedBox(
                      width: double.infinity,
                      height: 50,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: isExpenseType ? Colors.redAccent : Colors.green,
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                        ),
                        onPressed: () {
                          if (_formKey.currentState!.validate()) {
                            _formKey.currentState!.save();
                            final newAmount = double.parse(amountStr);
                            
                            setState(() {
                              transactions.insert(0, Transaction(
                                id: DateTime.now().toString(),
                                title: titleStr,
                                amount: newAmount,
                                isExpense: isExpenseType,
                                date: DateTime.now(),
                                icon: isExpenseType ? Icons.shopping_bag : Icons.account_balance_wallet,
                                iconColor: isExpenseType ? Colors.redAccent : Colors.teal,
                              ));
                            });
                            Navigator.of(ctx).pop();
                          }
                        },
                        child: Text(
                          'XÁC NHẬN GHI SỔ',
                          style: GoogleFonts.nunito(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.white),
                        ),
                      ),
                    ),
                    const SizedBox(height: 24),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  void _showNotice(String msg) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(msg, style: GoogleFonts.nunito(fontWeight: FontWeight.bold)),
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      )
    );
  }

  String _formatCurrency(double val) {
    return val.toStringAsFixed(0).replaceAllMapped(RegExp(r'(\\d{1,3})(?=(\\d{3})+(?!\\d))'), (Match m) => '${m[1]},');
  }
  
  String _formatDate(DateTime dt) {
    final now = DateTime.now();
    final diff = now.difference(dt);
    if (diff.inDays == 0) {
      if (diff.inHours == 0) return '${diff.inMinutes} phút trước';
      return '${diff.inHours} giờ trước';
    } else if (diff.inDays == 1) {
      return 'Hôm qua';
    }
    return '${dt.day}/${dt.month}/${dt.year}';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8F9FE),
      body: SafeArea(
        bottom: false,
        child: SingleChildScrollView(
          padding: const EdgeInsets.only(bottom: 120),
          child: FadeTransition(
            opacity: _fadeAnimation,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildHeader(),
                const SizedBox(height: 16),
                _buildBalanceCard(),
                const SizedBox(height: 28),
                _buildQuickActions(),
                const SizedBox(height: 28),
                _buildBudgetWarning(),
                const SizedBox(height: 20),
                _buildRecentTransactions(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 12.0),
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
                'Sinh viên TMĐT 🎓',
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
                  'https://api.dicebear.com/7.x/avataaars/png?seed=Alex&backgroundColor=b6e3f4',
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
            '${_formatCurrency(currentBalance)} đ',
            style: GoogleFonts.nunito(
              fontSize: 34,
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
                  label: 'Tổng thu',
                  amount: '${_formatCurrency(totalIncome)} đ',
                ),
              ),
              Container(width: 1, height: 40, color: Colors.white30),
              Expanded(
                child: _buildIncomeExpenseItem(
                  icon: Icons.arrow_upward,
                  iconColor: Colors.redAccent,
                  label: 'Tổng chi',
                  amount: '${_formatCurrency(totalExpense)} đ',
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
          amount,
          style: GoogleFonts.nunito(
            fontSize: 16,
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
          _buildActionBtn(
            icon: Icons.add, 
            label: 'Thêm thu', 
            color: Colors.green,
            onTap: () => _showAddTransactionDialog(false),
          ),
          _buildActionBtn(
            icon: Icons.remove, 
            label: 'Thêm chi', 
            color: Colors.redAccent,
            onTap: () => _showAddTransactionDialog(true),
          ),
          _buildActionBtn(
            icon: Icons.pie_chart, 
            label: 'Ngân sách', 
            color: Colors.orangeAccent,
            onTap: () => _showNotice('Bạn đang xem tháng hiện tại!'),
          ),
          _buildActionBtn(
            icon: Icons.receipt_long, 
            label: 'Hóa đơn', 
            color: Colors.purpleAccent,
            onTap: () => _showNotice('Chưa có hóa đơn nào đến hạn!'),
          ),
        ],
      ),
    );
  }

  Widget _buildActionBtn({required IconData icon, required String label, required Color color, required VoidCallback onTap}) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
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
      ),
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
              InkWell(
                onTap: () {
                   setState(() {
                      transactions.clear();
                   });
                   _showNotice('Đã xóa lịch sử!');
                },
                child: Text(
                  'Xóa hết',
                  style: GoogleFonts.nunito(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: Colors.redAccent,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          if (transactions.isEmpty)
             Padding(
               padding: const EdgeInsets.symmetric(vertical: 30),
               child: Center(
                 child: Text('Chưa có giao dịch nào!', style: GoogleFonts.nunito(color: Colors.grey, fontSize: 16)),
               ),
             )
          else
            ...transactions.map((tx) => _buildTransactionItem(tx)).toList(),
        ],
      ),
    );
  }

  Widget _buildTransactionItem(Transaction tx) {
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
              color: tx.iconColor.withOpacity(0.15),
              borderRadius: BorderRadius.circular(16),
            ),
            child: Icon(tx.icon, color: tx.iconColor),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  tx.title,
                  maxLines: 1, overflow: TextOverflow.ellipsis,
                  style: GoogleFonts.nunito(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: const Color(0xFF2D3142),
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  _formatDate(tx.date),
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
            '${tx.isExpense ? '-' : '+'}${_formatCurrency(tx.amount)}',
            style: GoogleFonts.nunito(
              fontSize: 16,
              fontWeight: FontWeight.w900,
              color: tx.isExpense ? Colors.redAccent : Colors.green,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBudgetWarning() {
    if (totalExpense == 0) return const SizedBox.shrink();
    int ratio = (totalExpense / 3000000 * 100).toInt();
    if (ratio < 50) return const SizedBox.shrink();
    
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 24.0),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: ratio > 90 ? const Color(0xFFFDECEA) : const Color(0xFFFFF4E5),
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: ratio > 90 ? Colors.redAccent.withOpacity(0.5) : Colors.orange.withOpacity(0.5)),
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: ratio > 90 ? Colors.redAccent : Colors.orange,
              shape: BoxShape.circle,
            ),
            child: Icon(ratio > 90 ? Icons.error_outline : Icons.warning_amber_rounded, color: Colors.white),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  ratio > 90 ? 'Vượt quá hạn mức!' : 'Cảnh báo ngân sách',
                  style: GoogleFonts.nunito(
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                    color: ratio > 90 ? Colors.red.shade900 : Colors.orange.shade800,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  'Bạn đã tiêu $ratio% định mức tháng. ${ratio > 90 ? "Dừng mua sắm ngay!" : "Hãy chú ý tiết kiệm nhé."}',
                  style: GoogleFonts.nunito(
                    fontSize: 13,
                    color: ratio > 90 ? Colors.red.shade800 : Colors.orange.shade800,
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

