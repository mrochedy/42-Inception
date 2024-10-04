FROM debian:bullseye-slim

RUN apt-get update && \
	apt-get install -y curl php php7.4-fpm php-mysql mariadb-client netcat && \
	apt-get clean && rm -rf /var/lib/apt/lists/*

COPY ./conf/wordpress-config.sh /wordpress-config.sh

RUN chmod +x /wordpress-config.sh

ENTRYPOINT ["bash", "/wordpress-config.sh"]
