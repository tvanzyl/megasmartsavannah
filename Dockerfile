FROM nvcr.io/nvidia/deepstream:6.4-triton-multiarch

WORKDIR /root

RUN apt-get update && apt-get install -y \
    cmake \
    v4l-utils \
    build-essential \
&& rm -rf /var/lib/apt/lists/*

RUN /opt/nvidia/deepstream/deepstream/user_additional_install.sh

RUN pip3 install --no-cache-dir onnx onnxsim onnxruntime

RUN git clone https://github.com/ultralytics/yolov5

RUN git clone https://github.com/marcoslucianops/DeepStream-Yolo.git

WORKDIR /root/yolov5

RUN pip3 install --no-cache-dir -r requirements.txt

WORKDIR /root/DeepStream-Yolo

RUN CUDA_VER=12 make -C nvdsinfer_custom_impl_Yolo

ENV VIDEO_DEVICE=0

WORKDIR /root

COPY assets/* .

COPY ./entrypoint.sh .

RUN chmod +x entrypoint.sh

CMD ["./entrypoint.sh", "deepstream-app -c deepstream_app_config_fixed.txt"]
