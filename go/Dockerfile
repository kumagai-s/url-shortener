FROM golang:1.19-alpine

RUN apk update && apk add --no-cache sudo gcc musl-dev openssh git

RUN go install golang.org/x/tools/gopls@latest