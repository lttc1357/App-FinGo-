code = """import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class StatsScreen extends StatefulWidget {
  const StatsScreen({super.key});

  @override
  State<StatsScreen> createState() => _StatsScreenState();
}

class _StatsScreenState extends State<StatsScreen> {
  String _selectedPeriod = 'Tháng';
  double _budgetLimit = 10000000;

  final Map<String, Map<String, dynamic>> _statsData = {
    'Tuần': {
      'total': 1850000.0,
      'vsLabel': '+5%',
      'vsColor': Colors.redAccent,
      'bars': [0.2, 0.5, 0.3, 0.8, 0.4, 0.9, 0.3],
      'labels': ['T2', 'T3', 'T4', 'T5', 'T6', 'T7', 'CN'],
      'categories': {
        'Ăn uống': 800000.0,
        'Giải trí': 500000.0,
        'Học tập': 550000.0,
      }
    },
    'Tháng': {
      'total': 7450000.0,
      'vsLabel': '-12%',
      'vsColor': Colors.green,
      'bars': [0.6, 0.4, 0.85, 0.3, 1.0],
      'labels': ['Tuần 1', 'Tuần 2', 'Tuần 3', 'Tuần 4', 'Tuần 5'],
      'categories': {
        'Ăn uống': 3352500.0,
        'Giải trí': 2235000.0,
        'Học tập': 1862500.0,
      }
    },
    'Năm': {
      'total': 84500000.0,
      'vsLabel': '-8%',
      'vsColor': Colors.green,
      'bars': [0.4, 0.5, 0.6, 0.7, 0.5, 0.8, 0.9, 0.8, 0.6, 0.7, 0.6, 0.8],
      'labels': ['T1', 'T2', 'T3', 'T4', 'T5', 'T6', 'T7', 'T8', 'T9', 'T10', 'T11', 'T12'],
      'categories': {
        'Ăn uống': 38025000.0,
        'Giải trí': 25350000.0,
        'Học tập': 21125000.0,
      }
    }
  };

  void _showLimitDialog() {
    String newLimitStr = '';
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        title: Text('Đặt ngân sách tháng', style: GoogleFonts.nunito(fontWeight: FontWeight.bold)),
        content: TextField(
          keyboardType: TextInputType.number,
          decoration: InputDecoration(
            labelText: 'Số tiền (VND)',
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
            prefixIcon: const Icon(Icons.account_balance_wallet_outlined),
          ),
          onChanged: (val) => newLimitStr = val,
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: Text('HỦY', style: GoogleFonts.nunito(color: Colors.grey, fontWeight: FontWeight.bold)),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
               backgroundColor: const Color(0xFF3A7BD5),
               shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            ),
            onPressed: () {
              final val = double.tryParse(newLimitStr);
              if (val != null && val > 0) {
                setState(() => _budgetLimit = val);
                Navigator.pop(ctx);
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('Đã cập nhật ngân sách thành công!', style: GoogleFonts.nunito()))
                );
              }
            },
            child: Text('LƯU', style: GoogleFonts.nunito(color: Colors.white, fontWeight: FontWeight.bold)),
          ),
        ],
      ),
    );
  }

  String _formatCurrency(double val) {
    return val.toStringAsFixed(0).replaceAllMapped(RegExp(r'(\\d{1,3})(?=(\\d{3})+(?!\\d))'), (Match m) => '${m[1]}.');
  }

  @override
  Widget build(BuildContext context) {
    final currentData = _statsData[_selectedPeriod]!;
    final totalSpent = currentData['total'] as double;
    final bars = currentData['bars'] as List<double>;
    final labels = currentData['labels'] as List<String>;
    final categories = currentData['categories'] as Map<String, double>;
    final vsLabel = currentData['vsLabel'] as String;
    final vsColor = currentData['vsColor'] as Color;

    return Scaffold(
      backgroundColor: const Color(0xFFF8F9FE),
      body: SafeArea(
        bottom: false,
        child: SingleChildScrollView(
          padding: const EdgeInsets.only(bottom: 120, left: 24, right: 24, top: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Thống Kê Chi Tiêu',
                style: GoogleFonts.nunito(
                  fontSize: 28,
                  fontWeight: FontWeight.w900,
                  color: const Color(0xFF2D3142),
                ),
              ),
              const SizedBox(height: 20),
              _buildTimeFilters(),
              const SizedBox(height: 24),
              _buildChartCard(totalSpent, bars, labels, vsLabel, vsColor),
              const SizedBox(height: 20),
              _buildBudgetCard(totalSpent),
              const SizedBox(height: 20),
              _buildCategoryCard(categories, totalSpent),
              const SizedBox(height: 20),
              _buildSurvivalCard(totalSpent),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTimeFilters() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: ['Tuần', 'Tháng', 'Năm'].map((period) {
        final isSelected = _selectedPeriod == period;
        return GestureDetector(
          onTap: () => setState(() => _selectedPeriod = period),
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 200),
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 10),
            decoration: BoxDecoration(
              color: isSelected ? const Color(0xFF3A7BD5) : Colors.white,
              borderRadius: BorderRadius.circular(20),
              boxShadow: isSelected ? [
                BoxShadow(color: const Color(0xFF3A7BD5).withOpacity(0.4), blurRadius: 10, offset: const Offset(0, 4))
              ] : [
                BoxShadow(color: Colors.grey.shade200, blurRadius: 5)
              ],
            ),
            child: Text(
              period,
              style: GoogleFonts.nunito(
                fontSize: 15,
                fontWeight: FontWeight.bold,
                color: isSelected ? Colors.white : Colors.grey.shade600,
              ),
            ),
          ),
        );
      }).toList(),
    );
  }

  Widget _buildChartCard(double totalSpent, List<double> bars, List<String> labels, String vsLabel, Color vsColor) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(30),
        boxShadow: [
          BoxShadow(color: Colors.grey.shade100, blurRadius: 15, offset: const Offset(0, 8))
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'TỔNG CHI PHÍ',
                      style: GoogleFonts.nunito(fontSize: 13, fontWeight: FontWeight.w700, color: Colors.grey.shade500, letterSpacing: 1),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      '${_formatCurrency(totalSpent)} đ',
                      style: GoogleFonts.nunito(fontSize: 28, fontWeight: FontWeight.w900, color: const Color(0xFF2D3142)),
                    ),
                  ],
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                decoration: BoxDecoration(
                  color: vsColor.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Row(
                  children: [
                    Icon(vsColor == Colors.green ? Icons.trending_down : Icons.trending_up, color: vsColor, size: 16),
                    const SizedBox(width: 4),
                    Text(
                      vsLabel,
                      style: GoogleFonts.nunito(color: vsColor, fontWeight: FontWeight.bold, fontSize: 13),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 30),
          SizedBox(
            height: 180,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: List.generate(bars.length, (index) {
                final heightRatio = bars[index];
                return Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      AnimatedContainer(
                        duration: const Duration(milliseconds: 500),
                        height: 130 * heightRatio + 10,
                        margin: const EdgeInsets.symmetric(horizontal: 4),
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            colors: index == bars.indexOf(bars.reduce((curr, next) => curr > next ? curr : next)) // tallest
                                ? [const Color(0xFFFF9A9E), const Color(0xFFFECFEF)]
                                : [const Color(0xFF82B1FF), const Color(0xFFE2F0FF)],
                            begin: Alignment.bottomCenter,
                            end: Alignment.topCenter,
                          ),
                          borderRadius: BorderRadius.circular(6),
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        labels[index],
                        style: GoogleFonts.nunito(
                          fontSize: 11,
                          fontWeight: FontWeight.bold,
                          color: Colors.grey.shade500,
                        ),
                      ),
                    ],
                  ),
                );
              }),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBudgetCard(double totalSpent) {
    if (_selectedPeriod != 'Tháng') return const SizedBox.shrink(); // Chỉ hiện budget cho tháng
    
    double progress = totalSpent / _budgetLimit;
    if (progress > 1.0) progress = 1.0;
    
    final isDanger = progress > 0.85;

    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(30),
        boxShadow: [
          BoxShadow(color: Colors.grey.shade100, blurRadius: 15, offset: const Offset(0, 8))
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Ngân sách tháng',
                style: GoogleFonts.nunito(fontSize: 18, fontWeight: FontWeight.bold, color: const Color(0xFF2D3142)),
              ),
              InkWell(
                onTap: _showLimitDialog,
                child: Container(
                  padding: const EdgeInsets.all(6),
                  decoration: BoxDecoration(color: Colors.blue.shade50, shape: BoxShape.circle),
                  child: const Icon(Icons.edit, color: Colors.blueAccent, size: 18),
                ),
              )
            ],
          ),
          const SizedBox(height: 6),
          Text(
            'Giới hạn: ${_formatCurrency(_budgetLimit)} đ',
            style: GoogleFonts.nunito(fontSize: 13, color: Colors.grey.shade500, fontWeight: FontWeight.w600),
          ),
          const SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Đã dùng ${(progress * 100).toInt()}%',
                style: GoogleFonts.nunito(fontSize: 15, fontWeight: FontWeight.w800, color: isDanger ? Colors.redAccent : const Color(0xFF2D3142)),
              ),
              Text(
                'Còn ${_formatCurrency((_budgetLimit - totalSpent) > 0 ? (_budgetLimit - totalSpent) : 0)} đ',
                style: GoogleFonts.nunito(fontSize: 15, fontWeight: FontWeight.w800, color: const Color(0xFF3A7BD5)),
              ),
            ],
          ),
          const SizedBox(height: 12),
          ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: LinearProgressIndicator(
              value: progress,
              minHeight: 12,
              backgroundColor: Colors.grey.shade200,
              valueColor: AlwaysStoppedAnimation<Color>(isDanger ? Colors.redAccent : const Color(0xFF3A7BD5)),
            ),
          )
        ],
      ),
    );
  }

  Widget _buildCategoryCard(Map<String, double> categories, double total) {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(30),
        boxShadow: [BoxShadow(color: Colors.grey.shade100, blurRadius: 15, offset: const Offset(0, 8))],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('Phân bổ chi tiêu', style: GoogleFonts.nunito(fontSize: 18, fontWeight: FontWeight.bold, color: const Color(0xFF2D3142))),
              const Icon(Icons.pie_chart, color: Colors.orangeAccent),
            ],
          ),
          const SizedBox(height: 20),
          _buildCategoryRow('Ăn uống', categories['Ăn uống']!, total, Colors.orangeAccent, Icons.fastfood),
          const Divider(height: 24, color: Colors.black12),
          _buildCategoryRow('Giải trí', categories['Giải trí']!, total, Colors.purpleAccent, Icons.sports_esports),
          const Divider(height: 24, color: Colors.black12),
          _buildCategoryRow('Học tập', categories['Học tập']!, total, Colors.blueAccent, Icons.school),
        ],
      ),
    );
  }

  Widget _buildCategoryRow(String title, double amount, double total, Color color, IconData icon) {
    final double percent = total > 0 ? (amount / total * 100) : 0;
    return Row(
      children: [
        Container(
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(color: color.withOpacity(0.15), borderRadius: BorderRadius.circular(12)),
          child: Icon(icon, color: color, size: 22),
        ),
        const SizedBox(width: 16),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(title, style: GoogleFonts.nunito(fontSize: 15, fontWeight: FontWeight.w700, color: const Color(0xFF2D3142))),
              const SizedBox(height: 4),
              Stack(
                children: [
                  Container(height: 6, decoration: BoxDecoration(color: Colors.grey.shade200, borderRadius: BorderRadius.circular(4))),
                  FractionallySizedBox(
                    widthFactor: total > 0 ? (amount / total) : 0,
                    child: Container(height: 6, decoration: BoxDecoration(color: color, borderRadius: BorderRadius.circular(4))),
                  )
                ],
              )
            ],
          ),
        ),
        const SizedBox(width: 16),
        Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Text('${_formatCurrency(amount)} đ', style: GoogleFonts.nunito(fontSize: 14, fontWeight: FontWeight.w800, color: const Color(0xFF2D3142))),
            Text('${percent.toStringAsFixed(1)}%', style: GoogleFonts.nunito(fontSize: 12, fontWeight: FontWeight.bold, color: Colors.grey.shade500)),
          ],
        )
      ],
    );
  }

  Widget _buildSurvivalCard(double totalSpent) {
    if (_selectedPeriod != 'Tháng') return const SizedBox.shrink();
    if (totalSpent < _budgetLimit * 0.8) return const SizedBox.shrink();

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: const Color(0xFFFFF4E5),
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: Colors.orange.shade200),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.all(12),
            decoration: const BoxDecoration(color: Colors.orange, shape: BoxShape.circle),
            child: const Icon(Icons.warning_amber_rounded, color: Colors.white, size: 30),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Cảnh báo sinh tồn',
                  style: GoogleFonts.nunito(fontSize: 18, fontWeight: FontWeight.w900, color: Colors.orange.shade900),
                ),
                const SizedBox(height: 6),
                Text(
                  'Sắp "cháy túi" rồi! Hãy cắt giảm ngay các khoản chi tiêu giải trí và ăn vặt nếu bạn không muốn ăn mì tôm nguyên tuần cuối tháng nhé.',
                  style: GoogleFonts.nunito(fontSize: 14, fontWeight: FontWeight.w600, color: Colors.orange.shade800, height: 1.4),
                ),
                const SizedBox(height: 12),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.orange.shade700,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                  ),
                  onPressed: _showLimitDialog,
                  child: Text('ĐIỀU CHỈNH NGÂN SÁCH', style: GoogleFonts.nunito(fontSize: 12, fontWeight: FontWeight.w800, color: Colors.white)),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
"""

with open('lib/screens/stats_screen.dart', 'w') as f:
    f.write(code)

