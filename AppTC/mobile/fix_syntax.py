import os

path = 'D:/h\u1ecdc/Thanh toán \u0111i\u1ec7n t\u1eed/app new/AppTC/mobile/lib/screens/home_screen.dart'
with open(path, 'r', encoding='utf-8') as f:
    c = f.read()

bad_block = '''          GestureDetector(
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
            child: CircleAvatar(
              radius: 28,
              backgroundColor: Colors.white,
              child: ClipOval(
                child: Image.network(
                  'https://api.dicebear.com/7.x/avataaars/png?seed=Alex&backgroundColor=b6e3f4',
                  width: 50,
                  height: 50,
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBalanceCard() {'''

good_block = '''          GestureDetector(
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
              child: CircleAvatar(
                radius: 28,
                backgroundColor: Colors.white,
                child: ClipOval(
                  child: Image.network(
                    'https://api.dicebear.com/7.x/avataaars/png?seed=Alex&backgroundColor=b6e3f4',
                    width: 50,
                    height: 50,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBalanceCard() {'''

c = c.replace(bad_block, good_block)

with open(path, 'w', encoding='utf-8') as f:
    f.write(c)

print("Restored syntax properly")
