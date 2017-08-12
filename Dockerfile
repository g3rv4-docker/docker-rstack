FROM ubuntu:14.04
MAINTAINER Gervasio Marchand <gmc@gmc.uy>
ENV build_date 2017-07-22

RUN apt-get update && \
    apt-get install -y build-essential gfortran libreadline-dev zlib1g-dev libbz2-dev liblzma-dev libpcre3-dev libpcre++-dev libcurl4-openssl-dev perl libssl-dev openssl ca-certificates wget pandoc libcairo2-dev libxt-dev gdebi-core && \
    update-ca-certificates

ADD  R-3.4.1.tar.gz /src

RUN cd /src/R-3.4.1 && \
    ./configure --with-x=no --with-cairo=yes --with-libpng=yes --disable-java && \
    make && \
    make install

RUN printf "options(unzip = 'internal')\noptions(bitmapType='cairo')\nSys.setenv(TZ='GMT')\n" > /usr/local/lib/R/etc/Rprofile.site
RUN R -e "install.packages('packrat', repos = \"http://cran.us.r-project.org\")"
RUN R -e "install.packages('devtools', repos = \"http://cran.us.r-project.org\")"
