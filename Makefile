IMAGE_NAME := picore
IMAGE_TAG := 8.0-armv7
TMP_IMAGE_NAME := $(IMAGE_NAME)-tar-builder
TMP_CONTAINER_NAME := $(IMAGE_NAME)-tar-exporter

.PHONY: all build stop clean

all: build

build: 8.0v7.tgz
	docker build -t $(IMAGE_NAME):$(IMAGE_TAG) .

8.0v7.tgz: squashfs-tools.tar.gz
	docker run -d --privileged -v $(shell pwd)/src:/tmp --name $(TMP_CONTAINER_NAME) hypriot/armhf-busybox sleep 180
	docker start $(TMP_CONTAINER_NAME)
	docker exec -i $(TMP_CONTAINER_NAME) /bin/sh -c /tmp/build_8.0v7.sh
	mv src/8.0v7.tgz .
	docker kill $(TMP_CONTAINER_NAME)
	docker rm $(TMP_CONTAINER_NAME)
	
squashfs-tools.tar.gz:
	docker run -d --privileged --name $(TMP_CONTAINER_NAME) hypriot/armhf-busybox sleep 180
	docker start $(TMP_CONTAINER_NAME)
	docker exec -i $(TMP_CONTAINER_NAME) /bin/sh -c 'cat > /tmp/build_squashfs_tools.sh; /bin/sh /tmp/build_squashfs_tools.sh' < src/build_squashfs_tools.sh > squashfs-tools.tar.gz
	docker exec $(TMP_CONTAINER_NAME) umount /mnt
	docker kill $(TMP_CONTAINER_NAME)
	docker rm $(TMP_CONTAINER_NAME)

clean:
	docker ps | grep -q $(TMP_CONTAINER_NAME) && docker stop $(TMP_CONTAINER_NAME) || true
	docker ps -a | grep -q $(TMP_CONTAINER_NAME) && docker rm $(TMP_CONTAINER_NAME) || true
	docker images $(IMAGE_NAME) | grep -q $(IMAGE_TAG) && docker rmi $(IMAGE_NAME):$(IMAGE_TAG) || true
	docker images | grep -q $(TMP_IMAGE_NAME) && docker rmi $(TMP_IMAGE_NAME) || true
	rm -f squashfs-tools.tar.gz 8.0v7.tgz

