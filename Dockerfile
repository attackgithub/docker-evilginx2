FROM golang:stretch

RUN cd /go \
    && go get -u -v github.com/kgretzky/evilginx2 \
    && cd src/github.com/kgretzky/evilginx2/ \
    && make

ADD . /go/

RUN ./bin/evilginx2 -p ./phishlets/

CMD [ "/go/bin/evilginx2", "-p", "/go/phishlets/" ]