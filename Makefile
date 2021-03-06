VERSION=0.2.0
LDFLAGS=-ldflags "-X main.Version=${VERSION}"

all: mackerel-plugin-axslog

.PHONY: mackerel-plugin-axslog

bundle:
	dep ensure

update:
	dep ensure -update

mackerel-plugin-axslog: main.go
	go build $(LDFLAGS) -o mackerel-plugin-axslog

linux: main.go
	GOOS=linux GOARCH=amd64 go build $(LDFLAGS) -o mackerel-plugin-axslog

check:
	go test ./...

fmt:
	go fmt ./...

tag:
	git tag v${VERSION}
	git push origin v${VERSION}
	git push origin master
	goreleaser --rm-dist
