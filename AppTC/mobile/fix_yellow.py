import os
import re

count = 0
for root, dirs, files in os.walk('lib'):
    for file in files:
        if file.endswith('.dart'):
            filepath = os.path.join(root, file)
            with open(filepath, 'r', encoding='utf-8') as f:
                content = f.read()

            original = content

            # Fix withOpacity
            content = content.replace('.withOpacity(', '.withValues(alpha: ')
            
            # Fix print
            if 'print(' in content:
                content = re.sub(r'\bprint\(', 'debugPrint(', content)
                if 'debugPrint(' in content:
                    if 'package:flutter/foundation.dart' not in content and 'package:flutter/material.dart' not in content:
                        content = "import 'package:flutter/foundation.dart';\n" + content

            # Fix onPopInvoked -> onPopInvokedWithResult
            content = re.sub(r'onPopInvoked:\s*\(([^)]*)\)', r'onPopInvokedWithResult: (\1, __)', content)
            
            # Fix deprecated text styles if any, skip for now.

            if content != original:
                with open(filepath, 'w', encoding='utf-8') as f:
                    f.write(content)
                count += 1

print(f"Updated {count} files")
