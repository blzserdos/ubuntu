FROM ubuntu:latest

LABEL org.opencontainers.image.source https://github.com/MaastrichtU-IDS/ubuntu

RUN apt-get update -y && \
    apt-get upgrade -y

RUN apt-get install curl wget git gfortran build-essential ca-certificates python3 python3-pip libblas-dev liblapack-dev -y
