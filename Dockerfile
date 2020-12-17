FROM codercom/code-server:3.7.4

# update package list
RUN sudo apt update && sudo apt upgrade -y

# install nodejs
RUN curl -sL https://deb.nodesource.com/setup_14.x | sudo bash - && \
    sudo apt install -y nodejs && \
    sudo npm install -g yarn

# install golang
RUN if [ $(uname -m) == "x86_64" ] ; then ARCH=amd64; else ARCH=arm64; fi && \
    GOPKG="go1.15.6.linux-${ARCH}.tar.gz" && \
    sudo curl -sSL "https://golang.org/dl/${GOPKG}" -o "/tmp/${GOPKG}" && \
    sudo tar -C /usr/local -xzf "/tmp/${GOPKG}" && \
    sudo echo "export PATH=$PATH:/usr/local/go/bin" >> "/etc/bash.bashrc"

# clean cache install
RUN sudo rm -rf /var/lib/apt/lists/* && sudo rm -rf /tmp/*

VOLUME /home/coder/projects

