import os

path = 'D:/h\u1ecdc/Thanh toán \u0111i\u1ec7n t\u1eed/app new/AppTC/mobile/lib/screens/home_screen.dart'
with open(path, 'r', encoding='utf-8') as f:
    c = f.read()

old_block = """            Container(
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(
                    color: Colors.blueAccent.withValues(alpha: 0.2),"""

new_block = """            GestureDetector(
              onTap: widget.onAcademyTap,
              child: Container(
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.blueAccent.withValues(alpha: 0.2),"""

old_end = """                      fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
          ],
        ),
      );
    }"""

new_end = """                      fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
            ),
          ],
        ),
      );
    }"""

if old_block in c and old_end in c:
    c = c.replace(old_block, new_block)
    c = c.replace(old_end, new_end)
    with open(path, 'w', encoding='utf-8') as f:
        f.write(c)
    print("Successfully replaced with python")
else:
    print("Could not find blocks. Printing surrounding lines of old_block...")
    print(c[c.find('Chào buổi sáng'):c.find('Chào buổi sáng') + 1000])
