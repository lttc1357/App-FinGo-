import os

path = 'D:/h\u1ecdc/Thanh toán \u0111i\u1ec7n t\u1eed/app new/AppTC/mobile/lib/screens/home_screen.dart'
with open(path, 'r', encoding='utf-8') as f:
    c = f.read()

old_str = '''            Container(
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(
                    color: Colors.blueAccent.withValues(alpha: 0.2),
                    blurRadius: 10,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: CircleAvatar('''

new_str = '''            GestureDetector(
              onTap: widget.onAcademyTap,
              child: Container(
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.blueAccent.withValues(alpha: 0.2),
                      blurRadius: 10,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: CircleAvatar('''

if old_str in c:
    c = c.replace(old_str, new_str)
    # Don't forget to close the extra parenthesis/bracket if we wrapped a whole widget, but since we just wrapped Container with GestureDetector( child: Container( ... , we only need to add ), at the end of the Container.
    # Wait, the Container ends after the CircleAvatar block. Let's do it safely using Regex or manual matching of the full block.
