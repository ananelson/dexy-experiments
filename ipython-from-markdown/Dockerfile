FROM                    phusion/baseimage
MAINTAINER              Ana Nelson <ana@ananelson.com>

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
RUN apt-get install ack-grep strace vim git tree wget unzip rsync man-db

### "python"
RUN apt-get install python-dev
RUN apt-get install python-pip

### "dexy"
RUN pip install dexy

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

### "ipython"
RUN pip install ipython
RUN pip install tornado

### "pandoc"
RUN apt-get install pandoc

### "texlive"
RUN apt-get install texlive-latex-base
RUN apt-get install texlive-latex-extra
RUN apt-get install texlive-fonts-recommended

### "source-dexy"
WORKDIR /tmp
RUN git clone https://github.com/dexy/dexy
WORKDIR /tmp/dexy
RUN pip install -e .
WORKDIR /

### "create-user"
RUN useradd -m repro
RUN echo "repro:foobarbaz" | chpasswd
RUN adduser repro sudo
RUN echo "repro ALL=(ALL) NOPASSWD:ALL" > /etc/sudoers.d/zrepro

### "activate-user"
ENV HOME /home/repro
USER repro
WORKDIR /home/repro
