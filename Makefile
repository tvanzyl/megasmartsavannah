processor := `uname -p`

all: rmi build push

clean:
	rm *.engine

rmi:
	docker rmi tvanzyl/megasmartsavannah:$(processor)_int8

build: assets/model_b1_gpu0_fp16.engine assets/model_b1_gpu0_int8.engine
	docker build -t tvanzyl/megasmartsavannah:$(processor)_int8 .

# push:
# 	docker push tvanzyl/megasmartsavannah:$(processor)_int8 

assets/model_b1_gpu0_fp16.engine: assets/MDV5A_batch_1.onnx
	/usr/src/tensorrt/bin/trtexec --fp16 --optShapes --onnx=assets/MDV5A_batch_1.onnx --saveEngine=assets/model_b1_gpu0_fp16.engine

assets/model_b1_gpu0_int8.engine: assets/MDV5A_batch_1.onnx
	/usr/src/tensorrt/bin/trtexec --int8 --calib=assets/best_calibration.table --optShapes --onnx=assets/MDV5A_batch_1.onnx--saveEngine=assets/model_b1_gpu0_int8.engine
