import os

path = 'D:/h\u1ecdc/Thanh toán \u0111i\u1ec7n t\u1eed/app new/AppTC/mobile/lib/screens/stats_screen.dart'
with open(path, 'r', encoding='utf-8') as f:
    c = f.read()

c = c.replace("'bars': [0.6, 0.4, 0.85, 0.3, 1.0],", "'bars': [0.6, 0.4, 0.85, 0.3],")
c = c.replace("'labels': ['Tuần 1', 'Tuần 2', 'Tuần 3', 'Tuần 4', 'Tuần 5'],", "'labels': ['Tuần 1', 'Tuần 2', 'Tuần 3', 'Tuần 4'],")

with open(path, 'w', encoding='utf-8') as f:
    f.write(c)

print("Removed Tuan 5")
