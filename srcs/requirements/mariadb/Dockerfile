FROM debian:bullseye-slim

RUN apt-get update && \
	apt-get install -y mariadb-server && \
	apt-get clean && rm -rf /var/lib/apt/lists/*

COPY ./conf/mariadb-config.sh /mariadb-config.sh

RUN chmod +x /mariadb-config.sh

ENTRYPOINT ["bash", "/mariadb-config.sh"]
