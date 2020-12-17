FROM codercom/code-server:3.7.4

USER root

# update package list
RUN sudo apt update && sudo apt upgrade -y

# install nodejs
RUN curl -sL https://deb.nodesource.com/setup_14.x | sudo bash - && \
    sudo apt install -y nodejs && \
    sudo npm install -g yarn

# install golang
RUN if [ "`curl --version |cut -d ' ' -f 3 |head -1 |cut -d '-' -f 1 |cut -b 2-`" "==" "x86_64" ] ; then export GOFILENAME="go1.15.6.linux-amd64.tar.gz"; else export GOFILENAME="go1.15.6.linux-arm64.tar.gz"; fi && \
    sudo curl -sSL "https://golang.org/dl/${GOFILENAME}" -o "/tmp/${GOFILENAME}" && \
    sudo tar -C /usr/local -xzf "/tmp/${GOFILENAME}" && \
    sudo echo "export PATH=$PATH:/usr/local/go/bin" >> "/etc/bash.bashrc"

# clean cache install
RUN sudo rm -rf /var/lib/apt/lists/* && sudo rm -rf /tmp/*

WORKDIR /home/coder/projects
VOLUME /home/coder/projects

# USER coder
