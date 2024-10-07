FROM debian:bullseye

RUN apt-get update -y &&  \
	apt-get install -y wget docker.io tar && \
	apt-get clean && rm -rf /var/lib/apt/lists/*

WORKDIR /var/www/web

RUN wget https://github.com/portainer/portainer/releases/download/2.21.2/portainer-2.21.2-linux-amd64.tar.gz && \
	tar -xzf portainer-2.21.2-linux-amd64.tar.gz && \
	rm portainer-2.21.2-linux-amd64.tar.gz

CMD ["/var/www/web/portainer/portainer", "-H", "unix:///var/run/docker.sock"]
