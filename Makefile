#
# Docker Build Variables
#

BUILD_ARGS ?=

ifneq (x${no_proxy}x,xx)
BUILD_ARGS += --build-arg no_proxy=${no_proxy}
endif
ifneq (x${NO_PROXY}x,xx)
BUILD_ARGS += --build-arg NO_PROXY=${NO_PROXY}
endif

ifneq (x${ftp_proxy}x,xx)
BUILD_ARGS += --build-arg ftp_proxy=${ftp_proxy}
endif
ifneq (x${FTP_PROXY}x,xx)
BUILD_ARGS += --build-arg FTP_PROXY=${FTP_PROXY}
endif

ifneq (x${http_proxy}x,xx)
BUILD_ARGS += --build-arg http_proxy=${http_proxy}
endif
ifneq (x${HTTP_PROXY}x,xx)
BUILD_ARGS += --build-arg HTTP_PROXY=${HTTP_PROXY}
endif

ifneq (x${https_proxy}x,xx)
BUILD_ARGS += --build-arg https_proxy=${https_proxy}
endif
ifneq (x${HTTPS_PROXY}x,xx)
BUILD_ARGS += --build-arg HTTPS_PROXY=${HTTPS_PROXY}
endif

#
# Docker Run Variables
#

RUN_ARGS ?= env NGINX_BRANCH=$(NGINX_BRANCH) MRUBY_VERSION=$(MRUBY_VERSION) NGX_MRUBY_VERSION=$(NGX_MRUBY_VERSION)

#
# Default Rules
#

.PHONY: all
all: up

#
# Build Rules
#

.PHONY: build
build:

#
# Test Rules
#

.PHONY: up
up: down
	@$(RUN_ARGS) docker-compose up -d

.PHONY: down
down:
ifneq (x$(shell docker-compose --log-level ERROR ps -q),x)
	@docker-compose down
endif

.PHONY: restart
restart:
	@docker restart -t 1 nginx-mruby-s3-proxy

#
# Clean Rules
#

.PHONY: clean
clean: down
	@docker system prune -f
	@docker volume prune -f
