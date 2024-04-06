processor := `uname -p`

all: clean build push

clean:
	rm *.engine

build: model_b1_gpu0_fp16.engine
	docker build -t tvanzyl/megasmartsavannah:$(processor) .

push: build
	docker push tvanzyl/megasmartsavannah:$(processor)

model_b1_gpu0_fp16.engine: MDV5A.onnx
	/usr/src/tensorrt/bin/trtexec --fp16 --optShapes --onnx=MDV5A.onnx --saveEngine=model_b1_gpu0_fp16.engine