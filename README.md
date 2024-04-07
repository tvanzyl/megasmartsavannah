# Resources 

https://github.com/microsoft/CameraTraps/tree/main

https://docs.ultralytics.com/yolov5/tutorials/running_on_jetson_nano/#install-pytorch-and-torchvision

https://developer.nvidia.com/embedded/jetpack

[E] https://github.com/NVIDIA/TensorRT

https://catalog.ngc.nvidia.com/orgs/nvidia/collections/deepstream_sdk
[B] https://catalog.ngc.nvidia.com/orgs/nvidia/containers/deepstream
[A] https://docs.nvidia.com/metropolis/deepstream/dev-guide/text/DS_Quickstart.html#
[C] https://docs.nvidia.com/metropolis/deepstream/dev-guide/text/DS_ref_app_deepstream.html
[D] https://docs.nvidia.com/metropolis/deepstream/dev-guide/text/DS_plugin_gst-nvinfer.html

[F] https://docs.nvidia.com/deeplearning/tensorrt/quick-start-guide/index.html
[G] https://docs.nvidia.com/deeplearning/tensorrt/developer-guide/index.html#trtexec-flags

[H] https://github.com/marcoslucianops/DeepStream-Yolo/tree/master

[I] https://github.com/marcoslucianops/DeepStream-Yolo/blob/master/docs/YOLOv5.md

# Workflow

To create onnx file from your yolov5 checkpoint please follow the following steps [I]

Install TensorRT 8.6.1 on host [A] and [E]

Convert ONNX to .engine using trtexec [F] and setting in [G]
`trtexec --fp16 --optShapes --onnx=MDV5A.onnx --saveEngine=model_b1_gpu0_fp16.engine`

Build the docker image
`$make build` 

Push the image to doker hub
`$make push`

# Configuration


