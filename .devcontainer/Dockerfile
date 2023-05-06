FROM ubuntu:23.04

RUN yes | unminimize
RUN apt update && apt install -y \
    sudo \
    man \
    curl \
    git \
    vim

RUN passwd -d ubuntu
USER ubuntu
