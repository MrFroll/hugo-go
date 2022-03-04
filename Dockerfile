FROM ubuntu:21.04

ARG hugo_version=0.92.2
ARG golang_version=1.17.7.linux-amd64

ARG HUGO_BINARY=hugo_extended_${hugo_version}_Linux-64bit.deb
ARG GO_BINARY=go${golang_version}.tar.gz
ENV PATH="/usr/local/go/bin:${PATH}"

WORKDIR /web

RUN apt update \
    && apt -y install curl git

RUN curl -sL -o /tmp/golang.tar.gz https://go.dev/dl/go1.17.7.linux-amd64.tar.gz \
    && rm -rf /usr/local/go && tar -C /usr/local -xzf /tmp/golang.tar.gz

RUN curl -sL -o /tmp/hugo.deb https://github.com/gohugoio/hugo/releases/download/v${hugo_version}/${HUGO_BINARY} \
    && dpkg -i /tmp/hugo.deb \
    && rm /tmp/hugo.deb

RUN mkdir /root/.ssh

CMD if [ -z "$SSH_KEY" ] ; then echo SSH key not provided ; else echo $SSH_KEY > /root/.ssh/id_rsa  ; fi