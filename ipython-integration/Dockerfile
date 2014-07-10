FROM                    phusion/baseimage
MAINTAINER              Ana Nelson <ana@ananelson.com>

### "localedef"
RUN localedef -v -c -i en_US -f UTF-8 en_US.UTF-8 || :

### "squid-deb-proxy"
# Use squid deb proxy (if available on host OS) as per https://gist.github.com/dergachev/8441335
# Modified by @ananelson to detect squid on host OS and only enable itself if found.
ENV HOST_IP_FILE /tmp/host-ip.txt
RUN /sbin/ip route | awk '/default/ { print "http://"$3":8000" }' > $HOST_IP_FILE
RUN HOST_IP=`cat $HOST_IP_FILE` && curl -s $HOST_IP | grep squid && echo "found squid" && echo "Acquire::http::Proxy \"$HOST_IP\";" > /etc/apt/apt.conf.d/30proxy || echo "no squid"

### "apt-defaults"
RUN echo "APT::Get::Assume-Yes true;" >> /etc/apt/apt.conf.d/80custom
RUN echo "APT::Get::Quiet true;" >> /etc/apt/apt.conf.d/80custom

### "update"
RUN apt-get update

### "utils"
RUN apt-get install build-essential
RUN apt-get install adduser sudo
RUN apt-get install curl

### "nice-things"
RUN apt-get install ack-grep strace vim git tree wget unzip rsync

### "texlive"
#RUN apt-get install --no-install-recommends texlive-latex-base
#RUN apt-get install --no-install-recommends texlive-latex-extra


### "python"
RUN apt-get install python-dev
RUN apt-get install python-pip
RUN pip install ipython
RUN pip install dexy

### "install-phantomjs"
ENV PHANTOM_VERSION phantomjs-1.9.7-linux-x86_64
WORKDIR /tmp
RUN wget --no-verbose https://bitbucket.org/ariya/phantomjs/downloads/$PHANTOM_VERSION.tar.bz2
RUN tar -xjf $PHANTOM_VERSION.tar.bz2
RUN mv $PHANTOM_VERSION/bin/phantomjs /usr/local/bin/

### "install-casperjs"
# FIXME where to install this?
WORKDIR /tmp
RUN git clone git://github.com/n1k0/casperjs.git
WORKDIR /tmp/casperjs
RUN ln -sf `pwd`/bin/casperjs /usr/local/bin/casperjs

### "zeromq"
WORKDIR /tmp
ENV ZEROMQ_VERSION zeromq-4.0.4
RUN wget --no-verbose http://download.zeromq.org/$ZEROMQ_VERSION.tar.gz
RUN tar -xzf $ZEROMQ_VERSION.tar.gz
RUN mv $ZEROMQ_VERSION zeromq
WORKDIR /tmp/zeromq
RUN ./configure
RUN make
RUN make install
RUN ldconfig
RUN pip install pyzmq

RUN apt-get install python-tornado
RUN apt-get install libfreetype6-dev libfontconfig1-dev

### "create-user"
RUN useradd -m repro
RUN echo "repro:foobarbaz" | chpasswd
RUN adduser repro sudo

### "activate-user"
ENV HOME /home/repro
USER repro
WORKDIR /home/repro
