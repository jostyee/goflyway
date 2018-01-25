FROM golang as build

LABEL maintainer="jostyee <jostyee@gmail.com>"

RUN mkdir -p /go/src/goflyway
COPY . /go/src/goflyway

WORKDIR /go/src/goflyway

RUN cd cmd/goflyway && go-wrapper download \
    && cd - \
    && CGO_ENABLED=0 make build

ENTRYPOINT ["bash"]

FROM scratch

COPY --from=build /go/src/goflyway/build/goflyway /goflyway

EXPOSE 8100 8101

CMD ["/goflyway","-c","/goflyway.conf"]
