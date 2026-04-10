import os
import re

files_to_process = [
    'home_screen.dart',
    'stats_screen.dart',
    'play_screen.dart',
    'quiz_list_screen.dart',
    'scan_screen.dart'
]

def safer_replace(filepath):
    if not os.path.exists(filepath): return
    with open(filepath, 'r', encoding='utf-8') as f:
        content = f.read()

    # First, let's inject local theme variables at the top of build methods.
    build_pattern = re.compile(r'Widget build\(BuildContext context\) \{')
    injection = '''Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    final cardColor = theme.cardColor;
    final textColor = theme.colorScheme.onSurface;
    final subTextColor = theme.colorScheme.onSurfaceVariant;'''
    
    if "final isDark = theme.brightness == Brightness.dark;" not in content:
        content = build_pattern.sub(injection, content)

    # Now, carefully replace hardcoded styles that we reverted earlier.
    # Look closely at how we replaced previously. We reverted them to:
    # color: Theme.of(context).colorScheme.onSurface
    # color: Theme.of(context).colorScheme.onSurfaceVariant
    # So we don't need to replace text colors again, they are already onSurface/onSurfaceVariant from the previous revert script.
    
    # Let's check text colors in content
    # In earlier reverts, we did:
    # content = content.replace("color: textColor", "color: Theme.of(context).colorScheme.onSurface")
    # content = content.replace("color: subTextColor", "color: Theme.of(context).colorScheme.onSurfaceVariant")
    
    # We want to conditionally change White container backgrounds to cardColor.
    # But only specific ones! 
    # Example 1: decoration: BoxDecoration(\n              color: Colors.white, ... boxShadow
    # Example 2: Container(\n      ... decoration: BoxDecoration(\n        color: Colors.white,
    
    content = re.sub(r'color:\s*Colors\.white,(\s*(?:borderRadius|boxShadow|shape))', r'color: cardColor,\1', content)
    # Also for stats_screen selected background:
    # color: isSelected ? const Color(0xFF3A7BD5) : Colors.white,
    content = content.replace('color: isSelected ? const Color(0xFF3A7BD5) : Colors.white,', 'color: isSelected ? const Color(0xFF3A7BD5) : cardColor,')

    # Also stats_screen graph bars and item cards
    content = content.replace('decoration: BoxDecoration(color: Colors.white', 'decoration: BoxDecoration(color: cardColor')
    
    # AppTC\mobile\lib\screens\stats_screen.dart (and others)
    # color: Colors.black 
    # Let's make sure shadow colors adapt or disappear:
    content = content.replace('color: Colors.grey.withOpacity(0.15)', 'color: isDark ? Colors.black26 : Colors.grey.withOpacity(0.15)')
    content = content.replace('color: Colors.grey.withOpacity(0.05)', 'color: isDark ? Colors.black12 : Colors.grey.withOpacity(0.05)')
    content = content.replace('color: Colors.grey.shade100,', 'color: isDark ? Colors.black12 : Colors.grey.shade100,')
    content = content.replace('color: isSelected ? Colors.white : Colors.grey.shade600,', 'color: isSelected ? Colors.white : subTextColor,')
    content = content.replace('color: isDanger ? Colors.redAccent : const Color(0xFF2D3142)', 'color: isDanger ? Colors.redAccent : textColor')

    # Text colors left behind in play_screen.dart: PlayScreen has 'const Color(0xFF2D3142)'
    content = content.replace('color: const Color(0xFF2D3142)', 'color: textColor')
    content = content.replace('color: Colors.grey.shade500', 'color: subTextColor')
    content = content.replace('color: Colors.grey.shade600', 'color: subTextColor')

    with open(filepath, 'w', encoding='utf-8') as f:
        f.write(content)

for fname in files_to_process:
    safer_replace('d:/học/Thanh toán điện tử/app new/AppTC/mobile/lib/screens/' + fname)

print("Smart replace completed")
