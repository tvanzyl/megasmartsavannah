# Mega Smart Savannah

## Quickstart

### Video device
`ls /dev/video*`

Replace below with device number for /dev/video? and VIDEO_DEVICE=?.

It is probably zero if you are running this on your orin nano but if you are attaching to your desktop it might be others.

### X6_64
`$ sudo docker run --name megasmart --device /dev/video0 --runtime=nvidia -it --network=host --privileged -v /tmp/.X11-unix:/tmp/.X11-unix -e DISPLAY=$DISPLAY -e VIDEO_DEVICE=0 -w /root --rm tvanzyl/megasmartsavannah:x86_64`

### Orin
`$ sudo docker run --name megasmart --device /dev/video0 --runtime=nvidia -it --network=host --privileged -v /tmp/.X11-unix:/tmp/.X11-unix -e DISPLAY=$DISPLAY -e VIDEO_DEVICE=0 -w /root --rm tvanzyl/megasmartsavannah:aarch64`

### Command Line
You should not need to do this but if you would like to get hold of the command line then run

`$ sudo docker run --name megasmart --device /dev/video0 --runtime=nvidia -it --network=host --privileged -v /tmp/.X11-unix:/tmp/.X11-unix -e DISPLAY=$DISPLAY -e VIDEO_DEVICE=0 -w /root --rm tvanzyl/megasmartsavannah:x86_64 /bin/sh`

`$ deepstream-app -c deepstream_app_config.txt`

## Resources 

- https://github.com/microsoft/CameraTraps/tree/main
---
- https://docs.ultralytics.com/yolov5/tutorials/running_on_jetson_nano/#install-pytorch-and-torchvision
---
- https://developer.nvidia.com/embedded/jetpack
---
- [J] https://catalog.ngc.nvidia.com/orgs/nvidia/collections/deepstream_sdk
- [A] https://docs.nvidia.com/metropolis/deepstream/dev-guide/text/DS_Quickstart.html#
- [B] https://catalog.ngc.nvidia.com/orgs/nvidia/containers/deepstream
- [C] https://docs.nvidia.com/metropolis/deepstream/dev-guide/text/DS_ref_app_deepstream.html
- [D] https://docs.nvidia.com/metropolis/deepstream/dev-guide/text/DS_plugin_gst-nvinfer.html
- https://docs.nvidia.com/metropolis/deepstream/dev-guide/text/DS_ref_app_github.html
---
- [E] https://github.com/NVIDIA/TensorRT
- [F] https://docs.nvidia.com/deeplearning/tensorrt/quick-start-guide/index.html
- [G] https://docs.nvidia.com/deeplearning/tensorrt/developer-guide/index.html#trtexec-flags
---
- [H] https://github.com/marcoslucianops/DeepStream-Yolo/tree/master
- [I] https://github.com/marcoslucianops/DeepStream-Yolo/blob/master/docs/YOLOv5.md

## Workflow

We use Jetpack 6.0 [J] and the deepstream:6.4-triton-multiarch [B] docker image

To create onnx file from your yolov5 checkpoint please follow [I]
- MDV5A.onnx should work fine

Install TensorRT 8.6.1 on host [A] and [E]

Convert ONNX to .engine using trtexec [F] and setting in [G] this has to be done for each hardware platform
- `trtexec --fp16 --optShapes --onnx=MDV5A.onnx --saveEngine=model_b1_gpu0_fp16.engine`

Build the docker image
- `$make build` 

Push the image to doker hub
- `$make push`

## Configuration

- Mavic HDMI 1920x1080@30fps
- Magewell HDMI to USB 1920x1080p@60fps

Setting for DeepStream Reference Application - deepstream-app in [C] and [D]

