FROM ubuntu:latest

LABEL org.opencontainers.image.source https://github.com/MaastrichtU-IDS/ubuntu

RUN apt-get update -y && \
    apt-get upgrade -y
