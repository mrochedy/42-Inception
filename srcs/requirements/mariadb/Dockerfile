FROM debian:bullseye-slim

RUN apt-get update && \
	apt-get install -y mariadb-server && \
	apt-get clean && rm -rf /var/lib/apt/lists/*

COPY --chmod=+x ./conf/mdb-conf.sh /mdb-conf.sh

CMD ["/mdb-conf.sh"]
