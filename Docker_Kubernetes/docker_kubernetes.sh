#!/bin/bash

# Cores para o output
GREEN='\033[0;32m'
BLUE='\033[0;34m'
YELLOW='\033[1;33m'
NC='\033[0m'

set -e # Para se houver erro

echo -e "${BLUE}======================================================"
echo -e "🌐 Full Setup: Homebrew, Docker & Kubernetes"
echo -e "======================================================${NC}"

# --- 1. CONFIGURAÇÃO SSH & BREW ---
if ! command -v brew &> /dev/null; then
    echo -e "\n${YELLOW}[1/5] Configurando Homebrew via SSH...${NC}"
    
    if [ ! -f ~/.ssh/id_ed25519 ]; then
        echo "🔑 Gerando chave SSH..."
        ssh-keygen -t ed25519 -N "" -f ~/.ssh/id_ed25519
        echo -e "${YELLOW}Copia esta chave e adiciona-a ao GitHub (Settings > SSH keys):${NC}"
        cat ~/.ssh/id_ed25519.pub
        read -p "Prime [Enter] após adicionar a chave para continuar..."
    fi

    echo "📂 Clonando e modificando instalador..."
    rm -rf ~/.homebrew
    git clone git@github.com:Homebrew/install.git ~/.homebrew
    cd ~/.homebrew
    sed -i 's|https://github.com/Homebrew/brew.git|git@github.com:Homebrew/brew.git|g' install.sh
    sed -i 's|https://github.com/Homebrew/homebrew-core.git|git@github.com:Homebrew/homebrew-core.git|g' install.sh
    ./install.sh
    
    echo 'eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"' >> ~/.bashrc
    eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"
else
    echo -e "\n${GREEN}✅ Homebrew já está instalado.${NC}"
fi

# --- 2. DEPENDÊNCIAS DO SISTEMA (UBUNTU) ---
echo -e "\n${YELLOW}[2/5] Instalando dependências do SO (Sudo necessário)...${NC}"
sudo apt-get update
sudo apt-get install -y build-essential docker.io
sudo usermod -aG docker $USER

# --- 3. FERRAMENTAS DOCKER & K8S VIA BREW ---
echo -e "\n${YELLOW}[3/5] Instalando binários via Brew...${NC}"
brew install gcc
brew install docker docker-compose
brew install kubernetes-cli helm

# --- 4. CLUSTER LOCAL & MONITORIZAÇÃO ---
echo -e "\n${YELLOW}[4/5] Instalando Minikube e K9s...${NC}"
brew install minikube
brew install derailed/k9s/k9s

# --- 5. VERIFICAÇÃO FINAL ---
echo -e "\n${BLUE}======================================================"
echo -e "✅ Verificação de Instalação:"
echo -e "------------------------------------------------------"
echo "Brew: $(brew -v | head -n 1)"
echo "Docker CLI: $(docker -v)"
echo "Kubectl: $(kubectl version --client --short 2>/dev/null || echo 'Instalado')"
echo "Helm: $(helm version --short)"
echo "Minikube: $(minikube version --short)"
echo -e "======================================================${NC}"

echo -e "${GREEN}🚀 Tudo pronto!${NC}"
echo -e "${YELLOW}NOTA:${NC} Para o Docker funcionar sem sudo, reinicia a sessão (logout/login)."
echo -e "Para abrir o painel K8s, basta digitar: ${BLUE}k9s${NC}"