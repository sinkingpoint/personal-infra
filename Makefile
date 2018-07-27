base-image:
	docker build -t chef-base ${CURDIR}

run: base-image
	docker run -it --rm --entrypoint /bin/bash chef-base || true

