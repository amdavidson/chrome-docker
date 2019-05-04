# Chrome (in Docker)

A Docker container to run chrome quickly on systems that do not have it installed. Adapted/modified from the original by @jessfraz

## Usage

    docker run -it --rm --net host \
        --memory 512mb \
        --cpuset-cpus 0 \
        --security-opt seccomp=$PWD/chrome.json \
        -v /tmp/.X11-unix:/tmp/.X11-unix \
        -e DISPLAY=unix$DISPLAY \
        --device /dev/dri \
        --device /dev/snd \
        -v /dev/shm:/dev/shm \
        -v $HOME/downloads:/home/chrome/Downloads \
        -v chromedata:/data \
        --name chrome \
        amdavidson/chrome-docker
