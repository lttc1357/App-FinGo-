import os

with open('D:/h\u1ecdc/Thanh toán \u0111i\u1ec7n t\u1eed/app new/AppTC/mobile/lib/screens/stats_screen.dart', 'r', encoding='utf-8') as f:
    content = f.read()

content = content.replace('color: isSelected ? const Color(0xFF3A7BD5) : cardColor,', 'color: isSelected ? const Color(0xFF3A7BD5) : Theme.of(context).cardColor,')
content = content.replace('color: isSelected ? Colors.white : subTextColor,', 'color: isSelected ? Colors.white : Theme.of(context).colorScheme.onSurfaceVariant,')
content = content.replace('color: isDanger ? Colors.redAccent : textColor,', 'color: isDanger ? Colors.redAccent : Theme.of(context).colorScheme.onSurface,')

with open('D:/h\u1ecdc/Thanh toán \u0111i\u1ec7n t\u1eed/app new/AppTC/mobile/lib/screens/stats_screen.dart', 'w', encoding='utf-8') as f:
    f.write(content)

print("Remaining variables inlined!")
