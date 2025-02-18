FROM ubuntu:24.04

RUN apt update && apt upgrade -y

RUN apt install -y calibre

RUN echo ttf-mscorefonts-installer msttcorefonts/accepted-mscorefonts-eula select true | debconf-set-selections

RUN apt install -y ttf-mscorefonts-installer

WORKDIR /converter

COPY convert.sh ./

USER ubuntu

ENTRYPOINT ["./convert.sh"]