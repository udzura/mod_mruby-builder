FROM ubuntu:trusty
MAINTAINER Uchio KONDO <udzura@udzura.jp>

ENV DEBIAN_FRONTEND noninteractive
RUN apt-get -y update
RUN apt-get install \
    sudo git curl bison \
    apache2 apache2-dev apache2-utils \
    ruby2.0 ruby2.0-dev rake \
    libcurl4-openssl-dev libhiredis-dev libmarkdown2-dev libcap-dev libcgroup-dev

RUN cd /usr/local/src/ && git clone https://github.com/matsumoto-r/mod_mruby.git

ADD run-all.sh /usr/local/bin/run-all.sh
RUN chmod a+x /usr/local/bin/run-all.sh

CMD ["/usr/local/bin/run-all.sh"]
