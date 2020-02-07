
NAME=cpp_dev

.PHONY: container
container:
	docker volume create cpp_build
	-docker rmi $(NAME)
	docker build \
	    -t $(NAME) \
	    -f ./scripts/Dockerfile.dev \
	    ./scripts/

.PHONY: links
links:
	@echo "*** Generating links in rc.d ***"
	@echo "*** Edit links in rc.d before building the container ****"
	@mkdir scripts/rc.d/$(NAME)
	@cd scripts/rc.d/$(NAME) && ln -sf ../install.d/* .

.PHONY: install
install:
	install -m 755 run_cpp_dev.sh /usr/local/bin
