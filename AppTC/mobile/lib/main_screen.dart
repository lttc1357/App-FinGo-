import 'package:flutter/material.dart';
import 'theme.dart';
import 'screens/home_screen.dart';
import 'screens/stats_screen.dart';
import 'screens/scan_screen.dart';
import 'screens/play_screen.dart';
import 'screens/academy_screen.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _currentIndex = 0;

  late final List<Widget> _screens = [
    HomeScreen(
      onAcademyTap: () => _onTabTapped(3),
      onStatsTap: () => _onTabTapped(1),
    ),
    const StatsScreen(),
    const PlayScreen(),
    const AcademyScreen(),
  ];

  void _onTabTapped(int index) {
    if (index == 2) {
      // Maps is index 2 in bottom nav logical ordering if we skip FAB
      setState(() => _currentIndex = 2);
    } else if (index == 3) {
      setState(() => _currentIndex = 3);
    } else if (index == 0 || index == 1) {
      setState(() => _currentIndex = index);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      body: Stack(
        children: [
          IndexedStack(index: _currentIndex, children: _screens),
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: _buildBottomNavigationBar(),
          ),
        ],
      ),
    );
  }

  Widget _buildBottomNavigationBar() {
    return Container(
      padding: const EdgeInsets.only(bottom: 24, top: 8, left: 16, right: 16),
      decoration: BoxDecoration(
        color: AppTheme.surface.withValues(alpha: 0.9),
        borderRadius: const BorderRadius.vertical(top: Radius.circular(48)),
        boxShadow: [
          BoxShadow(
            color: AppTheme.primary.withValues(alpha: 0.06),
            blurRadius: 24,
            offset: const Offset(0, -4),
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          _buildNavItem(0, Icons.home_rounded, 'TRANG CHỦ'),
          _buildNavItem(1, Icons.pie_chart_outline, 'THỐNG KÊ'),
          _buildFabItem(),
          _buildNavItem(2, Icons.sports_esports, 'TRÒ CHƠI'),
          _buildNavItem(3, Icons.person_outline, 'CÁ NHÂN'),
        ],
      ),
    );
  }

  Widget _buildNavItem(int index, IconData icon, String label) {
    final isSelected = _currentIndex == index;
    return GestureDetector(
      onTap: () => _onTabTapped(index),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
        decoration: BoxDecoration(
          color: isSelected
              ? AppTheme.primaryContainer.withValues(alpha: 0.5)
              : Colors.transparent,
          borderRadius: BorderRadius.circular(16),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              icon,
              color: isSelected ? AppTheme.primary : AppTheme.onSurfaceVariant,
            ),
            const SizedBox(height: 4),
            Text(
              label,
              style: Theme.of(context).textTheme.labelLarge?.copyWith(
                fontSize: 10,
                letterSpacing: 0.5,
                color: isSelected
                    ? AppTheme.primary
                    : AppTheme.onSurfaceVariant,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFabItem() {
    return GestureDetector(
      onTap: () {
        Navigator.of(
          context,
        ).push(MaterialPageRoute(builder: (_) => const ScanScreen()));
      },
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            height: 64,
            width: 64,
            transform: Matrix4.translationValues(0.0, -16.0, 0.0),
            decoration: BoxDecoration(
              gradient:
                  const LinearPaddingGradient(), // Placeholder for simple gradient
              color: AppTheme.primary,
              shape: BoxShape.circle,
              border: Border.all(color: AppTheme.surface, width: 4),
              boxShadow: [
                BoxShadow(
                  color: AppTheme.primary.withValues(alpha: 0.3),
                  blurRadius: 32,
                  offset: const Offset(0, 8),
                ),
              ],
            ),
            child: const Icon(Icons.add, color: Colors.white, size: 32),
          ),
          Container(
            transform: Matrix4.translationValues(0.0, -14.0, 0.0),
            child: Text(
              'THÊM CHI',
              style: Theme.of(context).textTheme.labelLarge?.copyWith(
                fontSize: 10,
                letterSpacing: 0.5,
                color: AppTheme.primary,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class LinearPaddingGradient extends LinearGradient {
  const LinearPaddingGradient()
    : super(
        colors: const [Color(0xFF809BFF), Color(0xFF004be2)],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      );
}
