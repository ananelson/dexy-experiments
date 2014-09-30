set -e
docker build -t ananelson/dexy-plantuml .
docker run -t -i \
    -v `pwd`:/home/repro/work \
    -v ~/dev/dexy-two:/home/repro/dexy \
    ananelson/dexy-plantuml /bin/bash
