import re

with open('lib/main_screen.dart', 'r') as f:
    text = f.read()

# Fix OVERFLOWED BY 1.5 PIXELS by tweaking padding & font size in main_screen.dart nav item
text = text.replace("padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8)", "padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8)")
text = text.replace("letterSpacing: 1.5", "letterSpacing: 0.5")
text = text.replace("flex: 1", "flex: 1")

with open('lib/main_screen.dart', 'w') as f:
    f.write(text)

