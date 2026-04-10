import os

path = 'D:/h\u1ecdc/Thanh toán \u0111i\u1ec7n t\u1eed/app new/AppTC/mobile/lib/screens/quiz_list_screen.dart'
with open(path, 'r', encoding='utf-8') as f:
    c = f.read()

c = c.replace('color: cardColor,', 'color: Theme.of(context).cardColor,')
c = c.replace('isDark ?', '(Theme.of(context).brightness == Brightness.dark) ?')

with open(path, 'w', encoding='utf-8') as f:
    f.write(c)

print("Inlined quiz variables")
