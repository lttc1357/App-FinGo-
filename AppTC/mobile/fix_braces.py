import os

path = 'D:/h\u1ecdc/Thanh toán \u0111i\u1ec7n t\u1eed/app new/AppTC/mobile/lib/screens/games/cat_racing_game.dart'
with open(path, 'r', encoding='utf-8') as f:
    c = f.read()

c = c.replace('} else if (details.primaryVelocity! > 0) moveRight();', '} else if (details.primaryVelocity! > 0) { moveRight(); }')

with open(path, 'w', encoding='utf-8') as f:
    f.write(c)

print("Fixed curly braces in racing")
import os

path = 'D:/h\u1ecdc/Thanh toán \u0111i\u1ec7n t\u1eed/app new/AppTC/mobile/lib/screens/games/fishing_cat_game.dart'
with open(path, 'r', encoding='utf-8') as f:
    c = f.read()

c = c.replace('} else if (e.x < 0.0) e.direction = 1;', '} else if (e.x < 0.0) { e.direction = 1; }')
c = c.replace("if(e.type == 'jellyfish') e.y +=", "if (e.type == 'jellyfish') { e.y +=")
c = c.replace("* 0.01;", "* 0.01; }")

with open(path, 'w', encoding='utf-8') as f:
    f.write(c)

print("Fixed curly braces in fishing")
