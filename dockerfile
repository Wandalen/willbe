FROM ubuntu:18.04

# Replace shell with bash so we can source files
RUN rm /bin/sh && \
	ln -s /bin/bash /bin/sh && \
	mkdir -p /root/.nvm

# Install dependencies from Ubuntu
ENV NVM_DIR /root/.nvm
ENV NODE_VERSION 10.15.3

RUN apt-get update --fix-missing && \
	apt-get install -y curl git devscripts software-properties-common && \
	# Install: nvm, node and npm
	curl -o- https://raw.githubusercontent.com/creationix/nvm/v0.34.0/install.sh | bash && \
	source $NVM_DIR/nvm.sh && \
	nvm install $NODE_VERSION

ENV PATH $NVM_DIR/versions/node/v$NODE_VERSION/bin:$PATH

ADD . /app

RUN add-apt-repository "deb http://mirrors.kernel.org/ubuntu/ trusty main"
CMD node /app/sample/packageInstall.js