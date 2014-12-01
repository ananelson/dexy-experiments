FROM                    ubuntu:latest
MAINTAINER              Ana Nelson <ana@ananelson.com>

### "localedef"
RUN locale-gen en_US.UTF-8

### "apt-defaults"
RUN echo "APT::Get::Assume-Yes true;" >> /etc/apt/apt.conf.d/80custom ; \
    echo "APT::Get::Quiet true;" >> /etc/apt/apt.conf.d/80custom ; \
    apt-get update ; \
    apt-get install curl

### "squid-deb-proxy"
# Use squid deb proxy only if found on host OS. From https://gist.github.com/dergachev/8441335
# Need curl installed before 
RUN HOST_IP_FILE="/tmp/host-ip.txt" ; \
    /sbin/ip route | awk '/default/ { print "http://"$3":8000" }' > $HOST_IP_FILE ; \
    HOST_IP=`cat $HOST_IP_FILE` && curl -s $HOST_IP | grep squid && echo "found squid" && \
    echo "Acquire::http::Proxy \"$HOST_IP\";" > /etc/apt/apt.conf.d/30proxy || echo "no squid"

### "utils"
RUN apt-get install \
      build-essential \
      adduser \
      sudo

### "python"
RUN apt-get install \
      python \
      python-dev \
      python-pip

### "lyx"
RUN apt-get install lyx

### "python"
RUN pip install pynliner; \
    pip install dexy;

RUN apt-get install tex4ht

RUN apt-get install vim

### "create-user"
RUN useradd -m repro && \
    echo "repro:password" | chpasswd ; \
    echo "repro ALL=(ALL) NOPASSWD:ALL" > /etc/sudoers.d/repro

### "activate-user"
ENV HOME /home/repro
USER repro
WORKDIR /home/repro
