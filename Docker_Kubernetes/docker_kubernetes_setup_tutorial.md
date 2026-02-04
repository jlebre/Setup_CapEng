## 📄 Tutorial de Instalação

Para configurar as ferramentas necessárias de Docker e Kubernetes utilizando o teu Homebrew já instalado:

1. **Dar permissão de execução:**
```bash
chmod +x docker_kubernetes.sh

```


2. **Correr o script:**
```bash
./docker_kubernetes.sh

```



---

## 💻 O Script: `docker_kubernetes.sh`

```bash
#!/bin/bash

# Cores para o output
GREEN='\033[0;32m'
BLUE='\033[0;34m'
YELLOW='\033[1;33m'
NC='\033[0m'

set -e # Para se houver erro

echo -e "${BLUE}======================================================"
echo -e "🐳 Setup: Docker, Kubernetes & Cloud Tools"
echo -e "======================================================${NC}"

# --- 1. DEPENDÊNCIAS DO SISTEMA (UBUNTU) ---
echo -e "\n${YELLOW}[1/4] Instalando Docker Engine via APT (Sudo necessário)...${NC}"
sudo apt-get update
sudo apt-get install -y build-essential docker.io
# Adiciona o utilizador ao grupo docker para não precisar de sudo no CLI
sudo usermod -aG docker $USER

# --- 2. FERRAMENTAS VIA BREW ---
echo -e "\n${YELLOW}[2/4] Instalando CLI Tools via Brew...${NC}"
# Nota: Instalamos o cliente docker no brew para garantir compatibilidade de versões
brew install docker docker-compose
brew install kubernetes-cli helm

# --- 3. CLUSTER LOCAL & MONITORIZAÇÃO ---
echo -e "\n${YELLOW}[3/4] Instalando Minikube e K9s...${NC}"
brew install minikube
brew install derailed/k9s/k9s

# --- 4. VERIFICAÇÃO FINAL ---
echo -e "\n${BLUE}======================================================"
echo -e "✅ Verificação de Instalação:"
echo -e "------------------------------------------------------"
echo "Docker CLI: $(docker -v)"
echo "Kubectl:    $(kubectl version --client --short 2>/dev/null || echo 'Instalado')"
echo "Helm:       $(helm version --short)"
echo "Minikube:   $(minikube version --short)"
echo "K9s:        $(k9s version | grep 'Version' || echo 'Instalado')"
echo -e "======================================================${NC}"

echo -e "${GREEN}🚀 Tudo pronto!${NC}"
echo -e "${YELLOW}DICA IMPORTANTE:${NC}"
echo -e "1. Reinicia a sessão (Logout/Login) para poderes usar o Docker sem 'sudo'."
echo -e "2. Inicia o teu cluster com: ${BLUE}minikube start${NC}"
echo -e "3. Gere o cluster visualmente com: ${BLUE}k9s${NC}"

```
