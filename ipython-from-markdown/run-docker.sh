set -e
docker build -t dexy/ipython .
docker run -t -i \
    -v `pwd`:/home/repro/workdir \
    dexy/ipython /bin/bash
