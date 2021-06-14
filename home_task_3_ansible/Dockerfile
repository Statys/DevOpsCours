FROM ghcr.io/linuxserver/openssh-server
RUN apk update
RUN apk add python3
RUN apk add openrc --no-cache
RUN mkdir /run/nginx/
RUN mkdir /run/openrc/
RUN touch /run/openrc/softlevel