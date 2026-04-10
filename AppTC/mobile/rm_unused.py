import os
import re

files_with_unused = [
    'lib/screens/home_screen.dart',
    'lib/screens/play_screen.dart',
    'lib/screens/quiz_list_screen.dart',
    'lib/screens/scan_screen.dart',
    'lib/screens/stats_screen.dart'
]

for path in files_with_unused:
    if os.path.exists(path):
        with open(path, 'r', encoding='utf-8') as f:
            c = f.read()

        # Remove the injected local variables that we inlined later
        c = re.sub(r'^\s*final isDark = theme\.brightness == Brightness\.dark;\n', '', c, flags=re.MULTILINE)
        c = re.sub(r'^\s*final cardColor = theme\.cardColor;\n', '', c, flags=re.MULTILINE)
        c = re.sub(r'^\s*final textColor = theme\.colorScheme\.onSurface;\n', '', c, flags=re.MULTILINE)
        c = re.sub(r'^\s*final subTextColor = theme\.colorScheme\.onSurfaceVariant;\n', '', c, flags=re.MULTILINE)
        # sometimes theme is unused inside the block
        
        with open(path, 'w', encoding='utf-8') as f:
            f.write(c)

print("Removed unused variables")
