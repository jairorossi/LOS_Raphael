#!/bin/bash
set -e

# ==============================================================================
# LineageOS 19.1 Build Script for Xiaomi Mi 9T Pro / Redmi K20 Pro (raphael)
# Mantido por: Jairo Rossi (jairorossi)
# ==============================================================================

WORK_DIR="${HOME}/android/lineage"
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
MANIFEST_SRC="${SCRIPT_DIR}/local_manifests/raphael.xml"
MANIFEST_DST="${WORK_DIR}/.repo/local_manifests/raphael.xml"

echo "=========================================================="
echo "    Iniciando Build LineageOS 19.1 - Raphael (Jairo Rossi)"
echo "=========================================================="

# 1. Criar pasta de trabalho
mkdir -p "${WORK_DIR}"
cd "${WORK_DIR}"

# 2. Inicializar repositório base se ainda não inicializado
if [ ! -d ".repo" ]; then
    echo "[*] Inicializando repositório LineageOS 19.1..."
    repo init -u https://github.com/LineageOS/android.git -b lineage-19.1 --git-lfs
fi

# 3. Aplicar local manifests
echo "[*] Aplicando local manifests customizados..."
mkdir -p "${WORK_DIR}/.repo/local_manifests"
cp -f "${MANIFEST_SRC}" "${MANIFEST_DST}"

# 4. Sincronizar fontes
echo "[*] Sincronizando repositórios (pode levar alguns minutos)..."
repo sync -c -j$(nproc --all) --force-sync --no-clone-bundle --no-tags

# 5. Otimizações de compilação e CCACHE
export USE_CCACHE=1
export CCACHE_EXEC=/usr/bin/ccache
export CCACHE_DIR="${HOME}/.ccache"
ccache -M 50G

# 6. Preparar ambiente de compilação
echo "[*] Configurando ambiente Android..."
source build/envsetup.sh

# 7. Selecionar alvo do Raphael
echo "[*] Configurando alvo lineage_raphael-userdebug..."
breakfast raphael userdebug

# 8. Iniciar compilação
echo "[*] Compilando a ROM com mka bacon..."
mka bacon -j$(nproc --all)

echo "=========================================================="
echo "    BUILD CONCLUÍDA COM SUCESSO!"
echo "=========================================================="
ZIP_PATH=$(find "${WORK_DIR}/out/target/product/raphael" -name "lineage-19.1-*-UNOFFICIAL-raphael.zip" -type f 2>/dev/null | tail -n 1)
if [ -n "${ZIP_PATH}" ]; then
    echo "ROM ZIP gerada em: ${ZIP_PATH}"
    ls -lh "${ZIP_PATH}"
fi
echo "=========================================================="