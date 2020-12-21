FROM codercom/code-server:3.7.4

USER root

# update package list and install zshell
RUN apt update && apt upgrade -y

# install zsh
RUN apt install -y zsh 

# install nodejs
RUN curl -sL https://deb.nodesource.com/setup_14.x | bash - && \
    apt install -y nodejs && \
    npm install -g yarn

# install golang
RUN if [ "`curl --version |cut -d ' ' -f 3 |head -1 |cut -d '-' -f 1 |cut -b 2-`" "==" "x86_64" ] ; then export GOFILENAME="go1.15.6.linux-amd64.tar.gz"; else export GOFILENAME="go1.15.6.linux-arm64.tar.gz"; fi && \
    curl -sSL "https://golang.org/dl/${GOFILENAME}" -o "/tmp/${GOFILENAME}" && \
    tar -C /usr/local -xzf "/tmp/${GOFILENAME}" && \
    echo "export PATH=$PATH:/usr/local/go/bin" >> "/etc/bash.bashrc"

# clean cache install
RUN rm -rf /var/lib/apt/lists/* && rm -rf /tmp/*

WORKDIR /home/coder/projects
VOLUME /home/coder/projects

USER coder

# install on my zsh
RUN chsh -s /bin/zsh && sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"


