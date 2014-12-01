set -e
IMAGE_NAME="dexy_experiments/lyx"
docker build -t "$IMAGE_NAME" .
docker run -t -i \
    -v `pwd`:/home/repro/work \
    -v /home/ana/dev/dexy-two:/home/repro/dexy \
    "$IMAGE_NAME" /bin/bash
