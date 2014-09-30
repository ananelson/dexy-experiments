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
RUN apt-get install ack-grep strace vim git tree wget unzip rsync man-db

### "fake-fuse-for-openjdk"
RUN apt-get install fuse || :
RUN rm -rf /var/lib/dpkg/info/fuse.postinst
RUN apt-get install fuse

### "update"
RUN apt-get update

### "install-jdk"
RUN apt-get install openjdk-7-jdk

### "graphviz"
RUN apt-get install graphviz

### "python-pip"
RUN apt-get install python
RUN apt-get install python-dev
RUN apt-get install python-pip

### "dexy"
RUN pip install dexy

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
RUN echo "repro ALL=(ALL) NOPASSWD:ALL" > /etc/sudoers.d/repro

### "activate-user"
ENV HOME /home/repro
USER repro
WORKDIR /home/repro
