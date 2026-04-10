import os

files_to_process = [
    'home_screen.dart',
    'stats_screen.dart',
    'play_screen.dart',
    'quiz_list_screen.dart',
    'scan_screen.dart'
]

def revert_file(filepath):
    if not os.path.exists(filepath): return
    with open(filepath, 'r', encoding='utf-8') as f:
        content = f.read()

    content = content.replace("import 'package:apptc_mobile/global_theme_notifier.dart';", "import '../global_theme_notifier.dart';")
    content = content.replace("cardColor70", "Colors.white70")
    content = content.replace("cardColor30", "Colors.white30")
    content = content.replace("cardColor24", "Colors.white24")
    content = content.replace("color: cardColor", "color: Colors.white")
    content = content.replace("color: textColor", "color: Theme.of(context).colorScheme.onSurface")
    content = content.replace("color: subTextColor", "color: Theme.of(context).colorScheme.onSurfaceVariant")
    content = content.replace("backgroundColor: bgColor,", "")
    content = content.replace("const Color(0xFF1E1E1E) : const Color(0xFFF8F9FE);", "const Color(0xFF1E1E1E) : Theme.of(context).scaffoldBackgroundColor;")

    with open(filepath, 'w', encoding='utf-8') as f:
        f.write(content)
        
for fname in files_to_process:
    revert_file('d:/học/Thanh toán điện tử/app new/AppTC/mobile/lib/screens/' + fname)

print("Reverted")
