## Emacs, make this -*- mode: sh; -*- COPIED FROM ROCKER R-UBUNTU

FROM ubuntu:bionic

LABEL org.label-schema.license="GPL-2.0" \
      org.label-schema.vcs-url="https://github.com/rocker-org/r-ubuntu" \
      org.label-schema.vendor="Rocker Project" \
      maintainer="Dirk Eddelbuettel <edd@debian.org>"

## Set a default user. Available via runtime flag `--user docker` 
## Add user to 'staff' group, granting them write privileges to /usr/local/lib/R/site.library
## User should also have & own a home directory (for rstudio or linked volumes to work properly). 
RUN useradd docker \
	&& mkdir /home/docker \
	&& chown docker:docker /home/docker \
	&& addgroup docker staff

RUN apt-get update \
	&& apt-get install -y --no-install-recommends \
		software-properties-common \
                dirmngr \
		build-essential \
		libcurl4-gnutls-dev \
		libxml2-dev \
		libssl-dev \
		libgit2-dev \
                ed \
		less \
		locales \
		vim-tiny \
		wget \
		ca-certificates \
		htop \
		screen \
        && add-apt-repository --enable-source --yes "ppa:marutter/rrutter4.0" \
        && add-apt-repository --enable-source --yes "ppa:c2d4u.team/c2d4u4.0+"

## Configure default locale, see https://github.com/rocker-org/rocker/issues/19
RUN echo "en_US.UTF-8 UTF-8" >> /etc/locale.gen \
	&& locale-gen en_US.utf8 \
	&& /usr/sbin/update-locale LANG=en_US.UTF-8

ENV LC_ALL en_US.UTF-8
ENV LANG en_US.UTF-8

## This was not needed before but we need it now
ENV DEBIAN_FRONTEND noninteractive

## Otherwise timedatectl will get called which leads to 'no systemd' inside Docker
ENV TZ UTC

# Now install R and littler, and create a link for littler in /usr/local/bin
# Default CRAN repo is now set by R itself, and littler knows about it too
# r-cran-docopt is not currently in c2d4u so we install from source
RUN apt-get update \
        && apt-get install -y --no-install-recommends \
                 littler \
 		 r-base \
 		 r-base-dev \
 		 r-recommended \
                 r-cran-docopt \
  	&& ln -s /usr/lib/R/site-library/littler/examples/install.r /usr/local/bin/install.r \
 	&& ln -s /usr/lib/R/site-library/littler/examples/install2.r /usr/local/bin/install2.r \
 	&& ln -s /usr/lib/R/site-library/littler/examples/installGithub.r /usr/local/bin/installGithub.r \
 	&& ln -s /usr/lib/R/site-library/littler/examples/testInstalled.r /usr/local/bin/testInstalled.r \
 	&& rm -rf /tmp/downloaded_packages/ /tmp/*.rds \
 	&& rm -rf /var/lib/apt/lists/*

RUN apt-get update \
	&& apt-get install -y --no-install-recommends \
		r-cran-lme4 \
		r-cran-gmp
		
# Install R packages
RUN install.r --error \
    tidyverse \
#    stats \
#    utils \
#    devtools \
#    ggpubr \
    vegan \
#    lme4 \
    pbkrtest \
    DHARMa \
    furrr \
    VGAM \
    gridExtra \
    pracma \
    DoE.base \
    AlgDesign \
#    FactoMineR \
#    rstatix \
#    car \
    factoextra \
    readxl \
    reshape2 \
    data.table \
    dtw \
    optparse \
    proxy \
    pdist

CMD ["bash"]
