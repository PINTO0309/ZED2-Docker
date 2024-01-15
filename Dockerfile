FROM pinto0309/ubuntu22.04-cuda11.8-tensorrt8.5.3:latest

ENV DEBIAN_FRONTEND=noninteractive
ENV TZ=Asia/Tokyo

RUN sudo ln -sf /usr/share/zoneinfo/${TZ} /etc/localtime \
    && sudo sh -c "echo ${TZ} > /etc/timezone"

RUN sudo apt-get update \
    && sudo apt-get install -y --no-install-recommends \
        nano \
        python3-pip \
        python3-mock \
        libpython3-dev \
        libpython3-all-dev \
        python-is-python3 \
        wget \
        curl \
        cmake \
        software-properties-common \
        sudo \
        git \
        build-essential \
        lsb-release \
        less \
        zstd \
        libopencv-dev \
        libgtk2.0-dev \
        pkg-config \
        libavcodec-dev \
        libavformat-dev \
        libswscale-dev \
        libturbojpeg-dev \
    && sudo sed -i 's/# set linenumbers/set linenumbers/g' /etc/nanorc \
    && sudo apt clean \
    && sudo rm -rf /var/lib/apt/lists/*

RUN pip install pip -U \
    && pip install \
        onnx==1.15.0 \
        onnxsim==0.4.33 \
        # TensorRT 8.5.3
        https://github.com/PINTO0309/BoT-SORT-ONNX-TensorRT/releases/download/onnx/onnxruntime_gpu-1.16.1-cp310-cp310-linux_x86_64.whl \
        sit4onnx==1.0.7 \
        opencv-contrib-python==4.9.0.80 \
        numpy==1.24.3 \
        scipy==1.10.1 \
        requests==2.31.0

ARG USERNAME=user
ARG UBUNTU_RELEASE_YEAR=22
ARG CUDA_MAJOR=11
ARG CUDA_MINOR=8
ARG ZED_SDK_MAJOR=4
ARG ZED_SDK_MINOR=0
ARG ZED_SDK_BUILD=8
RUN wget https://s3.ap-northeast-2.wasabisys.com/zed2-sdk/v${ZED_SDK_MAJOR}.${ZED_SDK_MINOR}.${ZED_SDK_BUILD}/ZED_SDK_Ubuntu${UBUNTU_RELEASE_YEAR}_cuda${CUDA_MAJOR}.${CUDA_MINOR}_v${ZED_SDK_MAJOR}.${ZED_SDK_MINOR}.${ZED_SDK_BUILD}.zstd.run \
    && sudo chmod +x ZED_SDK_Ubuntu${UBUNTU_RELEASE_YEAR}_cuda${CUDA_MAJOR}.${CUDA_MINOR}_v${ZED_SDK_MAJOR}.${ZED_SDK_MINOR}.${ZED_SDK_BUILD}.zstd.run  \
    && sudo -u ${USERNAME} ./ZED_SDK_Ubuntu${UBUNTU_RELEASE_YEAR}_cuda${CUDA_MAJOR}.${CUDA_MINOR}_v${ZED_SDK_MAJOR}.${ZED_SDK_MINOR}.${ZED_SDK_BUILD}.zstd.run -- silent runtime_only \
    && rm ZED_SDK_Ubuntu${UBUNTU_RELEASE_YEAR}_cuda${CUDA_MAJOR}.${CUDA_MINOR}_v${ZED_SDK_MAJOR}.${ZED_SDK_MINOR}.${ZED_SDK_BUILD}.zstd.run \
    && sudo apt clean \
    && sudo rm -rf /var/lib/apt/lists/*

RUN echo "sudo chmod 777 /dev/video*" >> ~/.bashrc
