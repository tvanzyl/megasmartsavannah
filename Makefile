processor := `uname -p`

all: rmi build push

clean:
	rm *.engine

rmi:
	docker rmi tvanzyl/megasmartsavannah:$(processor)

build: assets/model_b1_gpu0_fp16.engine	
	docker build -t tvanzyl/megasmartsavannah:$(processor) .

push:
	docker push tvanzyl/megasmartsavannah:$(processor)

model_b1_gpu0_fp16.engine: MDV5A.onnx
	/usr/src/tensorrt/bin/trtexec --fp16 --optShapes --onnx=MDV5A.onnx --saveEngine=assets/model_b1_gpu0_fp16.engine