#TODO: ao invés de instalar todas as dependências que vamos precisar nas pipelines (Node, NPM, etc) tentar fazer funcionar
rodar containers Podman (ou Docker caso for mais viável) dentro do nosso Jenkins. A primeiro momento instalar as dependências
manualmente por esse Dockerfile do nosso Jenkins é relativamente mais fácil.

FROM jenkins/jenkins:2.462.2-jdk17
USER root

# Atualizando dependências  
RUN apt-get update && apt-get install -y lsb-release curl gnupg2

# Instalando Node e NPM 
RUN curl -fsSL https://deb.nodesource.com/setup_16.x | bash -
RUN apt-get install -y nodejs

# Instalando Podman
RUN . /etc/os-release && \
    echo "deb https://download.opensuse.org/repositories/devel:/kubic:/libcontainers:/stable/Debian_${VERSION_ID}/ /" | tee /etc/apt/sources.list.d/devel:kubic:libcontainers:stable.list && \
    curl -L "https://download.opensuse.org/repositories/devel:/kubic:/libcontainers:/stable/Debian_${VERSION_ID}/Release.key" | apt-key add -

RUN apt-get update && \
    apt-get install -y podman

# Instalando sudo 
RUN apt-get update && apt-get install -y sudo

# Dando permissões sudo para o usuário do Jenkins (necessário a primeiro momento para rodar a CLI do FOSSA) 
RUN echo "jenkins ALL=(ALL) NOPASSWD: ALL" >> /etc/sudoers

# Setando subuid e subgid para o modo rotless do Podman
RUN usermod --add-subuids 100000-165535 --add-subgids 100000-165535 jenkins

USER jenkins
