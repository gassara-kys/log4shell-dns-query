SRC := $(shell ls *.go | grep -v '_test.go')
PROJECT := 'log4shell-scan-call'

.PHONY: all
all: run

.PHONY: install
install:
	go get -u github.com/okzk/go-lambda-runner

.PHONY: tidy
tidy: $(SRC)
	go mod tidy

.PHONY: fmt
fmt: $(SRC)
	go fmt

.PHONY: test
test: fmt
	go test -v ./...

.PHONY: run
run: install test
	source env.sh && \
	go-lambda-runner go run $(SRC)

.PHONY: build
build: test
	$(shell GOOS=linux GOARCH=amd64 go build -v -ldflags='-d -s -w'  -a -tags netgo -installsuffix netgo -o bin/$(PROJECT) -v $(SRC) )

.PHONY: zip
zip: build
	cd bin && zip -9 $(PROJECT).zip $(PROJECT)
