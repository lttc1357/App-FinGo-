import re

with open('lib/screens/games/platform_jump_game.dart', 'r') as f:
    code = f.read()

# Fix Jump Mechanics
code = code.replace("final double gravity = 0.05;", "final double gravity = 0.04;")
code = code.replace("final double jumpPower = -0.5;", "final double jumpPower = -0.8;")

# Let's fix the start jump 
code = code.replace("catY = 0.8;", "catY = 0.7;")

# Let's replace the whole body Stack slightly so we can use a pan gesture
body_broken = """             // Touch Controls (Half screen left/right)
             if (isPlaying)
               Row(
                 children: [
                    Expanded(
                       child: GestureDetector(
                          onTapDown: (_) => _moveLeft(),
                          child: Container(color: Colors.transparent),
                       )
                    ),
                    Expanded(
                       child: GestureDetector(
                          onTapDown: (_) => _moveRight(),
                          child: Container(color: Colors.transparent),
                       )
                    )
                 ],
               )"""

body_fixed = """             // Touch controls layer covering the screen
             if (isPlaying)
               Positioned.fill(
                 child: GestureDetector(
                   onPanUpdate: (details) {
                      setState(() {
                         catX += details.delta.dx * 0.006;
                         catX = catX.clamp(-1.0, 1.0);
                      });
                   },
                   child: Container(color: Colors.transparent),
                 )
               )"""

code = code.replace(body_broken, body_fixed)

with open('lib/screens/games/platform_jump_game.dart', 'w') as f:
    f.write(code)

