# ZED2-Docker
ZED2 SDK Installed Containers

- docker build
    ```bash
    docker build -t pinto0309/zed2-4.0.8-runtime-cuda11.8-ubuntu22.04 .
    ```

- docker pull
    ```bash
    docker pull pinto0309/zed2-4.0.8-runtime-cuda11.8-ubuntu22.04
    ```

- docker run
    ```bash
    xhost +local: \
    && docker run --rm -it --gpus all \
    --net host \
    --ipc host \
    -v `pwd`:/workdir \
    -e XDG_RUNTIME_DIR=$XDG_RUNTIME_DIR \
    -e DISPLAY=$DISPLAY \
    -v /tmp/.X11-unix/:/tmp/.X11-unix:rw \
    --device /dev/video0:/dev/video0:mwr \
    --device /dev/video1:/dev/video1:mwr \
    --privileged \
    pinto0309/zed2-4.0.8-runtime-cuda11.8-ubuntu22.04
    ```

- opencv test

    ```
    git clone https://github.com/stereolabs/zed-opencv.git && cd zed-opencv
    git checkout f401af3ff31758bb75a4e0c67de0fe72f348a697
    cd python

    python zed-opencv.py
    ```
    ![image](https://github.com/PINTO0309/ZED2-Docker/assets/33194443/5d1cff6a-f0a1-48c7-943d-786bf3a76733)
