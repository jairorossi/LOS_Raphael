import os
import textwrap

print("=== Starting depmod prebuilt patcher ===")
patched_any = False

# Procura na pasta prebuilts/
for root, dirs, files in os.walk('prebuilts'):
    if 'depmod' in files:
        depmod_path = os.path.join(root, 'depmod')
        real_path = depmod_path + '.real'
        if not os.path.exists(real_path):
            print('Patching prebuilt depmod at:', depmod_path)
            os.rename(depmod_path, real_path)
            
            wrapper_content = textwrap.dedent('''#!/bin/bash
            echo "=== Prebuilt Depmod Wrapper Active ==="
            for arg in "$@"; do
              if [[ "$arg" == *"/depmod_vendor_intermediates"* ]]; then
                BASE_DIR=$(echo "$arg" | sed 's|/lib/modules.*||')
                echo "Base directory found: $BASE_DIR"
                SRC_DIR=$(find "$BASE_DIR/lib/modules" -mindepth 1 -maxdepth 1 -type d ! -name "0.0" | head -n 1)
                if [ -n "$SRC_DIR" ] && [ -d "$SRC_DIR" ]; then
                  echo "Copying modules from $SRC_DIR to 0.0..."
                  mkdir -p "$BASE_DIR/lib/modules/0.0"
                  cp -r "$SRC_DIR/"* "$BASE_DIR/lib/modules/0.0/"
                  VERSION_NAME=$(basename "$SRC_DIR")
                  ln -sf "$VERSION_NAME" "$BASE_DIR/lib/modules/0.0" || true
                fi
                break
              fi
            done
            REAL_DIR=$(dirname "$0")
            exec -a depmod "$REAL_DIR/depmod.real" "$@"
            ''').strip()
            
            with open(depmod_path, 'w') as f:
                f.write(wrapper_content + '\n')
            os.chmod(depmod_path, 0o755)
            print('Successfully patched!')
            patched_any = True

if not patched_any:
    print('No unpatched prebuilt depmod binaries found.')
