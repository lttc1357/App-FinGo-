import os

filepath = 'D:/h\u1ecdc/Thanh toán \u0111i\u1ec7n t\u1eed/app new/AppTC/mobile/lib/screens/scan_screen.dart'
with open(filepath, 'r', encoding='utf-8') as f:
    c = f.read()

c = c.replace('fillColor: Colors.white,', 'fillColor: Theme.of(context).cardColor,')

with open(filepath, 'w', encoding='utf-8') as f:
    f.write(c)
print("Fixed white text field background")
