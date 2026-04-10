import os

def fix_file(path, replacements):
    with open(path, 'r', encoding='utf-8') as f:
        content = f.read()
    for old, new in replacements.items():
        content = content.replace(old, new)
    with open(path, 'w', encoding='utf-8') as f:
        f.write(content)

fix_file('D:/h\u1ecdc/Thanh toán \u0111i\u1ec7n t\u1eed/app new/AppTC/mobile/lib/screens/stats_screen.dart', {
    'color: const Color(0xFFFFF4E5),': 'color: isDark ? const Color(0x22FFA726) : const Color(0xFFFFF4E5),',
    'color: Colors.blue.shade50,': 'color: isDark ? Colors.blue.withOpacity(0.1) : Colors.blue.shade50,',
    'color: Colors.grey.shade200,': 'color: isDark ? Colors.grey.shade800 : Colors.grey.shade200,',
    'color: const Color(0xFF2D3142)': 'color: textColor',
    'color: Colors.grey.shade600': 'color: subTextColor',
    'color: Colors.grey.shade500': 'color: subTextColor',
    'border: Border.all(color: Colors.orange.shade200),': 'border: Border.all(color: isDark ? Colors.orange.withOpacity(0.4) : Colors.orange.shade200),',
})

fix_file('D:/h\u1ecdc/Thanh toán \u0111i\u1ec7n t\u1eed/app new/AppTC/mobile/lib/screens/home_screen.dart', {
    'color: ratio > 90 ? const Color(0xFFFDECEA) : const Color(0xFFFFF4E5),': 'color: isDark ? (ratio > 90 ? Colors.red.withOpacity(0.15) : Colors.orange.withOpacity(0.15)) : (ratio > 90 ? const Color(0xFFFDECEA) : const Color(0xFFFFF4E5)),',
    'border: Border.all(\n            color: ratio > 90\n                ? Colors.redAccent.withOpacity(0.5)\n                : Colors.orange.shade300,\n          )': 'border: Border.all(\n            color: ratio > 90\n                ? Colors.redAccent.withOpacity(isDark ? 0.2 : 0.5)\n                : (isDark ? Colors.orange.withOpacity(0.2) : Colors.orange.shade300),\n          )',
    'color: Colors.grey.shade100,': 'color: isDark ? Colors.black12 : Colors.grey.shade100,',
    'color: Colors.grey.withOpacity(0.05),': 'color: isDark ? Colors.black12 : Colors.grey.withOpacity(0.05),',
    'color: const Color(0xFF2D3142)': 'color: textColor',
    'color: Colors.grey.shade600': 'color: subTextColor',
    'color: Colors.grey.shade500': 'color: subTextColor',
    'color: Colors.grey[600],': 'color: subTextColor,',
})

fix_file('D:/h\u1ecdc/Thanh toán \u0111i\u1ec7n t\u1eed/app new/AppTC/mobile/lib/screens/play_screen.dart', {
    'color: const Color(0xFF2D3142)': 'color: textColor',
    'color: Colors.grey.shade600': 'color: subTextColor',
    'color: Colors.grey.shade500': 'color: subTextColor',
    'color: Colors.grey[600],': 'color: subTextColor,',
    'color: const Color(0xFFF8F9FE)': 'color: isDark ? Colors.black12 : const Color(0xFFF8F9FE)'
})

print("Minor fixes mapped")
