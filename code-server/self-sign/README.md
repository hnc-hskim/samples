
## Dockerfile example
```
FROM debian:wheezy

RUN apt-get update && \
    apt-get install -y openssl

COPY generate-certificate.sh /tmp/generate-certificate.sh

CMD [ "/tmp/generate-certificate.sh" ]
```