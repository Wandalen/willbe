# docker build -t willbe.test -f docker/test.debian.dockerfile .
# docker run -it --rm willbe.test

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

RUN echo ${PATH}
RUN which node
RUN which npm

RUN npm config set user 0
RUN npm config set unsafe-perm true
#RUN npm i -g willbe@alpha
#RUN npm i -g wTesting@alpha
RUN cd /willbe && npm i

ENTRYPOINT [ "/bin/bash", "-lic" ]
CMD [ "npm run test" ]
