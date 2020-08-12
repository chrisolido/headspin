FROM alpine:3.4
RUN apk update && \
    apk add curl && \
    apk add git && \
    apk add vim