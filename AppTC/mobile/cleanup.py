import os
import re

files_with_theme = [
    'lib/screens/home_screen.dart',
    'lib/screens/play_screen.dart',
    'lib/screens/quiz_list_screen.dart',
    'lib/screens/scan_screen.dart',
    'lib/screens/stats_screen.dart'
]

for path in files_with_theme:
    if os.path.exists(path):
        with open(path, 'r', encoding='utf-8') as f:
            c = f.read()
        
        # If theme is only assigned but not used (except inal theme = Theme.of(context);)
        # then if 'theme.' is not in c or 'theme.' only once? Actually just regex it out if 'theme.' doesn't appear
        # Actually it's safe to just check if c.count('theme.') == 0 and c.count('theme.brightness') == 0.
        if 'theme.' not in c:
            c = re.sub(r'\s*final theme = Theme\.of\(context\);\n', '', c)
            # also might be inal theme = Theme.of(context); inside { ... }
            c = c.replace('final theme = Theme.of(context);', '')
        
        with open(path, 'w', encoding='utf-8') as f:
            f.write(c)

# Clean underscores in onPopInvokedWithResult: (__, ___) or (_, __) -> (didPop, result)
def fix_underscores(path):
    if not os.path.exists(path): return
    with open(path, 'r', encoding='utf-8') as f:
        c = f.read()
    c = re.sub(r'onPopInvokedWithResult:\s*\(([^)]*)\)', r'onPopInvokedWithResult: (didPop, result)', c)
    with open(path, 'w', encoding='utf-8') as f:
        f.write(c)

for g in ['lib/screens/games/cat_ball_throw_game.dart', 'lib/screens/games/fishing_cat_game.dart', 'lib/screens/games/platform_jump_game.dart']:
    fix_underscores(g)

print("Fixed theme and underscores")
