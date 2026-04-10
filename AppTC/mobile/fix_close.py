import os

path = 'D:/h\u1ecdc/Thanh toán \u0111i\u1ec7n t\u1eed/app new/AppTC/mobile/lib/screens/home_screen.dart'
with open(path, 'r', encoding='utf-8') as f:
    lines = f.readlines()

new_lines = []
for i, line in enumerate(lines):
    if "          ]," in line and lines[i+1].startswith("        ),") and lines[i+2].startswith("      );") and 'fit: BoxFit.cover' in "".join(lines[max(0, i-10):i]):
        # Found the right branch!
        # insert the closing parenthesis for GestureDetector BEFORE the ],
        new_lines.append("          ),\n")
    new_lines.append(line)

with open(path, 'w', encoding='utf-8') as f:
    f.writelines(new_lines)

print("Appended closing parenthesis")
