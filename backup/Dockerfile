FROM ubuntu:20.04

ENV DEBIAN_FRONTEND noninteractive


# RUN apt-get update && apt-get install -y --no-install-recommends \ 
#     apt-utils \
#     && rm -rf /var/lib/apt/lists/*

RUN apt-get update && apt-get upgrade -y

RUN DEBIAN_FRONTEND="noninteractive" apt-get install -y --no-install-recommends \ 
    wget \
    vim \ 
    curl \
    dumb-init \
    zsh \
    htop \
    locales \
    man \
    nano \
    git \
    procps \
    openssh-client \
    sudo \
    jq \
    openssl \
    bash-completion \
    dnsutils \
    lsb-release  

RUN apt-get install -y --no-install-recommends \
    ca-certificates \
    curl \
    gnupg \
    lsb-release

RUN mkdir -p /etc/apt/keyrings && \
    curl -fsSL https://download.docker.com/linux/ubuntu/gpg | gpg --dearmor -o /etc/apt/keyrings/docker.gpg

RUN echo \
  "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.gpg] https://download.docker.com/linux/ubuntu \
  $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null

RUN apt update && apt install -y --no-install-recommends software-properties-common
RUN sudo add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu focal stable"

RUN apt-get update && \
    apt-get install docker-ce docker-ce-cli containerd.io docker-compose-plugin -y --no-install-recommends



RUN curl -L "https://github.com/docker/compose/releases/download/1.29.2/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose

RUN chmod +x /usr/local/bin/docker-compose




RUN apt-get install -y python3 python3-pip python3-dev build-essential

RUN update-alternatives --install /usr/bin/python python /usr/bin/python3 1
RUN update-alternatives --install /usr/bin/pip pip /usr/bin/pip3 1

RUN apt-get install -y apt-utils locales
RUN locale-gen ko_KR.UTF-8
ENV LC_ALL ko_KR.UTF-8


RUN addgroup --gid 1000 code && \
    adduser --uid 1000 --ingroup code --home /home/code --shell /bin/bash --disabled-password --gecos "" code && \
    adduser code sudo
RUN chmod g+rw /home && \
    mkdir -p /home/code/workspace && \
    chown code:code /home/code/workspace -R


RUN echo '%sudo ALL=(ALL) NOPASSWD:ALL' >> /etc/sudoers;


RUN USER=code && \
    GROUP=code
RUN curl -SsL https://github.com/boxboat/fixuid/releases/download/v0.5/fixuid-0.5-linux-amd64.tar.gz | tar -C /usr/local/bin -xzf - && \
    chown root:root /usr/local/bin/fixuid && \
    chmod 4755 /usr/local/bin/fixuid && \
    mkdir -p /etc/fixuid && \
    printf "user: $USER\ngroup: $GROUP\n" > /etc/fixuid/config.yml

RUN usermod -aG docker code

RUN sudo /etc/init.d/docker start 


RUN CODE_SERVER_VERSION=4.5.1 && \
    curl -sSOL https://github.com/cdr/code-server/releases/download/v${CODE_SERVER_VERSION}/code-server_${CODE_SERVER_VERSION}_amd64.deb && \
    sudo dpkg -i code-server_${CODE_SERVER_VERSION}_amd64.deb


RUN cat /usr/lib/code-server/lib/vscode/product.json \
    | jq '.extensionAllowedProposedApi[.extensionAllowedProposedApi | length] |= . + "ms-vsliveshare.vsliveshare" \
    | .extensionAllowedProposedApi[.extensionAllowedProposedApi | length] |= . + "ms-vscode.node-debug" \
    | .extensionAllowedProposedApi[.extensionAllowedProposedApi | length] |= . + "ms-vscode.node-debug2"' \
    > /usr/lib/code-server/lib/vscode/product.json_ \
    && mv /usr/lib/code-server/lib/vscode/product.json_ /usr/lib/code-server/lib/vscode/product.json


RUN mkdir /opt/default_home
ADD warehouse/.bashrc /opt/default_home


ENV PASSWORD=${PASSWORD:-password}
EXPOSE 8080

ADD warehouse/restart-codekube.sh /usr/local/bin/restart-codekube
ADD warehouse/code.sh /usr/local/bin/code
ADD warehouse/startup.sh /startup.sh


RUN chmod a+x /usr/local/bin/*

ENTRYPOINT ["/bin/bash", "/startup.sh"]