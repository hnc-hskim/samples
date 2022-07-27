FROM scratch AS packages
COPY release-packages/code-server*.deb /tmp/

FROM ubuntu:20.04

RUN apt-get update && apt-get upgrade -y
RUN DEBIAN_FRONTEND="noninteractive" apt-get install -y \
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

RUN apt update && apt install -y --no-install-recommends software-properties-common
RUN add-apt-repository "deb http://archive.ubuntu.com/ubuntu bionic main restricted universe multiverse"
RUN add-apt-repository "deb http://archive.ubuntu.com/ubuntu bionic-security main restricted universe multiverse"
RUN add-apt-repository "deb http://archive.ubuntu.com/ubuntu bionic-updates main restricted universe multiverse" 
RUN apt-get update && apt-get upgrade -y

RUN apt-get install -y --no-install-recommends python-lzma
RUN apt-get install -y --no-install-recommends python-sqlitecachec
RUN apt-get install -y --no-install-recommends python-pycurl
RUN apt-get install -y --no-install-recommends python-urlgrabber
RUN apt-get install -y --no-install-recommends yum

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


RUN CODE_SERVER_VERSION=3.11.0 && \
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
ADD warehouse/tools.sh /usr/local/bin/tools.sh
ADD warehouse/startup.sh /startup.sh


RUN chmod a+x /usr/local/bin/*

ENTRYPOINT ["/bin/bash", "/startup.sh"]