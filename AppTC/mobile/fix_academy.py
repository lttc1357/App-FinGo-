import os

filepath = 'D:/h\u1ecdc/Thanh toán \u0111i\u1ec7n t\u1eed/app new/AppTC/mobile/lib/screens/academy_screen.dart'
if os.path.exists(filepath):
    print("Found!")
    with open(filepath, 'r', encoding='utf-8') as f:
        c = f.read()

    new_line = 'isDarkModeGlobal.value = v;\n                  setState(() {});'
    if 'setState(() {});' not in c:
        c = c.replace('isDarkModeGlobal.value = v;', new_line)

    with open(filepath, 'w', encoding='utf-8') as f:
        f.write(c)
    print("Added setState to the switch onChanged")
else:
    print("Not found")
