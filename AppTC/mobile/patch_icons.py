import re

# 1. Update Platform Jump
file_p = 'lib/screens/games/platform_jump_game.dart'
try:
    with open(file_p, 'r') as f:
        code_p = f.read()
    code_p = code_p.replace("const Text('😺', style: TextStyle(fontSize: 40))", "const Icon(Icons.pets, color: Colors.orangeAccent, size: 45)")
    with open(file_p, 'w') as f:
        f.write(code_p)
    print("Patched platform_jump_game.dart")
except Exception as e:
    print(e)

# 2. Update Cat Racing
file_c = 'lib/screens/games/cat_racing_game.dart'
try:
    with open(file_c, 'r') as f:
        code_c = f.read()
    code_c = code_c.replace("const Text('😺', style: TextStyle(fontSize: 36))", "const Icon(Icons.pets, color: Colors.white, size: 36)")
    with open(file_c, 'w') as f:
        f.write(code_c)
    print("Patched cat_racing_game.dart")
except Exception as e:
    print(e)
