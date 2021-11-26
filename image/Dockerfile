FROM alpine:3.13.3
RUN apk update && apk add iputils curl bash && rm -rf /var/cache/apk/*
WORKDIR /app
COPY fast .
COPY upload.sh get-latency.sh ./
