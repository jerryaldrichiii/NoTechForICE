FROM node:25-alpine

RUN apk add --no-cache \
    git \
    openssh \
    bash

RUN mkdir -p /root/.ssh \
    && ssh-keyscan github.com >> /root/.ssh/known_hosts \
    && chmod 700 /root/.ssh \
    && chmod 644 /root/.ssh/known_hosts

WORKDIR /app

SHELL ["/bin/bash", "-l", "-c"]

# Install as late as possible because layers
RUN npm install -g github-spray

COPY entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh

SHELL ["/bin/bash", "-l", "-c"]

# Yes this runs as root...I'm lazy. It is a glorified script. PRs welcome <3

ENTRYPOINT ["/entrypoint.sh"]

