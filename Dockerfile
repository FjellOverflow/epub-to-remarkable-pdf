FROM lscr.io/linuxserver/calibre:latest

RUN apt update && apt upgrade -y

RUN apt install -y ttf-mscorefonts-installer

WORKDIR /converter

COPY convert.sh ./

ENTRYPOINT ["./convert.sh"]