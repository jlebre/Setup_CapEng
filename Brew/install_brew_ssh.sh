#!/bin/bash

# =================================================================
# Script: Instalação Customizada do Homebrew via SSH
# Descrição: Resolve erro SSL (60) alterando o protocolo para SSH
# =================================================================

set -e # Para o script se algum comando falhar

echo "🚀 Iniciando a configuração do Homebrew via SSH..."

# 1. Gerar chave SSH se não existir
if [ ! -f ~/.ssh/id_ed25519 ]; then
    echo "🔑 Gerando nova chave SSH..."
    ssh-keygen -t ed25519 -N "" -f ~/.ssh/id_ed25519
    echo "✅ Chave gerada. COPIE O CONTEÚDO ABAIXO E ADICIONE AO GITHUB:"
    cat ~/.ssh/id_ed25519.pub
    echo "-------------------------------------------------------"
    read -p "Pressione [Enter] depois de ter adicionado a chave ao GitHub para continuar..."
fi

# 2. Clonar instalador
echo "📂 Clonando repositório do instalador..."
rm -rf ~/.homebrew # Limpa instalação anterior se existir
git clone git@github.com:Homebrew/install.git ~/.homebrew
cd ~/.homebrew

# 3. Alterar HTTPS para SSH usando SED
echo "🛠️  Modificando URLs no install.sh..."
sed -i 's|https://github.com/Homebrew/brew.git|git@github.com:Homebrew/brew.git|g' install.sh
sed -i 's|https://github.com/Homebrew/homebrew-core.git|git@github.com:Homebrew/homebrew-core.git|g' install.sh

# 4. Executar o instalador modificado
echo "🍺 Executando o instalador do Homebrew..."
./install.sh

# 5. Configurar o PATH no .bashrc
echo "⚙️  Configurando variáveis de ambiente..."
BREW_ENV='eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"'
if ! grep -q "$BREW_ENV" ~/.bashrc; then
    echo "" >> ~/.bashrc
    echo "$BREW_ENV" >> ~/.bashrc
fi
eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"

# 6. Instalar dependências essenciais
echo "📦 Instalando dependências e GCC..."
sudo apt-get update
sudo apt-get install -y build-essential
brew install gcc

echo "🎉 Instalação concluída com sucesso!"
brew --version