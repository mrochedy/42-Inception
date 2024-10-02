FROM debian:bullseye-slim

RUN apt-get update && \
	apt-get install -y curl php php7.4-fpm php-mysql mariadb-client netcat && \
	apt-get clean && rm -rf /var/lib/apt/lists/*

COPY --chmod=+x ./conf/wp_conf.sh /wp_conf.sh

CMD ["/wp_conf.sh"]
