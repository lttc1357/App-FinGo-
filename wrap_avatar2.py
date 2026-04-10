import os

path = 'D:/h\u1ecdc/Thanh toán \u0111i\u1ec7n t\u1eed/app new/AppTC/mobile/lib/screens/home_screen.dart'
with open(path, 'r', encoding='utf-8') as f:
    c = f.read()

c = c.replace("""          Container(
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              boxShadow: [
                BoxShadow(
                  color: Colors.blueAccent.withValues(alpha: 0.2),""", """          GestureDetector(
            onTap: widget.onAcademyTap,
            child: Container(
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(
                    color: Colors.blueAccent.withValues(alpha: 0.2),""")

c = c.replace("""                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
          ],
        ),
      );
    }""", """                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
          ),
          ],
        ),
      );
    }""")

with open(path, 'w', encoding='utf-8') as f:
    f.write(c)

print("Done wrapping avatar")
