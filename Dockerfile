FROM jenkins/jenkins:2.462.2-jdk17

USER root
RUN apt-get update && apt-get install -y lsb-release

# Instalando Node e NPM
RUN curl -fsSL https://deb.nodesource.com/setup_16.x
RUN apt-get install nodejs -y

# Instalando Docker
RUN curl -fsSLo /usr/share/keyrings/docker-archive-keyring.asc \
  https://download.docker.com/linux/debian/gpg
RUN echo "deb [arch=$(dpkg --print-architecture) \
  signed-by=/usr/share/keyrings/docker-archive-keyring.asc] \
  https://download.docker.com/linux/debian \
  $(lsb_release -cs) stable" > /etc/apt/sources.list.d/docker.list

RUN apt-get update && apt-get install -y docker-ce-cli
USER jenkins
RUN jenkins-plugin-cli --plugins "docker-workflow"
