FROM jenkins/jenkins:2.462.2-jdk17
USER root

# Update and install dependencies
RUN apt-get update && apt-get install -y lsb-release curl gnupg2

# Installing Node and NPM
RUN curl -fsSL https://deb.nodesource.com/setup_16.x | bash -
RUN apt-get install -y nodejs

# Installing Podman
RUN . /etc/os-release && \
    echo "deb https://download.opensuse.org/repositories/devel:/kubic:/libcontainers:/stable/Debian_${VERSION_ID}/ /" | tee /etc/apt/sources.list.d/devel:kubic:libcontainers:stable.list && \
    curl -L "https://download.opensuse.org/repositories/devel:/kubic:/libcontainers:/stable/Debian_${VERSION_ID}/Release.key" | apt-key add -

RUN apt-get update && \
    apt-get install -y podman

# Set up subuid and subgid for rootless mode
RUN usermod --add-subuids 100000-165535 --add-subgids 100000-165535 jenkins

USER jenkins
