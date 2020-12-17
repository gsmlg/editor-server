FROM Codercom/code-server:3.7.4

# update package list
RUN apt update && apt upgrade -y && \
    ARCH="$(dpkg --print-architecture)"

# install nodejs
RUN curl -sL https://deb.nodesource.com/setup_14.x | bash - \
    apt install -y nodejs && \
    npm install -g yarn

# install golang
RUN GOPKG="go1.15.6.linux-${ARCH}.tar.gz" && \
    curl -sSL "https://golang.org/dl/${GOPKG}" -o "/tmp/${GOPKG}" && \
    tar -C /usr/local -xzf "/tmp/${GOPKG}" && \
    echo "export PATH=$PATH:/usr/local/go/bin" >> "/etc/bash.bashrc"

# clean cache install
RUN rm -rf /var/lib/apt/lists/*


