FROM zeyanlin/r-ver:latest

USER root
# init
ENV TIME_ZONE="Asia/Taipei"
# timezone
RUN echo $TIME_ZONE > /etc/timezone
RUN dpkg-reconfigure --frontend noninteractive tzdata
# 上面內容功能是先將時區名稱加至/etc/timezone檔案
# 再執行dpkg-reconfigure設定時區
# 如此一來預設值就在台灣的時區
# 不用再手動變更
LABEL org.label-schema.license="GPL-2.0"

ARG RSTUDIO_VERSION
ARG PANDOC_TEMPLATES_VERSION 
ENV PANDOC_TEMPLATES_VERSION=${PANDOC_TEMPLATES_VERSION:-1.18} \
PATH=/usr/lib/rstudio-server/bin:$PATH
## Work-around to make Docker Hub use the Dockerfile 
## from https://github.com/linzeyan/rstudio
MAINTAINER Lin ZeYan

## Download and install RStudio server & dependencies
## Attempts to get detect latest version, otherwise falls back to version given in $VER
## Symlink pandoc, pandoc-citeproc so they are available system-wide
RUN apt-get update \
  && apt-get install -y --no-install-recommends \
    file \
    git \
    libapparmor1 \
    libcurl4-openssl-dev \
    libedit2 \
    libssl-dev \
    lsb-release \
    psmisc \
    python-setuptools \
    sudo \
    wget \
  && wget -O libssl1.0.0.deb http://ftp.debian.org/debian/pool/main/o/openssl/libssl1.0.0_1.0.1t-1+deb8u6_amd64.deb \
  && dpkg -i libssl1.0.0.deb \
  && rm libssl1.0.0.deb \
  && RSTUDIO_LATEST=$(wget --no-check-certificate -qO- https://s3.amazonaws.com/rstudio-server/current.ver) \
  && [ -z "$RSTUDIO_VERSION" ] && RSTUDIO_VERSION=$RSTUDIO_LATEST || true \
  && wget -q http://download2.rstudio.org/rstudio-server-${RSTUDIO_VERSION}-amd64.deb \
  && dpkg -i rstudio-server-${RSTUDIO_VERSION}-amd64.deb \
  && rm rstudio-server-*-amd64.deb \
  ## Symlink pandoc & standard pandoc templates for use system-wide
  && ln -s /usr/lib/rstudio-server/bin/pandoc/pandoc /usr/local/bin \
  && ln -s /usr/lib/rstudio-server/bin/pandoc/pandoc-citeproc /usr/local/bin \
  && wget https://github.com/jgm/pandoc-templates/archive/${PANDOC_TEMPLATES_VERSION}.tar.gz \
  && mkdir -p /opt/pandoc/templates && tar zxf ${PANDOC_TEMPLATES_VERSION}.tar.gz \
  && cp -r pandoc-templates*/* /opt/pandoc/templates && rm -rf pandoc-templates* \
  && mkdir /root/.pandoc && ln -s /opt/pandoc/templates /root/.pandoc/templates \
  && rm ${PANDOC_TEMPLATES_VERSION}.tar.gz \
  && apt-get clean \
  && rm -rf /var/lib/apt/lists/ \
  ## RStudio wants an /etc/R, will populate from $R_HOME/etc
  && mkdir -p /etc/R \
  ## Write config files in $R_HOME/etc
  && echo '\n\
    \n# Configure httr to perform out-of-band authentication if HTTR_LOCALHOST \
    \n# is not set since a redirect to localhost may not work depending upon \
    \n# where this Docker container is running. \
    \nif(is.na(Sys.getenv("HTTR_LOCALHOST", unset=NA))) { \
    \n  options(httr_oob_default = TRUE) \
    \n}' >> /usr/local/lib/R/etc/Rprofile.site \
  && echo "PATH=\"${PATH}\"" >> /usr/local/lib/R/etc/Renviron \
  ## Need to configure non-root user for RStudio
  && useradd rstudio \
  && echo "rstudio:rstudio" | chpasswd \
	&& mkdir /home/rstudio \
	&& chown rstudio:rstudio /home/rstudio \
	&& addgroup rstudio staff \
  ## Prevent rstudio from deciding to use /usr/bin/R if a user apt-get installs a package
  &&  echo 'rsession-which-r=/usr/local/bin/R' >> /etc/rstudio/rserver.conf \ 
  ## configure git not to request password each time 
  && git config --system credential.helper 'cache --timeout=3600' \
  && git config --system push.default simple
# Install some packages
# Rscript -e "install.packages(c('methods', 'Rcpp', 'RJSONIO'), dependencies=TRUE, repos='http://cran.rstudio.com/')" 
RUN R -e "install.packages('methods', dependencies=TRUE, repos='http://cran.csie.ntu.edu.tw/')" \
  && R -e "install.packages('Rcpp', dependencies=TRUE, repos='http://cran.csie.ntu.edu.tw/')" \
  && R -e "install.packages('RJSONIO', dependencies=TRUE, repos='http://cran.csie.ntu.edu.tw/')" \
  && R -e "install.packages('digest', dependencies=TRUE, repos='http://cran.csie.ntu.edu.tw/')" \
  && R -e "install.packages('functional', dependencies=TRUE, repos='http://cran.csie.ntu.edu.tw/')" \
  && R -e "install.packages('reshape2', dependencies=TRUE, repos='http://cran.csie.ntu.edu.tw/')" \
  && R -e "install.packages('stringr', dependencies=TRUE, repos='http://cran.csie.ntu.edu.tw/')" \
  && R -e "install.packages('zoo', dependencies=TRUE, repos='http://cran.csie.ntu.edu.tw/')" \
  && R -e "install.packages('caTools', dependencies=TRUE, repos='http://cran.csie.ntu.edu.tw/')" \
  && R -e "install.packages('quickcheck', dependencies=TRUE, repos='http://cran.csie.ntu.edu.tw/')" \
  && R -e "install.packages('testthat', dependencies=TRUE, repos='http://cran.csie.ntu.edu.tw/')" \
  && R -e "install.packages('shiny', dependencies=TRUE, repos='http://cran.csie.ntu.edu.tw/')" \
  && R -e "install.packages('colorspace', dependencies=TRUE, repos='http://cran.csie.ntu.edu.tw/')" \
  && R -e "install.packages('RColorBrewer', dependencies=TRUE, repos='http://cran.csie.ntu.edu.tw/')" \
  && R -e "install.packages('ggplot2', dependencies=TRUE, repos='http://cran.csie.ntu.edu.tw/')" \
  && R -e "install.packages('devtools', dependencies=TRUE, repos='http://cran.csie.ntu.edu.tw/')" \
  && R -e "install.packages('plyr', dependencies=TRUE, repos='http://cran.csie.ntu.edu.tw/')" \
  && R -e "install.packages('dplyr', dependencies=TRUE, repos='http://cran.csie.ntu.edu.tw/')" \
  && R -e "install.packages('lubridate', dependencies=TRUE, repos='http://cran.csie.ntu.edu.tw/')" \
  && R -e "install.packages('knitr', dependencies=TRUE, repos='http://cran.csie.ntu.edu.tw/')" \
  && R -e "install.packages('Deducer', dependencies=TRUE, repos='http://cran.csie.ntu.edu.tw/')" \
  && R -e "install.packages('scales', dependencies=TRUE, repos='http://cran.csie.ntu.edu.tw/')" \
  && R -e "install.packages('labeling', dependencies=TRUE, repos='http://cran.csie.ntu.edu.tw/')" \
  && R -e "install.packages('data.table', dependencies=TRUE, repos='http://cran.csie.ntu.edu.tw/')" \
  && R -e "install.packages('rvest', dependencies=TRUE, repos='http://cran.csie.ntu.edu.tw/')" \
  && R -e "install.packages('magrittr', dependencies=TRUE, repos='http://cran.csie.ntu.edu.tw/')" \
  && R -e "install.packages('tidyr', dependencies=TRUE, repos='http://cran.csie.ntu.edu.tw/')" \
  && R -e "install.packages('broom', dependencies=TRUE, repos='http://cran.csie.ntu.edu.tw/')" \
  && R -e "install.packages('lattice', dependencies=TRUE, repos='http://cran.csie.ntu.edu.tw/')"
  
  ## Set up S6 init system
RUN wget -P /tmp/ https://github.com/just-containers/s6-overlay/releases/download/v1.11.0.1/s6-overlay-amd64.tar.gz \
  && tar xzf /tmp/s6-overlay-amd64.tar.gz -C / \
  && mkdir -p /etc/services.d/rstudio \
  && echo '#!/bin/bash \
           \n exec /usr/lib/rstudio-server/bin/rserver --server-daemonize 0' \
           > /etc/services.d/rstudio/run \
   && echo '#!/bin/bash \
           \n rstudio-server stop' \
           > /etc/services.d/rstudio/finish
	   
COPY userconf.sh /etc/cont-init.d/userconf

## running with "-e ADD=shiny" adds shiny server
COPY add_shiny.sh /etc/cont-init.d/add

EXPOSE 8787

## automatically link a shared volume for kitematic users
VOLUME /home/rstudio/kitematic

CMD ["/init"]
