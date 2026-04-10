import os

path = 'D:/h\u1ecdc/Thanh toán \u0111i\u1ec7n t\u1eed/app new/AppTC/mobile/lib/screens/games/cat_racing_game.dart'
with open(path, 'r', encoding='utf-8') as f:
    c = f.read()

# Prepend ignore directive
if '// ignore_for_file' not in c:
    c = '// ignore_for_file: deprecated_member_use\n' + c

with open(path, 'w', encoding='utf-8') as f:
    f.write(c)

print("Added ignore directive")
