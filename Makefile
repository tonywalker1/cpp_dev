# MIT License
#
# Copyright (c) 2019, 2020 Tony Walker
#
# Permission is hereby granted, free of charge, to any person obtaining a copy
# of this software and associated documentation files (the "Software"), to deal
# in the Software without restriction, including without limitation the rights
# to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
# copies of the Software, and to permit persons to whom the Software is
# furnished to do so, subject to the following conditions:
#
# The above copyright notice and this permission notice shall be included in all
# copies or substantial portions of the Software.
#
# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
# IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
# FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
# AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
# LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
# OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
# SOFTWARE.

NAME=cpp_dev

.PHONY: all
all:
	docker volume create cpp_build
	-docker rmi $(NAME)
	docker build \
		--build-arg NAME=$(NAME) \
	    -t $(NAME) \
	    -f ./scripts/Dockerfile.dev \
	    ./scripts/

.PHONY: configure
configure:
	@echo "*** Generating links in rc.d ***"
	@echo "*** Edit links in rc.d before building the container ****"
	@mkdir -p scripts/rc.d/$(NAME)
	@cd scripts/rc.d/$(NAME) && ln -sf ../../install.d/* .

.PHONY: install
install:
	install -m 755 scripts/shell/run_cpp_dev.sh       /usr/local/bin
	install -m 755 scripts/shell/delete_all_images.sh /usr/local/bin

.PHONY: clean
clean:
	-docker rmi $(NAME)
	rm -rf scripts/rc.d/$(NAME)
