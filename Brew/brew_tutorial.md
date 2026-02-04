# Tutorial: Instalação do Homebrew no Ubuntu (via SSH)

Este guia resolve o erro `(60) SSL certificate` ao tentar instalar o Brew via HTTPS, utilizando uma abordagem alternativa através de SSH.

## 1. Configurar Chaves SSH no GitHub

Se ainda não tens uma chave SSH configurada, segue estes passos:

1. **Gerar a chave:**
No terminal, corre o seguinte comando (prime `Enter` em todas as perguntas para manter o padrão):
```bash
ssh-keygen

```


2. **Copiar a chave pública:**
Exibe o conteúdo da chave e copia o texto que começa com `ssh-ed25519`:
```bash
cat ~/.ssh/id_ed25519.pub

```


3. **Adicionar ao GitHub:**
* Vai a **Settings** > **SSH and GPG keys** > **New SSH key**.
* Cola a chave e guarda.



---

## 2. Clonar e Modificar o Instalador

Como o instalador padrão usa HTTPS, vamos descarregá-lo manualmente e alterar o protocolo para SSH.

1. **Clonar o repositório de instalação:**
```bash
git clone git@github.com:Homebrew/install.git ~/.homebrew
cd ~/.homebrew

```


2. **Editar o script de instalação:**
Abre o ficheiro `install.sh` (podes usar o VS Code com `code .`) e substitui os seguintes URLs:
* **Procurar:** `https://github.com/Homebrew/brew.git`
* **Substituir por:** `git@github.com:Homebrew/brew.git`
* **Procurar:** `https://github.com/Homebrew/homebrew-core.git`
* **Substituir por:** `git@github.com:Homebrew/homebrew-core.git`


3. **Executar o instalador:**
```bash
./install.sh

```



---

## 3. Configurar Variáveis de Ambiente (PATH)

Para que o comando `brew` seja reconhecido pelo terminal, adiciona-o ao teu perfil:

```bash
# Adiciona ao .bashrc
echo 'eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"' >> ~/.bashrc

# Aplica as alterações na sessão atual
eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"

```

---

## 4. Instalar Dependências e GCC

O Homebrew no Linux precisa de ferramentas de compilação para funcionar corretamente:

```bash
# Instalar ferramentas essenciais do Ubuntu
sudo apt-get update
sudo apt-get install build-essential

# Instalar o compilador do Brew
brew install gcc

```

---

## 5. EXTRA: Instalar Kubernetes CLI

Agora que tens um gestor de pacotes funcional, podes instalar ferramentas como o `kubectl` facilmente:

```bash
brew install kubernetes-cli

```

**Parabéns!** O Homebrew está instalado e pronto a usar. 

---


02 fev 2026
José Maria Lebre