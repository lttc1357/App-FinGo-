import os

files_to_process = [
    'home_screen.dart',
    'stats_screen.dart',
    'play_screen.dart',
    'quiz_list_screen.dart',
    'scan_screen.dart'
]

def cleanup_file(filepath):
    if not os.path.exists(filepath): return
    with open(filepath, 'r', encoding='utf-8') as f:
        content = f.read()

    # Remove duplicate import
    # Usually it looks like:
    # import '../global_theme_notifier.dart';
    # import '../global_theme_notifier.dart';
    if content.count("import '../global_theme_notifier.dart';") > 1:
        content = content.replace("import '../global_theme_notifier.dart';\n", "", 1)

    # Remove the unused variable definitions
    unused_str = '''    final isDarkMode = isDarkModeGlobal.value;
    final bgColor = isDarkMode ? const Color(0xFF1E1E1E) : Theme.of(context).scaffoldBackgroundColor;
    final cardColor = isDarkMode ? const Color(0xFF2C2C2C) : Colors.white;
    final textColor = isDarkMode ? Colors.white : const Color(0xFF2D3142);
    final subTextColor = isDarkMode ? Colors.grey.shade400 : Colors.grey.shade600;'''
    
    content = content.replace(unused_str, "")

    with open(filepath, 'w', encoding='utf-8') as f:
        f.write(content)
        
for fname in files_to_process:
    cleanup_file('d:/học/Thanh toán điện tử/app new/AppTC/mobile/lib/screens/' + fname)

print("Cleaned")
