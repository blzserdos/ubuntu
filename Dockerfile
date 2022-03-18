FROM ubuntu:latest

LABEL org.opencontainers.image.source https://github.com/MaastrichtU-IDS/ubuntu

RUN apt-get update -y && \
    apt-get upgrade -y

ARG DEBIAN_FRONTEND=noninteractive
ENV TZ=Europe/Amsterdam
RUN apt-get install -y tzdata

RUN apt-get install curl wget git gfortran build-essential ca-certificates python3 python3-pip libblas-dev liblapack-dev screen htop r-base -y

Rscript -e "install.packages(c("tidyverse","ggpubr","vegan","DHARMa","furrr","VGAM","gridExtra","pracma","DoE.base","AlgDesign","factoextra","readxl", "stringr", "reshape2","lme4","data.table","dtw","optparse","pdist","proxy"))"
