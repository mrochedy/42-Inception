FROM debian:bullseye

RUN apt-get update -y && \
	apt-get install -y wget && \
	apt-get clean && rm -rf /var/lib/apt/lists/*

COPY ./conf/adminer-config.sh /adminer-config.sh

RUN chmod +x /adminer-config.sh && \
	mkdir -p /var/www/web

WORKDIR /var/www/web

ENTRYPOINT ["/adminer-config.sh"]
