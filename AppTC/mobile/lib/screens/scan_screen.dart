import 'package:flutter/material.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:google_fonts/google_fonts.dart';

import '../theme.dart';
import 'home_screen.dart';

class ScanScreen extends StatefulWidget {
  const ScanScreen({super.key});

  @override
  State<ScanScreen> createState() => _ScanScreenState();
}

class _ScanScreenState extends State<ScanScreen> with SingleTickerProviderStateMixin {
  final MobileScannerController _scannerController = MobileScannerController(
    formats: const [
      BarcodeFormat.qrCode,
    ],
    detectionSpeed: DetectionSpeed.noDuplicates,
  );

  late final AnimationController _lineController;
  bool _isTorchOn = false;
  bool _isProcessing = false;
  String _merchantName = 'Coffee House';
  int _amount = 45000;

  @override
  void initState() {
    super.initState();
    _lineController = AnimationController(vsync: this, duration: const Duration(seconds: 2))..repeat(reverse: true);
  }

  @override
  void dispose() {
    _lineController.dispose();
    _scannerController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
      body: Stack(
        children: [
          Positioned.fill(
            child: MobileScanner(
              controller: _scannerController,
              onDetect: _onDetect,
            ),
          ),
          Positioned.fill(
            child: Container(color: Colors.black.withValues(alpha: 0.28)),
          ),
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  _circleButton(Icons.arrow_back, onTap: () => Navigator.pop(context)),
                  Text(
                    'Quét mã QR',
                    style: Theme.of(context).textTheme.titleLarge?.copyWith(color: Colors.white),
                  ),
                  _circleButton(Icons.help_outline),
                ],
              ),
            ),
          ),
          Center(
            child: SizedBox(
              width: 280,
              height: 280,
              child: Stack(
                children: [
                  _corner(top: 0, left: 0),
                  _corner(top: 0, right: 0, rightCorner: true),
                  _corner(bottom: 0, left: 0, bottomCorner: true),
                  _corner(bottom: 0, right: 0, rightCorner: true, bottomCorner: true),
                  AnimatedBuilder(
                    animation: _lineController,
                    builder: (context, child) {
                      return Positioned(
                        top: 20 + (240 * _lineController.value),
                        left: 0,
                        right: 0,
                        child: Container(
                          height: 2,
                          decoration: BoxDecoration(
                            gradient: const LinearGradient(
                              colors: [
                                Colors.transparent,
                                AppTheme.primaryContainer,
                                Colors.white,
                                AppTheme.primaryContainer,
                                Colors.transparent,
                              ],
                            ),
                            boxShadow: [
                              BoxShadow(color: AppTheme.primaryContainer.withValues(alpha: 0.8), blurRadius: 12),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
          ),
          Positioned(
            bottom: 320,
            left: 0,
            right: 0,
            child: Center(
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 10),
                decoration: BoxDecoration(
                  color: Colors.black45,
                  borderRadius: BorderRadius.circular(999),
                  border: Border.all(color: Colors.white24),
                ),
                child: Text(
                  'Di chuyển camera đến mã QR để thanh toán',
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(color: Colors.white),
                ),
              ),
            ),
          ),
          Positioned(
            bottom: 240,
            left: 0,
            right: 0,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _actionCircle(
                  _isTorchOn ? Icons.flashlight_off : Icons.flashlight_on,
                  _isTorchOn ? 'TẮT ĐÈN' : 'BẬT ĐÈN',
                  onTap: () async {
                    await _scannerController.toggleTorch();
                    if (!mounted) {
                      return;
                    }
                    setState(() {
                      _isTorchOn = !_isTorchOn;
                    });
                  },
                ),
                const SizedBox(width: 34),
                _actionCircle(
                  Icons.flip_camera_android,
                  'ĐỔI CAMERA',
                  onTap: () async {
                    await _scannerController.switchCamera();
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _onDetect(BarcodeCapture capture) async {
    if (_isProcessing) {
      return;
    }

    final first = capture.barcodes.isNotEmpty ? capture.barcodes.first : null;
    final rawValue = first?.rawValue;
    if (rawValue == null || rawValue.isEmpty) {
      return;
    }

    _isProcessing = true;
    final parsed = _parseQrData(rawValue);
    _merchantName = parsed.$1;
    _amount = parsed.$2;

    await _scannerController.stop();
    if (!mounted) {
      return;
    }

    await showDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: (_) => _ConfirmDialog(
        merchantName: _merchantName,
        amount: _amount,
        onCancel: () {
          Navigator.pop(context);
        },
          onConfirm: (finalMerchantName, finalAmount) {
            Navigator.pop(context);

              if (finalAmount.toDouble() > currentGlobalBalance()) {
                showDialog(
                  context: context,
                  builder: (BuildContext dialogContext) {
                    return AlertDialog(
                      title: Text('Không đủ số dư ⚠️', style: GoogleFonts.nunito(fontWeight: FontWeight.bold, color: Colors.redAccent)),
                      content: Text('Số tiền của bạn không đủ để thực hiện quy trình quét QR này!', style: GoogleFonts.nunito(fontSize: 16)),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                      actions: [
                        TextButton(
                          onPressed: () {
                             Navigator.pop(dialogContext);
                          },
                          child: Text('Đóng', style: GoogleFonts.nunito(color: Theme.of(context).colorScheme.onSurface, fontWeight: FontWeight.bold)),
                        ),
                      ],
                    );
                  },
                );
                return;
              }

              // Ghi nhận giao dịch vào HomeScreen
              final newTx = Transaction(
                id: DateTime.now().toString(),
                title: 'Thanh toán cho $finalMerchantName',
                amount: finalAmount.toDouble(),
                isExpense: true,
                date: DateTime.now(),
                icon: Icons.shopping_cart,
                iconColor: Colors.blueAccent,
              );
              globalTransactions.value = [newTx, ...globalTransactions.value];

              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text('Đã gửi ${_formatMoney(finalAmount)}đ cho $finalMerchantName')),
              );

              // Cảnh báo dưới 100k
              if (currentGlobalBalance() < 100000) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text('Cảnh báo: Tiền của bạn hiện còn dưới 100,000 đ!', style: GoogleFonts.nunito(fontWeight: FontWeight.bold)),
                    backgroundColor: Colors.orangeAccent,
                    duration: const Duration(seconds: 4),
                  ),
                );
              }
          },
        ),
      );

    if (!mounted) {
      return;
    }
    await _scannerController.start();
    _isProcessing = false;
  }

  (String, int) _parseQrData(String raw) {
    final merchantRegex = RegExp(r'merchant\s*[:=]\s*([^;\n]+)', caseSensitive: false);
    final amountRegex = RegExp(r'amount\s*[:=]\s*(\d+)', caseSensitive: false);
    final moneyRegex = RegExp(r'(\d{4,})');

    final merchantMatch = merchantRegex.firstMatch(raw);
    final amountMatch = amountRegex.firstMatch(raw);
    final fallbackMoney = moneyRegex.firstMatch(raw);

    final merchant = merchantMatch?.group(1)?.trim().isNotEmpty == true
        ? merchantMatch!.group(1)!.trim()
        : 'Coffee House';
    final amount = int.tryParse(amountMatch?.group(1) ?? '') ?? int.tryParse(fallbackMoney?.group(1) ?? '') ?? 45000;

    return (merchant, amount);
  }

  String _formatMoney(int value) {
    final text = value.toString();
    final chars = text.split('');
    final buffer = StringBuffer();
    for (var index = 0; index < chars.length; index++) {
      final reverseIndex = chars.length - index;
      buffer.write(chars[index]);
      if (reverseIndex > 1 && reverseIndex % 3 == 1) {
        buffer.write('.');
      }
    }
    return buffer.toString();
  }

  Widget _circleButton(IconData icon, {VoidCallback? onTap}) {
    return InkWell(
      onTap: onTap,
      child: Container(
        width: 44,
        height: 44,
        decoration: BoxDecoration(color: Theme.of(context).cardColor.withValues(alpha: 0.2), shape: BoxShape.circle),
        child: Icon(icon, color: Colors.white),
      ),
    );
  }

  Widget _actionCircle(IconData icon, String label, {VoidCallback? onTap}) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        children: [
          Container(
            width: 64,
            height: 64,
            decoration: BoxDecoration(
              color: Colors.white.withValues(alpha: 0.18),
              shape: BoxShape.circle,
              border: Border.all(color: Colors.white24),
            ),
            child: Icon(icon, color: Colors.white, size: 30),
          ),
          const SizedBox(height: 8),
          Text(
            label,
            style: const TextStyle(color: Colors.white70, fontWeight: FontWeight.w700, fontSize: 10, letterSpacing: 1.1),
          ),
        ],
      ),
    );
  }

  Widget _corner({double? top, double? left, double? right, double? bottom, bool rightCorner = false, bool bottomCorner = false}) {
    return Positioned(
      top: top,
      left: left,
      right: right,
      bottom: bottom,
      child: Container(
        width: 36,
        height: 36,
        decoration: BoxDecoration(
          border: Border(
            top: BorderSide(color: AppTheme.primaryContainer, width: !bottomCorner ? 4 : 0),
            left: BorderSide(color: AppTheme.primaryContainer, width: !rightCorner ? 4 : 0),
            right: BorderSide(color: AppTheme.primaryContainer, width: rightCorner ? 4 : 0),
            bottom: BorderSide(color: AppTheme.primaryContainer, width: bottomCorner ? 4 : 0),
          ),
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(!rightCorner && !bottomCorner ? 14 : 0),
            topRight: Radius.circular(rightCorner && !bottomCorner ? 14 : 0),
            bottomLeft: Radius.circular(!rightCorner && bottomCorner ? 14 : 0),
            bottomRight: Radius.circular(rightCorner && bottomCorner ? 14 : 0),
          ),
        ),
      ),
    );
  }
}

class _ConfirmDialog extends StatefulWidget {
  final String merchantName;
  final int amount;
  final VoidCallback onCancel;
  final void Function(String, int) onConfirm;

  const _ConfirmDialog({
    required this.merchantName,
    required this.amount,
    required this.onCancel,
    required this.onConfirm,
  });

  @override
  State<_ConfirmDialog> createState() => _ConfirmDialogState();
}

class _ConfirmDialogState extends State<_ConfirmDialog> {
  late final TextEditingController _merchantCtl;
  late final TextEditingController _amountCtl;

  @override
  void initState() {
    super.initState();
    _merchantCtl = TextEditingController();
    _amountCtl = TextEditingController();
  }

  @override
  void dispose() {
    _merchantCtl.dispose();
    _amountCtl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    
    return Dialog(
      insetPadding: const EdgeInsets.symmetric(horizontal: 24),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(34)),
      child: Container(
        decoration: BoxDecoration(
          color: AppTheme.surfaceContainerLowest,
          borderRadius: BorderRadius.circular(34),
        ),
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                width: double.infinity,
                padding: const EdgeInsets.fromLTRB(24, 28, 24, 20),
                decoration: BoxDecoration(
                  color: AppTheme.primary.withValues(alpha: 0.05),
                  borderRadius: const BorderRadius.vertical(top: Radius.circular(34)),
                ),
                child: Column(
                  children: [
                    Container(
                      width: 96,
                      height: 96,
                      decoration: BoxDecoration(shape: BoxShape.circle, color: AppTheme.surfaceVariant.withValues(alpha: 0.4)),
                      child: const Icon(Icons.pets, size: 48, color: AppTheme.primary),
                    ),
                    const SizedBox(height: 18),
                    Text(
                      'Thanh toán ngay?',
                      style: Theme.of(context).textTheme.displayMedium?.copyWith(fontSize: 23, color: AppTheme.onSurface),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'Xác nhận giao dịch cho:',
                      style: Theme.of(context).textTheme.bodyLarge?.copyWith(color: AppTheme.onSurfaceVariant),
                    ),
                    const SizedBox(height: 8),
                    TextField(
                      controller: _merchantCtl,
                      textAlign: TextAlign.center,
                      keyboardType: TextInputType.text,
                      style: Theme.of(context).textTheme.titleLarge?.copyWith(color: AppTheme.onSurface, fontWeight: FontWeight.bold),
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: Theme.of(context).cardColor,
                        border: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: BorderSide.none),
                        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                        hintText: 'Nhập tên người nhận...',
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(22),
                child: Column(
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
                      decoration: BoxDecoration(color: AppTheme.surface, borderRadius: BorderRadius.circular(22)),
                      child: Row(
                        children: [
                          Container(
                            width: 46,
                            height: 46,
                            decoration: BoxDecoration(color: AppTheme.primary.withValues(alpha: 0.1), shape: BoxShape.circle),
                            child: const Icon(Icons.payments, color: AppTheme.primary),
                          ),
                          const SizedBox(width: 12),
                          Text(
                            'TỔNG TIỀN',
                            style: Theme.of(context).textTheme.titleLarge?.copyWith(color: AppTheme.onSurfaceVariant),
                          ),
                          const SizedBox(width: 8),
                          Expanded(
                            child: TextField(
                              controller: _amountCtl,
                              keyboardType: TextInputType.number,
                              textAlign: TextAlign.right,
                              style: Theme.of(context).textTheme.displayMedium?.copyWith(color: AppTheme.primary, fontSize: 24),
                              decoration: InputDecoration(
                                isDense: true,
                                border: InputBorder.none,
                                hintText: '0',
                                suffixText: 'đ',
                                suffixStyle: Theme.of(context).textTheme.displayMedium?.copyWith(color: AppTheme.primary, fontSize: 24),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 16),
                    SizedBox(
                      width: double.infinity,
                      height: 56,
                      child: ElevatedButton.icon(
                        onPressed: () {
                          final m = _merchantCtl.text.trim();
                          final a = int.tryParse(_amountCtl.text.replaceAll(RegExp(r'[^0-9]'), '')) ?? 0;
                          widget.onConfirm(m.isEmpty ? 'Không xác định' : m, a);
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppTheme.primary,
                          foregroundColor: Colors.white,
                          shape: const StadiumBorder(),
                        ),
                        icon: const Icon(Icons.check_circle),
                        label: const Text('Xác nhận & Gửi'),
                      ),
                    ),
                    const SizedBox(height: 8),
                    TextButton(
                      onPressed: widget.onCancel,
                      child: Text(
                        'Hủy giao dịch',
                        style: Theme.of(context).textTheme.titleLarge?.copyWith(color: AppTheme.onSurfaceVariant, fontSize: 18),
                      ),
                    ),
                    const SizedBox(height: 12),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 14),
                      decoration: BoxDecoration(
                        color: const Color(0xFFFFF6EE),
                        borderRadius: BorderRadius.circular(24),
                        border: Border.all(color: const Color(0xFFF9C89A)),
                      ),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Icon(Icons.stars, color: Color(0xFF8A4C00)),
                          const SizedBox(width: 10),
                          Expanded(
                            child: Text(
                              'Bạn sẽ nhận được +12 FinPoints và 1 vật phẩm cho Pet sau giao dịch này!',
                              style: Theme.of(context).textTheme.bodyLarge?.copyWith(color: const Color(0xFF6D3B00), height: 1.3),
                            ),
                          ),
                        ],
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

