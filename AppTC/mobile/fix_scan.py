import os

path = 'D:/h\u1ecdc/Thanh toán \u0111i\u1ec7n t\u1eed/app new/AppTC/mobile/lib/screens/scan_screen.dart'
with open(path, 'r', encoding='utf-8') as f:
    c = f.read()

c = c.replace('final theme = Theme.of(context);\n', '')

with open(path, 'w', encoding='utf-8') as f:
    f.write(c)

print("Fixed scan_screen")
