# docker build -t njsondebian .
# docker run -it -rm njsondebian "node path/to/script arg"

FROM debian:stable

SHELL [ "/bin/bash", "-l", "-c" ]
ENTRYPOINT [ "/bin/bash", "-l", "-c" ]
EXPOSE 8080

RUN apt-get update
RUN apt-get install curl -y
RUN curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.35.3/install.sh | bash
RUN nvm install --lts

CMD [ "bash" ]
