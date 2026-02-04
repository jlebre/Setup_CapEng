# Install brew
Não dá para fazer clone de um repositório do github normalmente com https, porque dá erro (60) ssl certificate.

Então lembrei-me que podia funcionar com ssh.
Este pequeno tutorial de como instalar brew e outras coisas no Ubuntu 


No terminal corre

```
ssh-keygen
```
Não é preciso preencher, carregam Enter até ao fim

Vão ao github e nos settings, adicionam uma ssh key
Copiar a chave .pub e colam no github
```
cat ~/.ssh/id_ed25519.pub
```

E agora sim clonar

```
git clone git@github.com:Homebrew/install.git ~/.homebrew
cd ~/.homebrew
code .
```

Abrir o ficheiro install.sh e alterar para usar o ssh em vez de https
guardar e correr

Substituir
https://github.com/Homebrew/brew.git
por
git@github.com:Homebrew/brew.git

e 

https://github.com/Homebrew/homebrew-core.git
por
git@github.com:Homebrew/homebrew-core.git

```
./install.sh
```

Depois de ter o brew instalado tem de se adicionar ao PATH

```
echo $USER
```
confirmem se está certo

```
echo >> /home/$USER/.bashrc
echo 'eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv bash)"' >> /home/$USER/.bashrc
eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv bash)
```

Se não funcionar, têm de editar o ficheiro e mudar $USER pelo vosso user


Instalar dependências
```
sudo apt-get install build-essential
```

```
brew install gcc
```


Parabéns instalaram o brew e têm um package manager

/////////////////////////////////

Para kubernetes

```
brew install kubernetes-cli
```
