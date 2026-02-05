#!/bin/bash

# Cores para o terminal
GREEN='\033[0;32m'
BLUE='\033[0;34m'
YELLOW='\033[1;33m'
RED='\033[0;31m'
NC='\033[0m'

# Configuração para ignorar SSL se estiver em rede corporativa restrita
# Descomente a linha abaixo se os erros de certificado persistirem
# export HOMEBREW_CURL_RC=1 && echo "insecure" > ~/.curlrc

set -e 

echo -e "${BLUE}======================================================"
echo -e "🐳 Setup Corrigido: Docker & K8s (Ubuntu Noble)"
echo -e "======================================================${NC}"

# 1. Limpeza de Repositórios Mortos (Correção do Erro 404/SSL)
echo -e "\n${YELLOW}[1/5] Limpando fontes de pacotes antigas...${NC}"
# Remove o repositório do Kubernetes que está dando erro 404/SSL
sudo rm -f /etc/apt/sources.list.d/kubernetes.list
sudo rm -f /etc/apt/sources.list.d/archive_uri-https_apt_kubernetes_io-noble.list

# 2. Dependências do Sistema (Ubuntu)
echo -e "\n${YELLOW}[2/5] Instalando Docker Engine (Servidor)...${NC}"
# Usamos o docker.io do repositório oficial do Ubuntu para evitar conflitos de GPG externos em rede corporativa
sudo apt-get update -y || echo -e "${RED}Aviso: Alguns repositórios falharam, mas continuando...${NC}"
sudo apt-get install -y build-essential docker.io

# Configura permissões para o Docker
sudo usermod -aG docker $USER || true

# 3. Ferramentas via Homebrew (Apenas Clientes e Gestão)
echo -e "\n${YELLOW}[3/5] Instalando binários via Homebrew...${NC}"
# Nota: Não instalamos 'docker' via brew no Linux para não conflitar com o docker.io do apt
brew install docker-compose
brew install kubernetes-cli helm

# 4. Cluster Local e Interface
echo -e "\n${YELLOW}[4/5] Instalando Minikube e K9s...${NC}"
brew install minikube
brew install k9s

# 5. Verificação Final
echo -e "\n${BLUE}======================================================"
echo -e "✅ Verificação de Versões:"
echo -e "------------------------------------------------------"
docker -v
kubectl version --client 2>/dev/null | head -n 1
helm version --short
minikube version --short
k9s version | grep 'Version' || echo "K9s instalado"
echo -e "======================================================${NC}"

echo -e "${GREEN}🚀 Instalação terminada com sucesso!${NC}"
echo -e "\n${YELLOW}⚠️  NOTAS IMPORTANTES:${NC}"
echo -e "1. ${BLUE}PERMISSÕES:${NC} Execute 'newgrp docker' ou reinicie a sessão para usar docker sem sudo."
echo -e "2. ${BLUE}SSL/CERTIFICADOS:${NC} Se o Brew falhar, use 'export HOMEBREW_CURL_RC=1' temporariamente."
echo -e "3. ${BLUE}MINIKUBE:${NC} Inicie com 'minikube start --driver=docker'"