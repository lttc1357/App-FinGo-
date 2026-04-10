import 'package:flutter/material.dart';
import 'theme.dart';
import 'screens/intro_screen.dart';
import 'global_theme_notifier.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<bool>(
      valueListenable: isDarkModeGlobal,
      builder: (context, isDarkMode, child) {
        return MaterialApp(
          title: 'FinGo',
          theme: AppTheme.lightTheme,
          darkTheme: AppTheme.darkTheme,
          themeMode: isDarkMode ? ThemeMode.dark : ThemeMode.light,
          home: const IntroScreen(),
          debugShowCheckedModeBanner: false,
        );
      },
    );
  }
}
