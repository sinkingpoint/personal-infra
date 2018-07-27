include ../Makefile

image: base-image
	docker build -t db .

run: image
	docker run -it --rm --entrypoint /bin/bash db || true
