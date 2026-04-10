import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../main_screen.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  bool _obscurePassword = true;
  bool _obscureConfirmPassword = true;
  bool _agreedToTerms = false;

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  void _handleRegister() {
    if (!_agreedToTerms) return;
    
    // Navigate to MainScreen
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (context) => const MainScreen()),
      (route) => false,
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    final bgColor = isDark ? const Color(0xFF1E1E1E) : const Color(0xFFF8F9FE);
    final textColor = isDark ? Colors.white : const Color(0xFF2D3142);
    final subTextColor = isDark ? Colors.grey.shade400 : Colors.grey.shade600;
    final inputBgColor = isDark ? const Color(0xFF2C2C2C) : Colors.white;
    final primaryColor = const Color(0xFF5A78FF);

    return Scaffold(
      backgroundColor: bgColor,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: textColor),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // Logo placeholder
              Center(
                child: Container(
                  width: 80,
                  height: 80,
                  decoration: BoxDecoration(
                    gradient: const LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: [Color(0xFFFFCC80), Color(0xFFFFAB40)],
                    ),
                    borderRadius: BorderRadius.circular(24),
                    boxShadow: [
                      BoxShadow(
                        color: const Color(0xFFFFB74D).withOpacity(0.3),
                        blurRadius: 15,
                        offset: const Offset(0, 8),
                      ),
                    ],
                  ),
                  child: const Center(
                    child: Text('🎉', style: TextStyle(fontSize: 40)),
                  ),
                ),
              ),
              const SizedBox(height: 32),
              
              Text(
                'Tạo tài khoản',
                textAlign: TextAlign.center,
                style: GoogleFonts.nunito(
                  fontSize: 28,
                  fontWeight: FontWeight.w900,
                  color: textColor,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                'Gia nhập FinGo ngay hôm nay',
                textAlign: TextAlign.center,
                style: GoogleFonts.nunito(
                  fontSize: 15,
                  color: subTextColor,
                ),
              ),
              const SizedBox(height: 48),

              // Name Input
              Row(
                children: [
                  const Icon(Icons.person, color: Colors.blue, size: 20),
                  const SizedBox(width: 8),
                  Text(
                    'Họ tên',
                    style: GoogleFonts.nunito(
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                      color: textColor,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 12),
              Container(
                decoration: BoxDecoration(
                  color: inputBgColor,
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(color: Colors.grey.withOpacity(0.2)),
                ),
                child: TextField(
                  controller: _nameController,
                  decoration: InputDecoration(
                    hintText: 'Nhập họ tên của bạn',
                    hintStyle: GoogleFonts.nunito(color: Colors.grey),
                    prefixIcon: const Icon(Icons.person_outline, color: Colors.blueAccent),
                    border: InputBorder.none,
                    contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                  ),
                ),
              ),
              const SizedBox(height: 24),

              // Email Input
              Row(
                children: [
                  const Icon(Icons.email_outlined, color: Colors.blue, size: 20),
                  const SizedBox(width: 8),
                  Text(
                    'Email',
                    style: GoogleFonts.nunito(
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                      color: textColor,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 12),
              Container(
                decoration: BoxDecoration(
                  color: inputBgColor,
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(color: Colors.grey.withOpacity(0.2)),
                ),
                child: TextField(
                  controller: _emailController,
                  decoration: InputDecoration(
                    hintText: 'Nhập email của bạn',
                    hintStyle: GoogleFonts.nunito(color: Colors.grey),
                    prefixIcon: const Icon(Icons.mail_outline, color: Colors.blueAccent),
                    border: InputBorder.none,
                    contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                  ),
                ),
              ),
              const SizedBox(height: 24),

              // Password Input
              Row(
                children: [
                  const Icon(Icons.lock_outline, color: Colors.orange, size: 20),
                  const SizedBox(width: 8),
                  Text(
                    'Mật khẩu',
                    style: GoogleFonts.nunito(
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                      color: textColor,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 12),
              Container(
                decoration: BoxDecoration(
                  color: inputBgColor,
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(color: Colors.grey.withOpacity(0.2)),
                ),
                child: TextField(
                  controller: _passwordController,
                  obscureText: _obscurePassword,
                  decoration: InputDecoration(
                    hintText: 'Nhập mật khẩu',
                    hintStyle: GoogleFonts.nunito(color: Colors.grey),
                    prefixIcon: const Icon(Icons.lock_outline, color: Colors.blueAccent),
                    suffixIcon: IconButton(
                      icon: Icon(
                        _obscurePassword ? Icons.visibility_off : Icons.visibility,
                        color: Colors.blueAccent,
                      ),
                      onPressed: () {
                        setState(() {
                          _obscurePassword = !_obscurePassword;
                        });
                      },
                    ),
                    border: InputBorder.none,
                    contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                  ),
                ),
              ),
              const SizedBox(height: 24),

              // Confirm Password Input
              Row(
                children: [
                  const Icon(Icons.lock_outline, color: Colors.orange, size: 20),
                  const SizedBox(width: 8),
                  Text(
                    'Xác nhận mật khẩu',
                    style: GoogleFonts.nunito(
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                      color: textColor,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 12),
              Container(
                decoration: BoxDecoration(
                  color: inputBgColor,
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(color: Colors.grey.withOpacity(0.2)),
                ),
                child: TextField(
                  controller: _confirmPasswordController,
                  obscureText: _obscureConfirmPassword,
                  decoration: InputDecoration(
                    hintText: 'Xác nhận mật khẩu',
                    hintStyle: GoogleFonts.nunito(color: Colors.grey),
                    prefixIcon: const Icon(Icons.lock_outline, color: Colors.blueAccent),
                    suffixIcon: IconButton(
                      icon: Icon(
                        _obscureConfirmPassword ? Icons.visibility_off : Icons.visibility,
                        color: Colors.blueAccent,
                      ),
                      onPressed: () {
                        setState(() {
                          _obscureConfirmPassword = !_obscureConfirmPassword;
                        });
                      },
                    ),
                    border: InputBorder.none,
                    contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                  ),
                ),
              ),
              const SizedBox(height: 24),

              // Terms agreement
              Row(
                children: [
                  Checkbox(
                    value: _agreedToTerms,
                    onChanged: (val) {
                      setState(() {
                        _agreedToTerms = val ?? false;
                      });
                    },
                    activeColor: primaryColor,
                  ),
                  Expanded(
                    child: Text(
                      'Tôi đồng ý với Điều khoản & Điều kiện',
                      style: GoogleFonts.nunito(
                        fontSize: 14,
                        color: textColor,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 24),

              // Register Button
              SizedBox(
                width: double.infinity,
                height: 56,
                child: ElevatedButton(
                  onPressed: _handleRegister,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: primaryColor,
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                    elevation: 5,
                    shadowColor: primaryColor.withOpacity(0.5),
                    disabledBackgroundColor: Colors.grey.shade300,
                  ),
                  child: Text(
                    'Tạo tài khoản',
                    style: GoogleFonts.nunito(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 24),

              Center(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Đã có tài khoản? ',
                      style: GoogleFonts.nunito(color: subTextColor),
                    ),
                    GestureDetector(
                      onTap: () {
                        // Go back to login screen
                        Navigator.pop(context);
                      },
                      child: Text(
                        'Đăng nhập',
                        style: GoogleFonts.nunito(
                          color: primaryColor,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
