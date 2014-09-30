set -e
docker build -t ananelson/dexy-plantuml .
docker run -t -i \
    -v `pwd`:/home/repro/work \
    ananelson/dexy-plantuml /bin/bash
