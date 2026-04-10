import os
import re

files_with_errors = [
    'D:/h\u1ecdc/Thanh toán \u0111i\u1ec7n t\u1eed/app new/AppTC/mobile/lib/screens/home_screen.dart',
    'D:/h\u1ecdc/Thanh toán \u0111i\u1ec7n t\u1eed/app new/AppTC/mobile/lib/screens/stats_screen.dart',
    'D:/h\u1ecdc/Thanh toán \u0111i\u1ec7n t\u1eed/app new/AppTC/mobile/lib/screens/play_screen.dart',
    'D:/h\u1ecdc/Thanh toán \u0111i\u1ec7n t\u1eed/app new/AppTC/mobile/lib/screens/scan_screen.dart'
]

injection = '''{
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    final cardColor = theme.cardColor;
    final textColor = theme.colorScheme.onSurface;
    final subTextColor = theme.colorScheme.onSurfaceVariant;'''

for filepath in files_with_errors:
    with open(filepath, 'r', encoding='utf-8') as f:
        content = f.read()

    # Find all Widget returning methods that take BuildContext context
    # Regex e.g. Widget _buildSomething(BuildContext context, ...) {
    # If they don't take context, we might need to add it or pass the variables, but usually they take context.
    # Wait, some might look like: Widget _buildSomething() {
    # We can just change all methods that return Widget to ensure they have these variables if they use them.
    # Actually, the simplest fix is to just regex match wherever cardColor, isDark is used, go up to the closest method definition, and inject it if not present.
    # An easier way: just inject the block into ANY method that defines BuildContext context inside the file.
    
    # Or, since it's only a few files, we can globally search for all "Widget [A-Za-z0-9_]+\(.*?\)\s*{"
    # And substitute it. BUT wait, if a method doesn't take context, Theme.of(context) will fail.
    pass
