ANSIBLE :=
PYTHON  :=

IMAGE := sunaoka/ansible

PLATFORM := linux/arm64,linux/amd64

BUILDER := docker-ansible-builder

BUILDER_ARGS := --build-arg ANSIBLE=$(ANSIBLE) --build-arg PYTHON=$(PYTHON) -t $(IMAGE):$(ANSIBLE) -t $(IMAGE):$(basename $(ANSIBLE))

all:
	bash $(CURDIR)/build.sh

setup:
	(docker buildx ls | grep $(BUILDER)) || docker buildx create --name $(BUILDER)

build: setup
	docker buildx use $(BUILDER)
	docker buildx build --rm --platform $(PLATFORM) $(BUILDER_ARGS) --push .
	docker buildx rm $(BUILDER)

.PHONY: all setup build
