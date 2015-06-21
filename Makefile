IMAGE_NAME="ebuildy/consul"
CONTAINER_NAME="dev_consul"

build:
	docker build -t $(IMAGE_NAME) .

run:
	docker run -d -ti -p 139:139 -p 138:138 -p 445:445 --name=$(CONTAINER_NAME) $(IMAGE_NAME)

logs:
	docker logs -f $(CONTAINER_NAME)

destroy:
	docker rm -f $(CONTAINER_NAME)