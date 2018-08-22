FROM golang:latest

EXPOSE 1234

ENV \
    VAULT_ADDR \
    VAULT_TOKEN

RUN \
apk add --no-cache ca-certificates ;\
mkdir -p /opt/supersecret/static

COPY ./ $GOPATH/src/sup3rs3cretMes5age/

RUN go get -u github.com/golang/dep/cmd/dep

WORKDIR $GOPATH/src/sup3rs3cretMes5age/
RUN dep ensure -v
ARG CGO_ENABLED=0
ARG GOOS=linux
ARG GOARCH=amd64
RUN go build -o bin/sup3rs3cretMes5age

WORKDIR /opt/supersecret

RUN cp $GOPATH/src/sup3rs3cretMes5age/bin/sup3rs3cretMes5age /opt/supersecret
COPY static /opt/supersecret/static

RUN rm -rf $GOPATH/src/sup3rs3cretMes5age/

CMD [ "./sup3rs3cretMes5age" ]
