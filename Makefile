IMAGE_NAME="ebuildy/consul"
CONTAINER_NAME="dev_consul"

build:
	docker build -t $(IMAGE_NAME) .

run:
	docker run -d -ti -v $(PWD)/example/config:/config:ro -p 8500:8500 -p 53:53 --name=$(CONTAINER_NAME) $(IMAGE_NAME) -server -bootstrap -ui-dir /ui

console:
	docker exec -ti $(CONTAINER_NAME) /bin/bash

logs:
	docker logs -f $(CONTAINER_NAME)

destroy:
	docker rm -f $(CONTAINER_NAME)