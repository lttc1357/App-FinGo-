import os

files_with_errors = [
    'D:/h\u1ecdc/Thanh toán \u0111i\u1ec7n t\u1eed/app new/AppTC/mobile/lib/screens/home_screen.dart',
    'D:/h\u1ecdc/Thanh toán \u0111i\u1ec7n t\u1eed/app new/AppTC/mobile/lib/screens/stats_screen.dart',
    'D:/h\u1ecdc/Thanh toán \u0111i\u1ec7n t\u1eed/app new/AppTC/mobile/lib/screens/play_screen.dart',
    'D:/h\u1ecdc/Thanh toán \u0111i\u1ec7n t\u1eed/app new/AppTC/mobile/lib/screens/scan_screen.dart'
]

# Instead of injecting variables that aren't accessed because they are in a different scope,
# let's just inline their definitions into the actual variable references that are failing!
subs = {
    'color: cardColor': 'color: Theme.of(context).cardColor',
    'color: isDark ?': 'color: (Theme.of(context).brightness == Brightness.dark) ?',
    'color: textColor': 'color: Theme.of(context).colorScheme.onSurface',
    'color: subTextColor': 'color: Theme.of(context).colorScheme.onSurfaceVariant',
    'color: Theme.of(context).cardColor,': 'color: Theme.of(context).cardColor,', # just in case
}

for filepath in files_with_errors:
    if not os.path.exists(filepath): continue
    with open(filepath, 'r', encoding='utf-8') as f:
        content = f.read()

    # Apply substitutions only in scopes where they are failing, but wait!
    # They are also used in the build method, and they are defined there, so substituting them is totally fine!
    for old, new in subs.items():
        content = content.replace(old, new)
        
    with open(filepath, 'w', encoding='utf-8') as f:
        f.write(content)

print("Inlined Theme variables")
