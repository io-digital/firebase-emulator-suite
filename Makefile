
.PHONY: build
build:
	docker build -t ghcr.io/io-digital/firebase-emulator-suite src

.PHONY: push
push:
	docker push ghcr.io/io-digital/firebase-emulator-suite
