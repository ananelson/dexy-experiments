set -e
docker build -t dexy-experiments/ipython-integration .
docker run -t -i \
    -v `pwd`:/home/repro/content \
    -v /home/ana/dev/dexy/:/home/repro/dexy \
    dexy-experiments/ipython-integration /bin/bash
