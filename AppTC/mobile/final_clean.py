import os

files_to_process = [
    'home_screen.dart',
    'stats_screen.dart',
    'play_screen.dart',
    'quiz_list_screen.dart',
    'scan_screen.dart'
]

def final_cleanup(filepath):
    if not os.path.exists(filepath): return
    with open(filepath, 'r', encoding='utf-8') as f:
        content = f.read()

    content = content.replace("import '../global_theme_notifier.dart';\n", "")

    with open(filepath, 'w', encoding='utf-8') as f:
        f.write(content)
        
for fname in files_to_process:
    final_cleanup('d:/học/Thanh toán điện tử/app new/AppTC/mobile/lib/screens/' + fname)

print("Final Clean")
