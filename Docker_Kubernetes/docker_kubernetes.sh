#!/bin/bash

# Cores para o terminal
GREEN='\033[0;32m'
BLUE='\033[0;34m'
YELLOW='\033[1;33m'
NC='\033[0m'

set -e # Interrompe o script se houver erro

echo -e "${BLUE}======================================================"
echo -e "🐳 Setup: Docker, Kubernetes & Gestão (via Brew)"
echo -e "======================================================${NC}"

# 1. Dependências do Sistema (Ubuntu)
echo -e "\n${YELLOW}[1/4] Instalando Docker Engine via APT...${NC}"
sudo apt-get update
sudo apt-get install -y build-essential docker.io

# Configura permissões para o Docker (evita usar sudo sempre)
sudo usermod -aG docker $USER

# 2. Ferramentas via Homebrew
echo -e "\n${YELLOW}[2/4] Instalando binários via Homebrew...${NC}"
brew install docker docker-compose
brew install kubernetes-cli helm

# 3. Cluster Local e Interface
echo -e "\n${YELLOW}[3/4] Instalando Minikube e K9s...${NC}"
brew install minikube
brew install derailed/k9s/k9s

# 4. Verificação Final
echo -e "\n${BLUE}======================================================"
echo -e "✅ Verificação de Versões:"
echo -e "------------------------------------------------------"
echo -e "Docker CLI:  $(docker -v)"
echo -e "Kubectl:     $(kubectl version --client --short 2>/dev/null || echo 'Instalado')"
echo -e "Helm:        $(helm version --short)"
echo -e "Minikube:    $(minikube version --short)"
echo -e "K9s:         $(k9s version | grep 'Version' | awk '{print $2}' || echo 'Instalado')"
echo -e "======================================================${NC}"

echo -e "${GREEN}🚀 Instalação terminada com sucesso!${NC}"
echo -e "\n${YELLOW}⚠️  PRÓXIMOS PASSOS:${NC}"
echo -e "1. ${BLUE}Reinicia a tua sessão${NC} (Logout/Login) para as permissões do Docker funcionarem."
echo -e "2. Inicia o Kubernetes com: ${BLUE}minikube start${NC}"
echo -e "3. Abre a interface de gestão com: ${BLUE}k9s${NC}"