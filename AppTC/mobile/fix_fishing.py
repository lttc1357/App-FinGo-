with open('lib/screens/games/fishing_cat_game.dart', 'r') as f:
    c = f.read()
c = c.replace('FontWeight.black', 'FontWeight.w900')
with open('lib/screens/games/fishing_cat_game.dart', 'w') as f:
    f.write(c)
