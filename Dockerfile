FROM ubuntu:22.04

ARG hugo_version=0.120.4
ARG golang_distro=go1.21.4.linux-amd64.tar.gz

ARG HUGO_BINARY=hugo_extended_${hugo_version}_linux-amd64.deb
ENV PATH="/usr/local/go/bin:${PATH}"

WORKDIR /web

RUN apt update \
    && apt -y install curl git

RUN curl -sL -o /tmp/golang.tar.gz https://go.dev/dl/${golang_distro} \
    && rm -rf /usr/local/go && tar -C /usr/local -xzf /tmp/golang.tar.gz

RUN curl -sL -o /tmp/hugo.deb https://github.com/gohugoio/hugo/releases/download/v${hugo_version}/${HUGO_BINARY} \
    && dpkg -i /tmp/hugo.deb \
    && rm /tmp/hugo.deb

RUN mkdir /root/.ssh

CMD echo "start"