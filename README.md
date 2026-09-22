# LineageOS 19.1 - Xiaomi Mi 9T Pro / Redmi K20 Pro (`raphael`)

Repositório mestre com manifestos locais, árvores de dispositivos, kernel e configurações personalizadas para compilar a **LineageOS 19.1 (Android 12L)** pronta para uso diário no Xiaomi Mi 9T Pro / Redmi K20 Pro (`raphael`).

---

## 🚀 Recursos e Modificações Incluídas

- **Lawnchair 12.1 + TrebuchetQuickStep**: Launcher moderno Lawnchair integrado em conjunto com o Trebuchet padrão.
- **Menu de Personalizações Exclusivo**: Aba dedicada em *Configurações* com tradução 100% em Português do Brasil (pt-BR).
- **Play Integrity / KeyStore Fix**: Suporte aprimorado para passar nas verificações de integridade sem bloqueios de KeyStore.
- **Bootanimation Oficial**: Corrigida compactação em modo Store (0%), garantindo inicialização fluida e sem travamentos.
- **Kernel SOVIET-ANDROID (12.1-WALT)**: Máxima estabilidade, desempenho e compatibilidade total com o hardware do Raphael.
- **MindTheGapps Integrado**: Google Services (Play Store, Play Services) já incluídos nativamente na compilação.
- **MIUI Gallery & Editor + GBoard**: Aplicativos essenciais integrados via Git LFS.

---

## 🛠️ Requisitos do Sistema

- **Sistema Operacional**: Ubuntu 20.04 LTS ou 22.04 LTS (x86_64)
- **CPU**: 8 núcleos ou mais recomendado
- **Memória RAM**: Mínimo 16 GB (32 GB recomendado ou SWAP de 16 GB+)
- **Armazenamento**: Mínimo 250 GB livres (SSD/NVMe recomendado)

---

## 📦 Como Compilar (Passo a Passo)

### 1. Instalar Dependências do Sistema

```bash
sudo apt update && sudo apt install -y \
    bc bison build-essential ccache curl flex g++-multilib gcc-multilib \
    git git-lfs gnupg gperf imagemagick lib32readline-dev lib32z1-dev \
    libelf-dev liblz4-tool libncurses5 libncurses5-dev libsdl1.2-dev \
    libssl-dev libxml2 libxml2-utils lzop pngcrush rsync schedtool \
    squashfs-tools xsltproc zip zlib1g-dev python3 python-is-python3 openjdk-11-jdk
```

Instale a ferramenta `repo` do Google:
```bash
mkdir -p ~/bin
curl https://storage.googleapis.com/git-repo-downloads/repo > ~/bin/repo
chmod a+x ~/bin/repo
export PATH="${HOME}/bin:${PATH}"
```

### 2. Clonar Este Repositório Mestre

```bash
git clone https://github.com/jairorossi/LOS_Raphael.git ~/LOS_Raphael
cd ~/LOS_Raphael
```

### 3. Executar o Script de Compilação Automatizado

```bash
./build.sh
```

O script cuidará de todas as etapas automaticamente:
1. Inicialização da árvore base do LineageOS 19.1.
2. Inclusão dos manifestos locais de `local_manifests/raphael.xml`.
3. Sincronização de todos os repositórios (`repo sync`).
4. Configuração de CCACHE para acelerar builds futuras.
5. Seleção do alvo `lineage_raphael-userdebug`.
6. Compilação completa da ROM (`mka bacon`).

---

## 📁 Localização do Arquivo ZIP Final

Ao final do processo, o arquivo flashável estará disponível em:
```bash
~/android/lineage/out/target/product/raphael/lineage-19.1-*-UNOFFICIAL-raphael.zip
```

---

## 📲 Como Instalar no Aparelho

1. Reinicie no **Recovery (TWRP / OrangeFox / Lineage Recovery)**.
2. Faça **Wipe** de `Dalvik / ART Cache`, `Cache`, `System`, `Data`.
3. Conecte ao PC via cabo e envie o ZIP:
   ```bash
   adb sideload lineage-19.1-XXXXXXXX-UNOFFICIAL-raphael.zip
   ```
4. Reinicie o sistema (*Reboot System*).

---

## 👤 Autor e Mantenedor

- **Jairo Rossi** ([@jairorossi](https://github.com/jairorossi))