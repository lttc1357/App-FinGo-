import os
import re

files_to_process = [
    'home_screen.dart',
    'stats_screen.dart',
    'play_screen.dart',
    'quiz_list_screen.dart',
    'scan_screen.dart'
]

def patch_file(filepath):
    if not os.path.exists(filepath): return
    with open(filepath, 'r', encoding='utf-8') as f:
        content = f.read()

    # ensure global_theme_notifier is imported
    if "global_theme_notifier.dart" not in content:
        content = content.replace("import 'package:flutter/material.dart';", "import 'package:flutter/material.dart';\nimport '../global_theme_notifier.dart';")
        content = content.replace("import 'package:flutter/material.dart';", "import 'package:flutter/material.dart';\nimport 'package:apptc_mobile/global_theme_notifier.dart';") # Fallback

    # Inside build method, ensure we get isDarkMode
    # We will replace Widget build(BuildContext context) { with our definitions
    build_pattern = re.compile(r'Widget build\(BuildContext context\) \{')
    replacement = '''Widget build(BuildContext context) {\n    final isDarkMode = isDarkModeGlobal.value;\n    final bgColor = isDarkMode ? const Color(0xFF1E1E1E) : const Color(0xFFF8F9FE);\n    final cardColor = isDarkMode ? const Color(0xFF2C2C2C) : Colors.white;\n    final textColor = isDarkMode ? Colors.white : const Color(0xFF2D3142);\n    final subTextColor = isDarkMode ? Colors.grey.shade400 : Colors.grey.shade600;'''
    
    if "isDarkModeGlobal.value" not in content:
        content = build_pattern.sub(replacement, content)

    # Now replace hardcoded colors if possible
    # Colors.white -> cardColor (roughly)
    # const Color(0xFF2D3142) -> textColor
    # Colors.grey.shade500 -> subTextColor
    
    content = content.replace('backgroundColor: const Color(0xFFF8F9FE),', 'backgroundColor: bgColor,')
    content = content.replace('color: Colors.white', 'color: cardColor')
    content = content.replace('color: const Color(0xFF2D3142)', 'color: textColor')
    content = content.replace('color: Colors.grey.shade500', 'color: subTextColor')
    content = content.replace('color: Colors.grey.shade600', 'color: subTextColor')

    with open(filepath, 'w', encoding='utf-8') as f:
        f.write(content)
        
for fname in files_to_process:
    patch_file('d:/học/Thanh toán điện tử/app new/AppTC/mobile/lib/screens/' + fname)

print("Done")
