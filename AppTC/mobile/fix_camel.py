import os

path = 'D:/h\u1ecdc/Thanh toán \u0111i\u1ec7n t\u1eed/app new/AppTC/mobile/lib/screens/games/cat_racing_game.dart'
with open(path, 'r', encoding='utf-8') as f:
    c = f.read()

c = c.replace('_buildDashedLine(', '_BuildDashedLine(')
c = c.replace('class _buildDashedLine', 'class _BuildDashedLine')

with open(path, 'w', encoding='utf-8') as f:
    f.write(c)

print("Fixed camel_case in cat_racing_game.dart")
