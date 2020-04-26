# docker build -t willbe -f docker/test.debian.dockerfile .
# docker run -it --rm willbe

FROM debian:stable
SHELL [ "/bin/bash", "-l", "-c" ]
EXPOSE 8080
WORKDIR /willbe
ADD . /willbe

RUN apt-get update
RUN apt-get install git -y
RUN apt-get install python3 -y
RUN apt-get install build-essential -y
RUN apt-get install curl -y
RUN curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.35.3/install.sh | bash
RUN nvm install --lts

RUN npm config set user 0
RUN npm config set unsafe-perm true
#RUN npm i -g willbe
#RUN npm i -g wTesting
RUN cd /willbe && npm i

ENTRYPOINT [ "/bin/bash", "-l", "-c" ]
CMD [ "exec", "npm", "test" ]
