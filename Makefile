BINARY=k8guard-report

VERSION=`git fetch;git describe --tags`
BUILD=`date +%FT%T%z`

LDFLAGS=-ldflags "-X main.Version=${VERSION} -X main.Build=${BUILD}"


deps:
	glide install

glide-update:
	glide cc
	glide update

build-docker:
	docker build -t local/k8guard-report .

build:
	CGO_ENABLED=0 GOOS=linux GOARCH=amd64 go build ${LDFLAGS} -o ${BINARY}

mac:
	CGO_ENABLED=0 GOOS=darwin GOARCH=amd64 go build ${LDFLAGS} -o ${BINARY}

dev-setup:
	ln -s $(pwd)/hooks/pre-commit .git/hooks/pre-commit

clean:
	if [ -f ${BINARY} ] ; then rm ${BINARY} ; fi
	go clean

sclean: clean
	rm glide.lock


.PHONY: build
