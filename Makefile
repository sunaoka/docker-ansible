ANSIBLE :=
PYTHON  :=

IMAGE := sunaoka/ansible

PLATFORM := linux/arm64,linux/amd64

BUILDER := docker-ansible-builder-$(ANSIBLE)

BUILDER_ARGS := --build-arg ANSIBLE=$(ANSIBLE) --build-arg PYTHON=$(PYTHON) -t $(IMAGE):$(ANSIBLE) -t $(IMAGE):$(basename $(ANSIBLE))

LATEST_ARGS :=

all: 2.16 2.17

2.13:
	$(MAKE) build ANSIBLE="2.13.13" PYTHON="3.10"

2.14:
	$(MAKE) build ANSIBLE="2.14.16" PYTHON="3.11"

2.15:
	$(MAKE) build ANSIBLE="2.15.12" PYTHON="3.11"

2.16:
	$(MAKE) build ANSIBLE="2.16.10" PYTHON="3.12"

2.17:
	$(MAKE) build ANSIBLE="2.17.3" PYTHON="3.12" LATEST_ARGS="-t $(IMAGE):latest"

setup:
	(docker buildx ls | grep $(BUILDER)) || docker buildx create --name $(BUILDER)

build: setup
	docker buildx use $(BUILDER)
	docker buildx build --rm --platform $(PLATFORM) $(BUILDER_ARGS) $(LATEST_ARGS) --push .
	docker buildx rm $(BUILDER)

.PHONY: all setup build
